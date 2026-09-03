import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps the device login access response to its localized key', () {
    final failure = ApiFailureMapper.fromMessages(const [
      "This devise doesn't have access to login",
    ], fallbackMessageKey: 'errors.invalidCredentials');

    expect(failure.messageKey, 'errors.deviceLoginAccess');
  });

  test('uses the fallback key when no known backend message matches', () {
    final failure = ApiFailureMapper.fromMessages(const [
      'Invalid username or password',
    ], fallbackMessageKey: 'errors.invalidCredentials');

    expect(failure.messageKey, 'errors.invalidCredentials');
  });
}
