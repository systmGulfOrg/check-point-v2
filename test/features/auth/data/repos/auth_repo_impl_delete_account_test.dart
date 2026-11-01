import 'package:check_point_v2/features/auth/data/apis/auth_api_service.dart';
import 'package:check_point_v2/features/auth/data/models/account_deletion/delete_account_request_body.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAuthApiService implements AuthApiService {
  _FakeAuthApiService({this.status});

  /// HTTP status to fail with; null succeeds.
  final int? status;
  final bodies = <DeleteAccountRequestBody>[];

  @override
  Future<void> deleteMyAccount(DeleteAccountRequestBody body) async {
    bodies.add(body);
    final code = status;
    if (code == null) return;
    final options = RequestOptions(path: '/api/v2/auth/me');
    throw DioException(
      requestOptions: options,
      response: Response(requestOptions: options, statusCode: code),
      type: DioExceptionType.badResponse,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<String?> failureKey(int? status) async {
  final api = _FakeAuthApiService(status: status);
  final result = await AuthRepoImpl(api: api).deleteMyAccount('secret');
  return result.when(success: (_) => null, failure: (f) => f.messageKey);
}

void main() {
  group('AuthRepoImpl.deleteMyAccount', () {
    test('sends the password and succeeds', () async {
      final api = _FakeAuthApiService();
      final result = await AuthRepoImpl(api: api).deleteMyAccount('secret');
      expect(result.when(success: (_) => true, failure: (_) => false), isTrue);
      expect(api.bodies.single.password, 'secret');
      expect(api.bodies.single.toJson(), {'password': 'secret'});
    });

    test('maps 400 to the wrong-password key', () async {
      expect(await failureKey(400), 'auth.deleteAccount.wrongPassword');
    });

    test('maps 409 to the last-admin key', () async {
      expect(await failureKey(409), 'auth.deleteAccount.lastAdmin');
    });

    test('maps other server errors through the shared mapper', () async {
      expect(await failureKey(404), 'errors.notFound');
    });
  });
}
