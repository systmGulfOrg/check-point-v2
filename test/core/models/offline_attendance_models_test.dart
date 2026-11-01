import 'package:check_point_v2/core/models/offline_attendance_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OfflineSyncResponse', () {
    // Exact envelope returned by POST /api/v2/attendance/offline-sync.
    final envelope = <String, dynamic>{
      'value': {
        'results': [
          {
            'clientUuid': 'a',
            'status': 'synced',
            'attendanceId': '01M4ZNCNBVTXR7J6K27P2M0F2V',
          },
          {
            'clientUuid': 'b',
            'status': 'pending',
            'attendanceId': '01M4ZNCNBVTXR7J6K27P2M0F2W',
            'reasons': ['CLOCK_DRIFT'],
          },
          {
            'clientUuid': 'c',
            'status': 'duplicate',
            'attendanceId': '01M4ZNCNBVTXR7J6K27P2M0F2X',
          },
          {
            'clientUuid': 'd',
            'status': 'rejected',
            'reason': 'OFFLINE_WINDOW_EXCEEDED',
          },
        ],
      },
      'isSuccess': true,
    };

    test('parses ULID string attendance ids without throwing', () {
      final r = OfflineSyncResponse.fromJson(envelope);
      expect(r.results.first.attendanceId, '01M4ZNCNBVTXR7J6K27P2M0F2V');
    });

    test('derives counts the server does not send', () {
      final r = OfflineSyncResponse.fromJson(envelope);
      expect(r.total, 4);
      expect(r.verified, 2); // synced + duplicate
      expect(r.pending, 1);
      expect(r.failed, 1);
    });

    test('reads both `reasons` and the single `reason` field', () {
      final r = OfflineSyncResponse.fromJson(envelope);
      expect(r.results[1].reasons, ['CLOCK_DRIFT']);
      expect(r.results[3].reasons, ['OFFLINE_WINDOW_EXCEEDED']);
    });
  });

  test(
    'OfflineSyncRecord sends accuracyM, the name the strict API schema accepts',
    () {
      final json = OfflineSyncRecord(
        clientUuid: 'u',
        type: 'in',
        wallClock: DateTime.utc(2026, 11, 1),
        monotonicMs: 1,
        bootId: 'b',
        accuracy: 12,
      ).toJson();
      expect(json['accuracyM'], 12);
      expect(json.containsKey('accuracy'), isFalse);
    },
  );

  test('PendingAttendanceItem parses a ULID string id', () {
    final item = PendingAttendanceItem.fromJson({
      'id': '01M4ZNCNBVTXR7J6K27P2M0F2V',
      'verificationStatus': 'PENDING_VERIFICATION',
      'employee': {'id': 'e1', 'name': 'Osama'},
    });
    expect(item.id, '01M4ZNCNBVTXR7J6K27P2M0F2V');
    expect(item.employeeId, 'e1');
  });
}
