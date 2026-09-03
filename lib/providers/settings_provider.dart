import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

const String kDateFormatKey = 'app_date_format_pattern';

class DateFormatOption {
  final String pattern;
  final String label;
  final String example;

  const DateFormatOption({
    required this.pattern,
    required this.label,
    required this.example,
  });
}

const List<DateFormatOption> kDateFormatOptions = [
  DateFormatOption(pattern: 'dd/MM/yyyy', label: 'DD/MM/YYYY (e.g. 15/05/1990)', example: '15/05/1990'),
  DateFormatOption(pattern: 'MM/dd/yyyy', label: 'MM/DD/YYYY (e.g. 05/15/1990)', example: '05/15/1990'),
  DateFormatOption(pattern: 'yyyy-MM-dd', label: 'YYYY-MM-DD (e.g. 1990-05-15)', example: '1990-05-15'),
  DateFormatOption(pattern: 'dd MMM yyyy', label: 'DD MMM YYYY (e.g. 15 May 1990)', example: '15 May 1990'),
];

class DateFormatNotifier extends StateNotifier<String> {
  static const _storage = FlutterSecureStorage();

  DateFormatNotifier() : super('dd/MM/yyyy') {
    _loadPattern();
  }

  void _loadPattern() async {
    try {
      final val = await _storage.read(key: kDateFormatKey);
      if (val != null && val.isNotEmpty) {
        state = val;
      }
    } catch (_) {}
  }

  Future<void> setPattern(String newPattern) async {
    state = newPattern;
    try {
      await _storage.write(key: kDateFormatKey, value: newPattern);
    } catch (_) {}
  }
}

final dateFormatPatternProvider = StateNotifierProvider<DateFormatNotifier, String>((ref) {
  return DateFormatNotifier();
});

final appDateFormatterProvider = Provider<DateFormat>((ref) {
  final pattern = ref.watch(dateFormatPatternProvider);
  return DateFormat(pattern);
});

DateTime? parseDateString(String input, String pattern) {
  final digits = input.replaceAll(RegExp(r'\D'), '');
  if (digits.length != 8) return null;
  try {
    int year, month, day;
    if (pattern.startsWith('yyyy')) {
      year = int.parse(digits.substring(0, 4));
      month = int.parse(digits.substring(4, 6));
      day = int.parse(digits.substring(6, 8));
    } else if (pattern.startsWith('MM')) {
      month = int.parse(digits.substring(0, 2));
      day = int.parse(digits.substring(2, 4));
      year = int.parse(digits.substring(4, 8));
    } else {
      day = int.parse(digits.substring(0, 2));
      month = int.parse(digits.substring(2, 4));
      year = int.parse(digits.substring(4, 8));
    }
    if (month >= 1 && month <= 12 && day >= 1 && day <= 31 && year >= 1900 && year <= 2100) {
      return DateTime(year, month, day);
    }
  } catch (_) {}
  return null;
}
