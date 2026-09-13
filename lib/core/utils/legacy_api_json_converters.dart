/// Converts legacy .NET date/time objects and the newer string representation
/// into the string shape consumed by the Flutter presentation models.
String? legacyApiValueToString(Object? value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is num || value is bool) return value.toString();

  if (value is Map) {
    final year = _number(value['year']);
    final month = _number(value['month']);
    final day = _number(value['day']);
    if (year != null && month != null && day != null) {
      return '${year.toString().padLeft(4, '0')}-'
          '${month.toString().padLeft(2, '0')}-'
          '${day.toString().padLeft(2, '0')}';
    }

    final hour = _number(value['hour']);
    final minute = _number(value['minute']);
    if (hour != null && minute != null) {
      final second = _number(value['second']) ?? 0;
      return '${hour.toString().padLeft(2, '0')}:'
          '${minute.toString().padLeft(2, '0')}:'
          '${second.toString().padLeft(2, '0')}';
    }

    final days = _number(value['days']);
    final hours = _number(value['hours']);
    final minutes = _number(value['minutes']);
    final seconds = _number(value['seconds']);
    if (hours != null && minutes != null && seconds != null) {
      final totalHours = (days ?? 0) * 24 + hours;
      return '${totalHours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
  }

  return value.toString();
}

int? _number(Object? value) => value is num ? value.toInt() : null;
