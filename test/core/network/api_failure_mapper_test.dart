import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps the device login access response to its localized key', () {
    final failure = ApiFailureMapper.fromMessages(const [
      "This devise doesn't have access to login",
    ], fallbackMessageKey: 'errors.invalidCredentials');

    expect(failure.messageKey, 'errors.deviceLoginAccess');
  });

  test(
    'maps the account locked response from messages to errors.accountLocked',
    () {
      final failure = ApiFailureMapper.fromMessages(const [
        'Account locked due to repeated failed logins. Try again in 2 minute(s).',
      ], fallbackMessageKey: 'errors.invalidCredentials');

      expect(failure.messageKey, 'errors.accountLocked');
    },
  );

  test('maps DioException with 403 status and account locked error payload', () {
    final dioError = DioException(
      requestOptions: RequestOptions(path: '/api/v2/auth/login'),
      response: Response(
        requestOptions: RequestOptions(path: '/api/v2/auth/login'),
        statusCode: 403,
        data: {
          'value': null,
          'status': 403,
          'isSuccess': false,
          'errors': [
            'Account locked due to repeated failed logins. Try again in 2 minute(s).',
          ],
        },
      ),
      type: DioExceptionType.badResponse,
    );

    final failure = ApiFailureMapper.map(dioError);

    expect(failure.messageKey, 'errors.accountLocked');
  });
}
