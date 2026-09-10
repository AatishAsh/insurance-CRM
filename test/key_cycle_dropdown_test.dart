import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:customer_detail_management/widgets/key_cycle_dropdown.dart';

void main() {
  testWidgets('KeyCycleDropdownFormField letter cycling closed & open', (WidgetTester tester) async {
    String? selectedValue = 'Apple';
    final items = const ['Apple', 'Banana', 'Avocado', 'Cherry'].map((e) {
      return DropdownMenuItem<String>(value: e, child: Text(e));
    }).toList();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return KeyCycleDropdownFormField<String>(
                value: selectedValue,
                items: items,
                onChanged: (val) {
                  setState(() {
                    selectedValue = val;
                  });
                },
              );
            },
          ),
        ),
      ),
    );

    // Initial state
    expect(find.text('Apple'), findsOneWidget);

    // Focus the dropdown
    await tester.tap(find.text('Apple'));
    await tester.pumpAndSettle();

    // Type 'a' while open to cycle matching options ('Apple' -> 'Avocado' -> 'Apple')
    await tester.sendKeyEvent(LogicalKeyboardKey.keyA);
    await tester.pumpAndSettle();
    expect(selectedValue, equals('Avocado'));

    await tester.sendKeyEvent(LogicalKeyboardKey.keyA);
    await tester.pumpAndSettle();
    expect(selectedValue, equals('Apple'));

    // Type 'c' to jump to 'Cherry'
    await tester.sendKeyEvent(LogicalKeyboardKey.keyC);
    await tester.pumpAndSettle();
    expect(selectedValue, equals('Cherry'));

    // Press enter to close overlay
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();

    expect(selectedValue, equals('Cherry'));
  });
}
