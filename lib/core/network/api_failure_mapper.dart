import 'package:dio/dio.dart';

import 'api_failure.dart';

class ApiFailureMapper {
  const ApiFailureMapper._();

  static ApiFailure map(Object error) {
    if (error is DioException) {
      return switch (error.type) {
        DioExceptionType.connectionError ||
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.sendTimeout => const ApiFailure(
          messageKey: 'errors.network',
        ),
        _ => const ApiFailure(messageKey: 'errors.unknown'),
      };
    }
    return const ApiFailure(messageKey: 'errors.unknown');
  }
}
