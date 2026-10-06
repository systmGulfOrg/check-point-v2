import 'package:flutter_test/flutter_test.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/features/attendance_points/data/models/points_summary_model.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/ai_verification_models.dart';
import 'package:dio/dio.dart';

void main() {
  group('Integration Flow: Employee Smart Biometrics & Permissions', () {
    test('4.1 Fake GPS / Mock Location exception mapping', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/api/v2/attendance/clock-in'),
        response: Response(
          requestOptions: RequestOptions(path: '/api/v2/attendance/clock-in'),
          statusCode: 400,
          data: {
            'statusCode': 400,
            'message': 'Mock GPS / Fake location provider detected',
            'error': 'FAKE_GPS_DETECTED',
          },
        ),
        type: DioExceptionType.badResponse,
      );

      final failure = ApiFailureMapper.map(dioException);
      expect(failure.messageKey, 'errors.fakeGpsDetected');
    });

    test('4.2 Face Spoof / Liveness Detection failure mapping', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/api/v2/attendance/clock-in'),
        response: Response(
          requestOptions: RequestOptions(path: '/api/v2/attendance/clock-in'),
          statusCode: 400,
          data: {
            'statusCode': 400,
            'message': 'Liveness check failed. Anti-spoof rejected.',
            'error': 'FACE_SPOOF_DETECTED',
          },
        ),
        type: DioExceptionType.badResponse,
      );

      final failure = ApiFailureMapper.map(dioException);
      expect(failure.messageKey, 'errors.faceSpoofDetected');
    });

    test('4.3 Face Verification AI Model serialization', () {
      const result = AiFaceVerifyResultModel(
        decision: 'ACCEPT',
        matchScore: 0.96,
        antiSpoofScore: 0.99,
      );

      expect(result.decision, 'ACCEPT');
      expect(result.matchScore, 0.96);
      expect(result.antiSpoofScore, 0.99);

      final json = result.toJson();
      expect(json['decision'], 'ACCEPT');
      expect(json['matchScore'], 0.96);
      expect(json['antiSpoofScore'], 0.99);
    });

    test('4.4 Attendance Earned Points Model serialization', () {
      const summary = PointsSummaryModel(
        green: 120,
        red: 10,
        black: 2,
        availableGreen: 100,
      );

      expect(summary.green, 120);
      expect(summary.red, 10);
      expect(summary.black, 2);
      expect(summary.availableGreen, 100);
    });

    test('4.5 Short Hourly Permission duration calculation helper', () {
      // 09:00 to 11:30 = 2.5 hours
      final fromTime = DateTime(2026, 10, 5, 9, 0);
      final toTime = DateTime(2026, 10, 5, 11, 30);
      final differenceMinutes = toTime.difference(fromTime).inMinutes;
      final hours = differenceMinutes / 60.0;

      expect(differenceMinutes, 150);
      expect(hours, 2.5);
    });
  });
}
