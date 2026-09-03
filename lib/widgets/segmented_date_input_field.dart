import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SegmentedDateInputField extends StatefulWidget {
  final String label;
  final DateTime? initialDate;
  final String pattern; // 'dd/MM/yyyy', 'MM/dd/yyyy', 'yyyy-MM-dd'
  final ValueChanged<DateTime?> onDateChanged;

  const SegmentedDateInputField({
    super.key,
    required this.label,
    this.initialDate,
    required this.pattern,
    required this.onDateChanged,
  });

  @override
  State<SegmentedDateInputField> createState() => _SegmentedDateInputFieldState();
}

class _SegmentedDateInputFieldState extends State<SegmentedDateInputField> {
  late TextEditingController _dayCtrl;
  late TextEditingController _monthCtrl;
  late TextEditingController _yearCtrl;

  late FocusNode _dayFocus;
  late FocusNode _monthFocus;
  late FocusNode _yearFocus;

  @override
  void initState() {
    super.initState();
    _dayCtrl = TextEditingController();
    _monthCtrl = TextEditingController();
    _yearCtrl = TextEditingController();

    _dayFocus = FocusNode();
    _monthFocus = FocusNode();
    _yearFocus = FocusNode();

    _updateFromDate(widget.initialDate);
  }

  @override
  void didUpdateWidget(covariant SegmentedDateInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate && widget.initialDate != _parseCurrentDate()) {
      _updateFromDate(widget.initialDate);
    }
  }

  void _updateFromDate(DateTime? date) {
    if (date == null) {
      _dayCtrl.clear();
      _monthCtrl.clear();
      _yearCtrl.clear();
      return;
    }
    _dayCtrl.text = date.day.toString().padLeft(2, '0');
    _monthCtrl.text = date.month.toString().padLeft(2, '0');
    _yearCtrl.text = date.year.toString();
  }

  @override
  void dispose() {
    _dayCtrl.dispose();
    _monthCtrl.dispose();
    _yearCtrl.dispose();

    _dayFocus.dispose();
    _monthFocus.dispose();
    _yearFocus.dispose();
    super.dispose();
  }

  DateTime? _parseCurrentDate() {
    final dayStr = _dayCtrl.text.trim();
    final monthStr = _monthCtrl.text.trim();
    final yearStr = _yearCtrl.text.trim();

    if (dayStr.isNotEmpty && monthStr.isNotEmpty && yearStr.length == 4) {
      final day = int.tryParse(dayStr);
      final month = int.tryParse(monthStr);
      final year = int.tryParse(yearStr);

      if (day != null && month != null && year != null) {
        if (month >= 1 && month <= 12 && day >= 1 && day <= 31 && year >= 1900 && year <= 2100) {
          try {
            return DateTime(year, month, day);
          } catch (_) {}
        }
      }
    }
    return null;
  }

  void _checkAndEmitDate() {
    final parsed = _parseCurrentDate();
    if (parsed != null) {
      widget.onDateChanged(parsed);
    } else if (_dayCtrl.text.isEmpty && _monthCtrl.text.isEmpty && _yearCtrl.text.isEmpty) {
      widget.onDateChanged(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMdy = widget.pattern.startsWith('MM');
    final isYmd = widget.pattern.startsWith('yyyy');

    Widget dayBox() => SizedBox(
          width: 54,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace && _dayCtrl.text.isEmpty) {
                if (isMdy) {
                  _monthFocus.requestFocus();
                } else if (isYmd) {
                  _monthFocus.requestFocus();
                }
              }
            },
            child: TextField(
              controller: _dayCtrl,
              focusNode: _dayFocus,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: const InputDecoration(
                labelText: 'DD',
                hintText: 'DD',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              ),
              onChanged: (val) {
                if (val.length == 2) {
                  if (isMdy) {
                    _yearFocus.requestFocus();
                  } else {
                    _monthFocus.requestFocus();
                  }
                }
                _checkAndEmitDate();
              },
            ),
          ),
        );

    Widget monthBox() => SizedBox(
          width: 54,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace && _monthCtrl.text.isEmpty) {
                if (isMdy) {
                  // No previous field
                } else if (isYmd) {
                  _yearFocus.requestFocus();
                } else {
                  _dayFocus.requestFocus();
                }
              }
            },
            child: TextField(
              controller: _monthCtrl,
              focusNode: _monthFocus,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: const InputDecoration(
                labelText: 'MM',
                hintText: 'MM',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              ),
              onChanged: (val) {
                if (val.length == 2) {
                  if (isYmd) {
                    _dayFocus.requestFocus();
                  } else {
                    _yearFocus.requestFocus();
                  }
                }
                _checkAndEmitDate();
              },
            ),
          ),
        );

    Widget yearBox() => SizedBox(
          width: 72,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace && _yearCtrl.text.isEmpty) {
                if (isYmd) {
                  // No previous field
                } else {
                  _monthFocus.requestFocus();
                }
              }
            },
            child: TextField(
              controller: _yearCtrl,
              focusNode: _yearFocus,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              decoration: const InputDecoration(
                labelText: 'YYYY',
                hintText: 'YYYY',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              ),
              onChanged: (val) {
                _checkAndEmitDate();
              },
            ),
          ),
        );

    List<Widget> boxes;
    final sep = isYmd ? '-' : '/';
    if (isYmd) {
      boxes = [yearBox(), Text(sep, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)), monthBox(), Text(sep, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)), dayBox()];
    } else if (isMdy) {
      boxes = [monthBox(), Text(sep, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)), dayBox(), Text(sep, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)), yearBox()];
    } else {
      boxes = [dayBox(), Text(sep, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)), monthBox(), Text(sep, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)), yearBox()];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Text(
                  widget.label,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[800]),
                ),
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...boxes.map((b) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: b,
                    )),
                const SizedBox(width: 4),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () async {
                    final current = _parseCurrentDate();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: current ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        _updateFromDate(picked);
                      });
                      widget.onDateChanged(picked);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(Icons.calendar_today, size: 20, color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
