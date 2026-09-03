import 'package:flutter/services.dart';

/// Formatter that automatically formats digits into date format (e.g. 15051990 -> 15/05/1990)
/// without requiring the user to type slashes ('/') or dashes ('-').
class DateAutoFormatTextInputFormatter extends TextInputFormatter {
  final String pattern;

  DateAutoFormatTextInputFormatter({this.pattern = 'dd/MM/yyyy'});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final digits = text.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) {
      return const TextEditingValue(text: '');
    }

    String formatted = '';
    final isYmd = pattern.startsWith('yyyy');
    final separator = pattern.contains('-') ? ' - ' : ' / ';

    if (isYmd) {
      // yyyy - MM - dd
      if (digits.length <= 4) {
        formatted = digits;
      } else if (digits.length <= 6) {
        formatted = '${digits.substring(0, 4)}$separator${digits.substring(4)}';
      } else {
        final year = digits.substring(0, 4);
        final month = digits.substring(4, 6);
        final day = digits.substring(6, digits.length > 8 ? 8 : digits.length);
        formatted = '$year$separator$month$separator$day';
      }
    } else {
      // dd / MM / yyyy or MM / dd / yyyy
      if (digits.length <= 2) {
        formatted = digits;
      } else if (digits.length <= 4) {
        formatted = '${digits.substring(0, 2)}$separator${digits.substring(2)}';
      } else {
        final part1 = digits.substring(0, 2);
        final part2 = digits.substring(2, 4);
        final year = digits.substring(4, digits.length > 8 ? 8 : digits.length);
        formatted = '$part1$separator$part2$separator$year';
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
