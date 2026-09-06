import 'package:flutter/services.dart';

class AadhaarNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final truncated = digitsOnly.length > 12 ? digitsOnly.substring(0, 12) : digitsOnly;

    final buffer = StringBuffer();
    for (int i = 0; i < truncated.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(truncated[i]);
    }

    final formatted = buffer.toString();

    int selectionIndex = formatted.length;
    if (newValue.selection.end < newValue.text.length) {
      int digitCount = 0;
      for (int i = 0; i < newValue.selection.end && i < newValue.text.length; i++) {
        if (RegExp(r'\d').hasMatch(newValue.text[i])) {
          digitCount++;
        }
      }
      int newIndex = 0;
      int currentDigits = 0;
      while (newIndex < formatted.length && currentDigits < digitCount) {
        if (RegExp(r'\d').hasMatch(formatted[newIndex])) {
          currentDigits++;
        }
        newIndex++;
      }
      selectionIndex = newIndex;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
