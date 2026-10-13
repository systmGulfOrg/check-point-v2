class LeaveRequestPolicy {
  const LeaveRequestPolicy._();

  static String? validatePermissionTiming({
    required String permitType,
    required DateTime selectedDate,
    required DateTime now,
    required String? shiftStart,
    required String? shiftEnd,
    required int? allowedLateMinutes,
    required int requestedDurationMinutes,
  }) {
    if (permitType == 'LateArrival' &&
        allowedLateMinutes != null &&
        requestedDurationMinutes > allowedLateMinutes) {
      return 'permissions.request.lateArrivalDuration';
    }
    if (!_isSameDay(selectedDate, now) || shiftStart == null) return null;
    final start = _minutesFromHm(shiftStart);
    if (start == null) return null;
    if (permitType == 'LateArrival' &&
        _minutesSinceMidnight(now) > start - 60) {
      return 'permissions.request.lateArrivalDeadline';
    }
    if (permitType == 'EarlyDeparture' && shiftEnd != null) {
      final end = _minutesFromHm(shiftEnd);
      if (end == null) return null;
      final shiftLength = end >= start ? end - start : end + 1440 - start;
      final deadline = start + (shiftLength / 2).ceil();
      if (_minutesSinceMidnight(now) > deadline) {
        return 'permissions.request.earlyDepartureDeadline';
      }
    }
    return null;
  }

  static bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static int _minutesSinceMidnight(DateTime date) =>
      date.hour * 60 + date.minute;

  static int? _minutesFromHm(String value) {
    final parts = value.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null || hour > 23 || minute > 59) return null;
    return hour * 60 + minute;
  }
}
