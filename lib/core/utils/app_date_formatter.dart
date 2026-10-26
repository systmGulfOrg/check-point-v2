import 'package:intl/intl.dart';

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

  static String toEnglishDigits(String input) {
    var result = input;
    for (int i = 0; i < 10; i++) {
      result = result.replaceAll(_arabicDigits[i], _englishDigits[i]);
      result = result.replaceAll(_persianDigits[i], _englishDigits[i]);
    }
    return result;
  }

  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return toEnglishDigits(DateFormat(pattern, 'en').format(date));
  }

  static String formatFullDate(DateTime date) {
    return toEnglishDigits(DateFormat('EEEE, dd MMM yyyy', 'en').format(date));
  }

  static String formatMediumDate(DateTime date) {
    return toEnglishDigits(DateFormat('dd MMM yyyy', 'en').format(date));
  }

  static String formatShortDayMonth(DateTime date) {
    return toEnglishDigits(DateFormat('EEE, dd MMM', 'en').format(date));
  }

  static String formatYearMonthDay(DateTime date) {
    return toEnglishDigits(DateFormat('yyyy-MM-dd', 'en').format(date));
  }

  static String formatDayMonthYear(DateTime date) {
    return toEnglishDigits(DateFormat('dd-MM-yyyy', 'en').format(date));
  }

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

  static String format24Time(DateTime date) {
    return toEnglishDigits(DateFormat('HH:mm', 'en').format(date));
  }

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
    var timePart = toEnglishDigits(rawTime.trim().split('.').first);
    if (timePart.contains('T')) {
      timePart = timePart.split('T').last;
    }
    timePart = timePart.replaceAll('Z', '');
    final cleaned = timePart.trim();
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
          period = fullPeriod
              ? (isPm ? 'مساءً' : 'صباحاً')
              : (isPm ? 'م' : 'ص');
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

  static String formatReadableTime(String? rawTime, {bool isArabic = true}) {
    return formatTimeString(
      rawTime,
      use12Hour: true,
      isArabic: isArabic,
      fullPeriod: true,
    );
  }

  static String formatScheduleDateTime(
    String? rawDate,
    String? rawTime, {
    bool isArabic = true,
  }) {
    final hasDate = rawDate != null && rawDate.trim().isNotEmpty;
    final hasTime =
        rawTime != null &&
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

  static String formatTime12HourArabic(String? rawTime) {
    return formatTimeString(rawTime, use12Hour: true, isArabic: true);
  }
}
