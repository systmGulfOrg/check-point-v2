import 'package:flutter_test/flutter_test.dart';

import 'package:check_point_v2/features/leaves/domain/validators/leave_request_policy.dart';

void main() {
  group('LeaveRequestPolicy.validatePermissionTiming', () {
    test('rejects early departure after half of the shift', () {
      final result = LeaveRequestPolicy.validatePermissionTiming(
        permitType: 'EarlyDeparture',
        selectedDate: DateTime(2026, 10, 13),
        now: DateTime(2026, 10, 13, 14),
        shiftStart: '09:00',
        shiftEnd: '17:00',
        allowedLateMinutes: 30,
        requestedDurationMinutes: 30,
      );

      expect(result, 'permissions.request.earlyDepartureDeadline');
    });

    test('rejects late arrival request less than one hour before shift', () {
      final result = LeaveRequestPolicy.validatePermissionTiming(
        permitType: 'LateArrival',
        selectedDate: DateTime(2026, 10, 13),
        now: DateTime(2026, 10, 13, 8, 30),
        shiftStart: '09:00',
        shiftEnd: '17:00',
        allowedLateMinutes: 30,
        requestedDurationMinutes: 30,
      );

      expect(result, 'permissions.request.lateArrivalDeadline');
    });

    test('uses the configured allowance for late arrival duration', () {
      final result = LeaveRequestPolicy.validatePermissionTiming(
        permitType: 'LateArrival',
        selectedDate: DateTime(2026, 10, 14),
        now: DateTime(2026, 10, 13, 20),
        shiftStart: '09:00',
        shiftEnd: '17:00',
        allowedLateMinutes: 30,
        requestedDurationMinutes: 31,
      );

      expect(result, 'permissions.request.lateArrivalDuration');
    });

    test('allows a valid configured late arrival request', () {
      final result = LeaveRequestPolicy.validatePermissionTiming(
        permitType: 'LateArrival',
        selectedDate: DateTime(2026, 10, 14),
        now: DateTime(2026, 10, 13, 20),
        shiftStart: '09:00',
        shiftEnd: '17:00',
        allowedLateMinutes: 30,
        requestedDurationMinutes: 30,
      );

      expect(result, isNull);
    });
  });
}
