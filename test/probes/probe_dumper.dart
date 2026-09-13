import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Core inspection and serialization utility for test probes.
/// Dumps visual tree, text nodes, form fields, tables, chips, and semantics.
class ProbeDumper {
  static const String outputDirectory = 'build/probes';

  /// Ensures output directory exists.
  static void ensureOutputDirectory() {
    final dir = Directory(outputDirectory);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
  }

  /// Traverses tester.allWidgets and extracts structured tree information.
  static Map<String, dynamic> dumpWidgetTree(WidgetTester tester) {
    final List<Map<String, dynamic>> nodes = [];

    for (final element in tester.allElements) {
      final widget = element.widget;
      final renderObject = element.renderObject;
      final size = renderObject is RenderBox && renderObject.hasSize ? renderObject.size : null;
      final offset = renderObject is RenderBox && renderObject.attached
          ? renderObject.localToGlobal(Offset.zero)
          : null;

      final node = <String, dynamic>{
        'type': widget.runtimeType.toString(),
        'key': widget.key?.toString(),
      };

      if (size != null) {
        node['size'] = {'width': size.width, 'height': size.height};
      }
      if (offset != null) {
        node['offset'] = {'dx': offset.dx, 'dy': offset.dy};
      }

      if (widget is Text) {
        node['text'] = widget.data ?? widget.textSpan?.toPlainText();
      } else if (widget is RichText) {
        node['text'] = widget.text.toPlainText();
      } else if (widget is EditableText) {
        node['text'] = widget.controller.text;
      } else if (widget is Icon) {
        node['icon'] = widget.icon?.codePoint.toString();
      } else if (widget is Tooltip) {
        node['tooltip'] = widget.message;
      } else if (widget is FilterChip) {
        node['chipLabel'] = (widget.label as Text).data;
        node['selected'] = widget.selected;
      }

      nodes.add(node);
    }

    return {
      'timestamp': DateTime.now().toIso8601String(),
      'totalWidgets': nodes.length,
      'nodes': nodes,
    };
  }

  /// Collects all rendered strings in top-to-bottom, left-to-right order.
  static List<String> collectRenderedTexts(WidgetTester tester) {
    final List<_PositionedText> collected = [];

    for (final element in tester.allElements) {
      final widget = element.widget;
      String? text;

      if (widget is Text && widget.data != null && widget.data!.trim().isNotEmpty) {
        text = widget.data;
      } else if (widget is RichText) {
        final plain = widget.text.toPlainText().trim();
        if (plain.isNotEmpty) text = plain;
      } else if (widget is EditableText && widget.controller.text.trim().isNotEmpty) {
        text = widget.controller.text;
      }

      if (text != null) {
        Offset pos = Offset.zero;
        try {
          final ro = element.renderObject;
          if (ro is RenderBox && ro.attached) {
            pos = ro.localToGlobal(Offset.zero);
          }
        } catch (_) {}
        collected.add(_PositionedText(text, pos));
      }
    }

    // Sort top-to-bottom (dy), then left-to-right (dx)
    collected.sort((a, b) {
      final dyDiff = a.offset.dy.compareTo(b.offset.dy);
      if (dyDiff.abs() > 4) return dyDiff;
      return a.offset.dx.compareTo(b.offset.dx);
    });

    return collected.map((e) => e.text).toList();
  }

  /// Inspects all TextFormFields / TextFields on the screen.
  static List<Map<String, dynamic>> inspectFormFields(WidgetTester tester) {
    final List<Map<String, dynamic>> fields = [];

    final formFields = tester.widgetList<TextField>(find.byType(TextField));
    for (final field in formFields) {
      fields.add({
        'key': field.key?.toString(),
        'labelText': field.decoration?.labelText,
        'hintText': field.decoration?.hintText,
        'errorText': field.decoration?.errorText,
        'value': field.controller?.text,
        'obscureText': field.obscureText,
        'keyboardType': field.keyboardType?.toString(),
        'enabled': field.enabled ?? true,
        'maxLines': field.maxLines,
      });
    }

    return fields;
  }

