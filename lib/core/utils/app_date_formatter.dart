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

  /// E.g. "09:30 AM", "09:30 ص", or "09:30 صباحاً"
  static String formatTime(
    DateTime date, {
    bool isArabic = true,
    bool fullPeriod = false,
  }) {
    final hour = date.hour;
    final minute = date.minute;
    final isPm = hour >= 12;
    final h12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final mStr = minute.toString().padLeft(2, '0');
    final hStr = h12.toString().padLeft(2, '0');
    final String period;
    if (isArabic) {
      period = fullPeriod ? (isPm ? 'مساءً' : 'صباحاً') : (isPm ? 'م' : 'ص');
    } else {
      period = isPm ? 'PM' : 'AM';
    }
    return '$hStr:$mStr $period';
  }

  /// Formats policy name and working hours cleanly without redundant dashes or '--:--'.
  static String formatPolicySchedule({
    required String policyName,
    String? rawStart,
    String? rawEnd,
    bool isArabic = true,
  }) {
    final start = formatTimeString(rawStart, isArabic: isArabic);
    final end = formatTimeString(rawEnd, isArabic: isArabic);
    final hasValidHours = start != '--:--' && end != '--:--';
    if (!hasValidHours) return policyName;
    return '$policyName • $start - $end';
  }

  /// E.g. "14:30"
  static String format24Time(DateTime date) {
    return toEnglishDigits(DateFormat('HH:mm', 'en').format(date));
  }

  /// Cleans and formats raw time strings (e.g. "17:00:00" -> "05:00 مساءً", "9:30" -> "09:30 صباحاً").
  static String formatTimeString(
    String? rawTime, {
    bool use12Hour = true,
    bool isArabic = true,
    bool fullPeriod = false,
  }) {
    if (rawTime == null ||
        rawTime.trim().isEmpty ||
        rawTime.startsWith('00:00:00') ||
        rawTime == '00:00' ||
        rawTime == '00:00:00.0000000') {
      return '--:--';
    }
    final cleaned = toEnglishDigits(rawTime.trim().split('.').first);
    final parts = cleaned.split(':');
    final hour = int.tryParse(parts[0]);
    final minute = parts.length >= 2 ? int.tryParse(parts[1]) : 0;
    if (hour != null && minute != null) {
      if (use12Hour) {
        final isPm = hour >= 12;
        final h12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
        final mStr = minute.toString().padLeft(2, '0');
        final hStr = h12.toString().padLeft(2, '0');
        final String period;
        if (isArabic) {
          period = fullPeriod ? (isPm ? 'مساءً' : 'صباحاً') : (isPm ? 'م' : 'ص');
        } else {
          period = isPm ? 'PM' : 'AM';
        }
        return '$hStr:$mStr $period';
      } else {
        final hStr = hour.toString().padLeft(2, '0');
        final mStr = minute.toString().padLeft(2, '0');
        return '$hStr:$mStr';
      }
    }
    return cleaned;
  }

  /// Formats raw time string into human readable 12-hour Arabic (e.g. "18:37" -> "06:37 مساءً").
  static String formatReadableTime(String? rawTime, {bool isArabic = true}) {
    return formatTimeString(
      rawTime,
      use12Hour: true,
      isArabic: isArabic,
      fullPeriod: true,
    );
  }

  /// Formats date and time together cleanly, e.g. "2026-10-09 (06:37 مساءً)" or "2026-10-09" or "06:37 مساءً".
  static String formatScheduleDateTime(
    String? rawDate,
    String? rawTime, {
    bool isArabic = true,
  }) {
    final hasDate = rawDate != null && rawDate.trim().isNotEmpty;
    final hasTime = rawTime != null &&
        rawTime.trim().isNotEmpty &&
        rawTime != '--:--' &&
        !rawTime.startsWith('00:00:00');

    final formattedDate = hasDate ? formatDateString(rawDate) : '';
    final formattedTime = hasTime
        ? formatTimeString(
            rawTime,
            use12Hour: true,
            isArabic: isArabic,
            fullPeriod: true,
          )
        : '';

    if (hasDate && hasTime && formattedTime != '--:--') {
      return '$formattedDate ($formattedTime)';
    } else if (hasDate) {
      return formattedDate;
    } else if (hasTime && formattedTime != '--:--') {
      return formattedTime;
    }
    return '-';
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
    return formatTimeString(rawTime, use12Hour: true, isArabic: true);
  }
}
