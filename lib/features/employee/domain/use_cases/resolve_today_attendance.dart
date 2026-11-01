import 'package:check_point_v2/core/database/app_database.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';

/// Decides what the "today" attendance card shows.
///
/// Priority:
/// 1. The server's record for today (fresh when online, the cached copy when
///    offline). A queued local punch only fills a slot the server is still
///    missing — e.g. checked in online, then checked out while offline.
/// 2. No server record: today's queued local punches.
/// 3. Neither: `null`, so the card stays empty.
///
/// [queuedToday] must already be limited to today's queued (unsent) rows;
/// rows from other days must never appear as today's attendance.
AdminAttendanceModel? resolveTodayAttendance({
  required AdminAttendanceModel? serverToday,
  required List<PendingAttendanceTableData> queuedToday,
  required DateTime today,
}) {
  final localIn = queuedToday.where((r) => r.type == 'in').firstOrNull;
  final localOut = queuedToday.where((r) => r.type == 'out').lastOrNull;

  if (serverToday != null) {
    final missingIn = _isBlank(serverToday.clockInTime);
    final missingOut = _isBlank(serverToday.clockOutTime);
    if ((!missingIn || localIn == null) && (!missingOut || localOut == null)) {
      return serverToday;
    }
    return _copyWithTimes(
      serverToday,
      clockInTime: missingIn && localIn != null
          ? _timeOf(localIn.wallClock)
          : serverToday.clockInTime,
      clockOutTime: missingOut && localOut != null
          ? _timeOf(localOut.wallClock)
          : serverToday.clockOutTime,
    );
  }

  // A local check-out with no check-in anywhere has nothing to attach to.
  if (localIn == null) return null;

  return AdminAttendanceModel(
    attendanceDate: _dateOf(today),
    clockInTime: _timeOf(localIn.wallClock),
    clockOutTime:
        localOut != null && !localOut.wallClock.isBefore(localIn.wallClock)
        ? _timeOf(localOut.wallClock)
        : null,
    area: localIn.area,
    customerId: localIn.customerId,
    status: 'Present',
  );
}

bool _isBlank(String? value) =>
    value == null || value.trim().isEmpty || value == 'null';

String _dateOf(DateTime d) => '${d.year}-${_two(d.month)}-${_two(d.day)}';

String _timeOf(DateTime utc) {
  final t = utc.toLocal();
  return '${_two(t.hour)}:${_two(t.minute)}:${_two(t.second)}';
}

String _two(int n) => n.toString().padLeft(2, '0');

AdminAttendanceModel _copyWithTimes(
  AdminAttendanceModel m, {
  required String? clockInTime,
  required String? clockOutTime,
}) => AdminAttendanceModel(
  id: m.id,
  employeeId: m.employeeId,
  employeeName: m.employeeName,
  clockInTime: clockInTime,
  clockOutTime: clockOutTime,
  dayHours: m.dayHours,
  totalHours: m.totalHours,
  attendanceDate: m.attendanceDate,
  area: m.area,
  customerId: m.customerId,
  customerName: m.customerName,
  employeeImage: m.employeeImage,
  isEarly: m.isEarly,
  isLate: m.isLate,
  status: m.status,
  nominalHours: m.nominalHours,
  taskCalculatedHours: m.taskCalculatedHours,
  underAllocation: m.underAllocation,
  permitId: m.permitId,
  checkInAddress: m.checkInAddress,
  checkOutAddress: m.checkOutAddress,
  checkInMockLocation: m.checkInMockLocation,
  checkOutMockLocation: m.checkOutMockLocation,
  earlyLeaveMinutes: m.earlyLeaveMinutes,
  workedMinutes: m.workedMinutes,
);
