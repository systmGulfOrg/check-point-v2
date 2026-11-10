import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AccountRequestModel', () {
    test('reads the legacy number from a v2 row and keeps the thumbnail', () {
      final model = AccountRequestModel.fromJson({
        'id': '01HZ8ACCT00001',
        'legacyId': 42,
        'name': 'Ahmed',
        'status': 'Pending',
        'imageUrl': '/api/v2/media/t/photos/a.jpg?sig=x',
        'imageThumbUrl': '/api/v2/media/t/photos/a.jpg?sig=x&size=thumb',
        'createdAt': '2026-11-01T10:00:00.000Z',
      });
      expect(model.id, 42);
      expect(model.thumb, '/api/v2/media/t/photos/a.jpg?sig=x&size=thumb');
      expect(model.photo, '/api/v2/media/t/photos/a.jpg?sig=x');
      expect(model.createdDate, DateTime.utc(2026, 11, 1, 10));
    });

    test('still reads a v1 row with a numeric id', () {
      final model = AccountRequestModel.fromJson({'id': 7, 'name': 'Sara', 'imageUrl': 'https://x/y.jpg'});
      expect(model.id, 7);
      expect(model.thumb, 'https://x/y.jpg');
    });

    test('a v2 page carries hasNext', () {
      final res = AccountRequestsResponseModel.fromJson({
        'isSuccess': true,
        'value': {'items': [], 'totalCount': 30, 'hasNext': true},
      });
      expect(res.value?.hasNext, isTrue);
      expect(res.value?.totalCount, 30);
    });
  });
}
