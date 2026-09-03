import 'package:dio/dio.dart';

import 'api_failure.dart';

class ApiFailureMapper {
  const ApiFailureMapper._();

  static ApiFailure fromMessages(
    Iterable<String>? messages, {
    required String fallbackMessageKey,
  }) {
    for (final message in messages ?? const <String>[]) {
      final normalizedMessage = message.toLowerCase();
      if ((normalizedMessage.contains('device') ||
              normalizedMessage.contains('devise')) &&
          normalizedMessage.contains('access') &&
          normalizedMessage.contains('login')) {
        return const ApiFailure(messageKey: 'errors.deviceLoginAccess');
      }
    }
    return ApiFailure(messageKey: fallbackMessageKey);
  }

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
