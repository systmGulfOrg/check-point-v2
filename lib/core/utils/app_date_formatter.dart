import 'package:intl/intl.dart';

/// Centralized utility for formatting dates, times, and converting numerals strictly to English.
class AppDateFormatter {
  AppDateFormatter._();

  static const _arabicDigits = [
    '٠',
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩',
  ];
  static const _englishDigits = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];
  static const _persianDigits = [
    '۰',
    '۱',
    '۲',
    '۳',
    '۴',
    '۵',
    '۶',
    '۷',
    '۸',
    '۹',
  ];

  /// Converts any Eastern Arabic (٠-٩) or Persian (۰-۹) numerals in [input] to standard English digits (0-9).
  static String toEnglishDigits(String input) {
    var result = input;
    for (int i = 0; i < 10; i++) {
      result = result.replaceAll(_arabicDigits[i], _englishDigits[i]);
      result = result.replaceAll(_persianDigits[i], _englishDigits[i]);
    }
    return result;
  }

  /// Formats a [DateTime] with a given [pattern] strictly using the 'en' locale.
  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return toEnglishDigits(DateFormat(pattern, 'en').format(date));
  }

  /// E.g. "Sunday, 06 Sep 2026"
  static String formatFullDate(DateTime date) {
    return toEnglishDigits(DateFormat('EEEE, dd MMM yyyy', 'en').format(date));
  }

  /// E.g. "06 Sep 2026"
  static String formatMediumDate(DateTime date) {
    return toEnglishDigits(DateFormat('dd MMM yyyy', 'en').format(date));
  }

  /// E.g. "Sun, 06 Sep"
  static String formatShortDayMonth(DateTime date) {
    return toEnglishDigits(DateFormat('EEE, dd MMM', 'en').format(date));
  }

  /// E.g. "2026-09-06"
  static String formatYearMonthDay(DateTime date) {
    return toEnglishDigits(DateFormat('yyyy-MM-dd', 'en').format(date));
  }

  /// E.g. "06-09-2026"
  static String formatDayMonthYear(DateTime date) {
    return toEnglishDigits(DateFormat('dd-MM-yyyy', 'en').format(date));
  }

  /// E.g. "09:30 AM"
  static String formatTime(DateTime date) {
    return toEnglishDigits(DateFormat('hh:mm a', 'en').format(date));
  }

  /// E.g. "14:30"
  static String format24Time(DateTime date) {
    return toEnglishDigits(DateFormat('HH:mm', 'en').format(date));
  }

  /// Cleans raw time strings (e.g. "15:24:16.7019526" -> "03:24 PM" or "15:24").
  static String formatTimeString(String? rawTime, {bool use12Hour = true}) {
    if (rawTime == null ||
        rawTime.trim().isEmpty ||
        rawTime.startsWith('00:00:00') ||
        rawTime == '00:00' ||
        rawTime == '00:00:00.0000000') {
      return '--:--';
    }
    final cleaned = toEnglishDigits(rawTime.trim().split('.').first);
    final parts = cleaned.split(':');
    if (parts.length >= 2) {
      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1]);
      if (hour != null && minute != null) {
        if (use12Hour) {
          final period = hour >= 12 ? 'PM' : 'AM';
          final h12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
          final mStr = minute.toString().padLeft(2, '0');
          final hStr = h12.toString().padLeft(2, '0');
          return '$hStr:$mStr $period';
        } else {
          final hStr = hour.toString().padLeft(2, '0');
          final mStr = minute.toString().padLeft(2, '0');
          return '$hStr:$mStr';
        }
      }
    }
    return cleaned;
  }

  /// Normalizes and formats raw date strings into standard English digits.
  static String formatDateString(
    String? rawDate, {
    String pattern = 'yyyy-MM-dd',
  }) {
    if (rawDate == null || rawDate.trim().isEmpty) return '-';
    final parsed = DateTime.tryParse(toEnglishDigits(rawDate.trim()));
    if (parsed != null) {
      return formatDate(parsed, pattern: pattern);
    }
    return toEnglishDigits(rawDate.trim().split('T').first.split(' ').first);
  }

  /// Formats a raw 24-hour time string into 12-hour Arabic (ص / م). E.g. "14:30" -> "02:30 م"
  static String formatTime12HourArabic(String? rawTime) {
    final str = formatTimeString(rawTime, use12Hour: true);
    if (str == '--:--') return str;
    return str.replaceAll('AM', 'ص').replaceAll('PM', 'م');
  }
}
