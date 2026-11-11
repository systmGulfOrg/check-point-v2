import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _withCode(String code, int status) {
  final options = RequestOptions(path: '/x');
  return DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response(
      requestOptions: options,
      statusCode: status,
      headers: Headers.fromMap({'x-error-code': [code]}),
      data: {'isSuccess': false, 'errors': ['server text']},
    ),
  );
}

void main() {
  group('ApiFailureMapper error codes', () {
    test('clock-in on approved leave', () {
      expect(ApiFailureMapper.map(_withCode('ERR_ON_APPROVED_LEAVE', 403)).messageKey,
          'attendance.errors.onApprovedLeave');
    });

    test('revoke errors', () {
      expect(ApiFailureMapper.map(_withCode('ERR_SELF_REVOKE', 403)).messageKey, 'leaves.revoke.errors.self');
      expect(ApiFailureMapper.map(_withCode('ERR_LEAVE_ENDED', 409)).messageKey, 'leaves.revoke.errors.ended');
      expect(ApiFailureMapper.map(_withCode('ERR_LEAVE_NOT_APPROVED', 409)).messageKey,
          'leaves.revoke.errors.notApproved');
    });

    test('unknown codes fall through to the status mapping', () {
      expect(ApiFailureMapper.map(_withCode('SOMETHING_ELSE', 404)).messageKey, 'errors.notFound');
    });
  });
}
