import 'package:check_point_v2/features/attendance_points/data/models/points_history_model.dart';
import 'package:flutter_test/flutter_test.dart';

PointsHistoryItemModel _point(String? cancelReason) => PointsHistoryItemModel(
  id: 'p1',
  pointType: 'BLACK',
  status: 'CANCELLED',
  source: 'AUTOMATIC_ABSENCE',
  points: 1,
  attendanceDate: '2026-09-04T00:00:00.000Z',
  reason: 'Absence: No attendance recorded for working day',
  cancelReason: cancelReason,
  createdAt: '2026-09-04T20:00:00.000Z',
);

void main() {
  group('PointsHistoryItemModel.cancelReasonKey', () {
    test('maps the engine reasons for leave, holidays, days off and permits', () {
      expect(_point('Approved full-day leave').cancelReasonKey, 'points.cancelReason.leave');
      expect(_point('Official Holiday').cancelReasonKey, 'points.cancelReason.holiday');
      expect(_point('Weekly day off').cancelReasonKey, 'points.cancelReason.weeklyOff');
      expect(_point('Non-working day').cancelReasonKey, 'points.cancelReason.weeklyOff');
      expect(_point('Approved permit').cancelReasonKey, 'points.cancelReason.permit');
      expect(_point('permission_approved').cancelReasonKey, 'points.cancelReason.permit');
      expect(_point('Day not finished').cancelReasonKey, 'points.cancelReason.dayNotFinished');
    });

    test('unknown reasons get a generic key; none gets null', () {
      expect(_point('Manual by HR').cancelReasonKey, 'points.cancelReason.other');
      expect(_point(null).cancelReasonKey, isNull);
    });
  });
}