  /// Inspects data tables and custom rows on the screen.
  static List<Map<String, dynamic>> inspectDataTables(WidgetTester tester) {
    final List<Map<String, dynamic>> tables = [];

    // Flutter Table widgets
    final standardTables = tester.widgetList<Table>(find.byType(Table));
    for (final table in standardTables) {
      final List<List<String>> rows = [];
      for (final row in table.children) {
        final List<String> cells = [];
        for (final child in row.children) {
          // Find text inside child
          String cellText = '';
          if (child is Text) {
            cellText = child.data ?? '';
          } else if (child is Padding && child.child is Text) {
            cellText = (child.child as Text).data ?? '';
          }
          cells.add(cellText);
        }
        rows.add(cells);
      }
      tables.add({
        'type': 'Table',
        'rowCount': rows.length,
        'rows': rows,
      });
    }

    // ListTiles inside ListView
    final listTiles = tester.widgetList<ListTile>(find.byType(ListTile));
    if (listTiles.isNotEmpty) {
      final List<Map<String, String>> tileData = [];
      for (final tile in listTiles) {
        final title = tile.title is Text ? (tile.title as Text).data ?? '' : '';
        final subtitle = tile.subtitle is Text ? (tile.subtitle as Text).data ?? '' : '';
        tileData.add({'title': title, 'subtitle': subtitle});
      }
      tables.add({
        'type': 'ListTiles',
        'count': tileData.length,
        'items': tileData,
      });
    }

    return tables;
  }

  /// Inspects FilterChip and SegmentedButton states.
  static List<Map<String, dynamic>> inspectChipsAndSegments(WidgetTester tester) {
    final List<Map<String, dynamic>> chips = [];

    final filterChips = tester.widgetList<FilterChip>(find.byType(FilterChip));
    for (final chip in filterChips) {
      final label = chip.label is Text ? (chip.label as Text).data ?? '' : '';
      chips.add({
        'type': 'FilterChip',
        'label': label,
        'selected': chip.selected,
      });
    }

    final choiceChips = tester.widgetList<ChoiceChip>(find.byType(ChoiceChip));
    for (final chip in choiceChips) {
      final label = chip.label is Text ? (chip.label as Text).data ?? '' : '';
      chips.add({
        'type': 'ChoiceChip',
        'label': label,
        'selected': chip.selected,
      });
    }

    return chips;
  }

  /// Dumps semantics and accessibility tree.
  static List<Map<String, dynamic>> dumpSemantics(WidgetTester tester) {
    final List<Map<String, dynamic>> semanticsList = [];

    for (final element in tester.allElements) {
      final widget = element.widget;
      if (widget is Tooltip) {
        semanticsList.add({
          'type': 'Tooltip',
          'message': widget.message,
        });
      } else if (widget is Semantics) {
        semanticsList.add({
          'type': 'Semantics',
          'label': widget.properties.label,
          'hint': widget.properties.hint,
          'value': widget.properties.value,
        });
      }
    }

    return semanticsList;
  }

  /// Writes probe output to build/probes/<name>.txt and build/probes/<name>.json.
  static void writeProbeReport(
    String probeName, {
    required String textReport,
    Map<String, dynamic>? structuredData,
  }) {
    ensureOutputDirectory();

    final txtFile = File('$outputDirectory/$probeName.txt');
    txtFile.writeAsStringSync(textReport);

    if (structuredData != null) {
      final jsonFile = File('$outputDirectory/$probeName.json');
      jsonFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(structuredData));
    }
  }

  /// Generates or updates build/probes/SUMMARY.md index.
  static void updateSummaryIndex(List<String> reportNames) {
    ensureOutputDirectory();
    final buffer = StringBuffer();
    buffer.writeln('# JJ CRM — Probe Harness Discovery Summary');
    buffer.writeln();
    buffer.writeln('Generated on: ${DateTime.now().toIso8601String()}');
    buffer.writeln();
    buffer.writeln('| Probe Report | Text Dump | Structured JSON |');
    buffer.writeln('|---|---|---|');

    for (final name in reportNames) {
      buffer.writeln('| `$name` | [`$name.txt`](./$name.txt) | [`$name.json`](./$name.json) |');
    }

    final summaryFile = File('$outputDirectory/SUMMARY.md');
    summaryFile.writeAsStringSync(buffer.toString());
  }
}

class _PositionedText {
  final String text;
  final Offset offset;
  _PositionedText(this.text, this.offset);
}
