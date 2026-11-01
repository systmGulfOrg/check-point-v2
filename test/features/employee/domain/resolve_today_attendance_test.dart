import 'package:check_point_v2/core/database/app_database.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/employee/domain/use_cases/resolve_today_attendance.dart';
import 'package:flutter_test/flutter_test.dart';

PendingAttendanceTableData _queued(String type, DateTime localTime) =>
    PendingAttendanceTableData(
      clientUuid: '$type-${localTime.toIso8601String()}',
      type: type,
      wallClock: localTime.toUtc(),
      monotonicMs: BigInt.from(1000),
      bootId: 'boot',
      mockLocationDetected: false,
      status: 'queued',
      createdAt: localTime.toUtc(),
      retryCount: 0,
      area: 'Office',
    );

void main() {
  final today = DateTime(2026, 11, 1, 15);

  group('resolveTodayAttendance', () {
    test('server record wins over local punches', () {
      const server = AdminAttendanceModel(
        attendanceDate: '2026-11-01',
        clockInTime: '09:00:00',
        clockOutTime: '17:00:00',
      );
      final result = resolveTodayAttendance(
        serverToday: server,
        queuedToday: [
          _queued('in', DateTime(2026, 11, 1, 10)),
          _queued('out', DateTime(2026, 11, 1, 18)),
        ],
        today: today,
      );
      expect(result!.clockInTime, '09:00:00');
      expect(result.clockOutTime, '17:00:00');
    });

    test('local check-out fills only the slot the server is missing', () {
      const server = AdminAttendanceModel(
        attendanceDate: '2026-11-01',
        clockInTime: '09:00:00',
      );
      final result = resolveTodayAttendance(
        serverToday: server,
        queuedToday: [_queued('out', DateTime(2026, 11, 1, 17, 30))],
        today: today,
      );
      expect(result!.clockInTime, '09:00:00');
      expect(result.clockOutTime, '17:30:00');
    });

    test('no server record falls back to today\'s local punches', () {
      final result = resolveTodayAttendance(
        serverToday: null,
        queuedToday: [_queued('in', DateTime(2026, 11, 1, 8, 45))],
        today: today,
      );
      expect(result!.clockInTime, '08:45:00');
      expect(result.clockOutTime, isNull);
      expect(result.attendanceDate, '2026-11-01');
    });

    test('neither server nor local leaves the card empty', () {
      final result = resolveTodayAttendance(
        serverToday: null,
        queuedToday: const [],
        today: today,
      );
      expect(result, isNull);
    });

    test('a lone local check-out with no check-in shows nothing', () {
      final result = resolveTodayAttendance(
        serverToday: null,
        queuedToday: [_queued('out', DateTime(2026, 11, 1, 17))],
        today: today,
      );
      expect(result, isNull);
    });
  });
}
