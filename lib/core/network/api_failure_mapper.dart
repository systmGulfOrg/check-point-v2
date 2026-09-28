import 'package:dio/dio.dart';

import 'api_failure.dart';

class ApiFailureMapper {
  const ApiFailureMapper._();

  static bool isRetryable(ApiFailure failure) =>
      failure.messageKey == 'errors.network' ||
      failure.messageKey == 'errors.timeout';

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
      if (normalizedMessage.contains('locked') ||
          (normalizedMessage.contains('failed') &&
              normalizedMessage.contains('login') &&
              normalizedMessage.contains('lock'))) {
        return const ApiFailure(messageKey: 'errors.accountLocked');
      }
    }
    return ApiFailure(messageKey: fallbackMessageKey);
  }

  static ApiFailure map(Object error) {
    if (error is DioException) {
      final response = error.response;
      final payload = response?.data;
      final status = response?.statusCode;
      final messages = <String>[
        if (payload is Map && payload['errors'] is List)
          ...(payload['errors'] as List).whereType<String>(),
        if (payload is Map && payload['validationErrors'] is List)
          for (final item in (payload['validationErrors'] as List))
            if (item is Map && item['errorMessage'] is String)
              item['errorMessage'] as String,
      ];
      final message = messages.join(' ').toLowerCase();
      if ((message.contains('device') || message.contains('devise')) &&
          message.contains('access') &&
          message.contains('login')) {
        return const ApiFailure(messageKey: 'errors.deviceLoginAccess');
      }
      if (message.contains('locked') ||
          (message.contains('failed') &&
              message.contains('login') &&
              (message.contains('lock') || message.contains('try again')))) {
        return const ApiFailure(messageKey: 'errors.accountLocked');
      }
      return switch (error.type) {
        DioExceptionType.connectionError ||
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.sendTimeout => const ApiFailure(
          messageKey: 'errors.network',
        ),
        _ when status == 401 => const ApiFailure(
          messageKey: 'errors.unauthorized',
        ),
        _ when status == 403 => ApiFailure(
          messageKey:
              messages.any(
                (m) => m.toLowerCase().contains('device is not registered'),
              )
              ? 'errors.deviceLoginAccess'
              : (message.contains('locked') ||
                    (message.contains('failed') && message.contains('login')))
              ? 'errors.accountLocked'
              : 'errors.forbidden',
        ),
        _ when status == 404 => const ApiFailure(messageKey: 'errors.notFound'),
        _ when status == 409 => ApiFailure(
          messageKey: messages.isNotEmpty
              ? messages.join(' ')
              : 'errors.conflict',
        ),
        _ when status == 400 => ApiFailure(
          messageKey: messages.isNotEmpty
              ? messages.join(' ')
              : 'errors.validation',
        ),
        _ when status == 429 => ApiFailure(
          messageKey: messages.isNotEmpty
              ? messages.join(' ')
              : 'errors.rateLimit',
        ),
        _ when status != null && status >= 500 => const ApiFailure(
          messageKey: 'errors.server',
        ),
        _ => const ApiFailure(messageKey: 'errors.unknown'),
      };
    }
    return const ApiFailure(messageKey: 'errors.unknown');
  }
}
