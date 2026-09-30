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
      if (normalizedMessage.contains('invalid credential') ||
          normalizedMessage.contains('invalid username') ||
          normalizedMessage.contains('invalid password') ||
          normalizedMessage.contains('wrong password') ||
          normalizedMessage.contains('incorrect username') ||
          normalizedMessage.contains('incorrect password') ||
          normalizedMessage.contains('user not found') ||
          normalizedMessage.contains('password is incorrect')) {
        return const ApiFailure(messageKey: 'errors.invalidCredentials');
      }
    }
    final firstMessage = (messages ?? const []).firstOrNull;
    if (firstMessage != null && firstMessage.trim().isNotEmpty) {
      return ApiFailure(messageKey: firstMessage.trim());
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
        if (payload is Map && payload['messages'] is List)
          ...(payload['messages'] as List).whereType<String>(),
        if (payload is Map &&
            payload['message'] is String &&
            (payload['message'] as String).isNotEmpty)
          payload['message'] as String,
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
      if (message.contains('invalid credential') ||
          message.contains('invalid username') ||
          message.contains('invalid password') ||
          message.contains('wrong password') ||
          message.contains('incorrect username') ||
          message.contains('incorrect password') ||
          message.contains('user not found') ||
          message.contains('password is incorrect')) {
        return const ApiFailure(messageKey: 'errors.invalidCredentials');
      }
      return switch (error.type) {
        DioExceptionType.connectionError ||
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.sendTimeout => const ApiFailure(
          messageKey: 'errors.network',
        ),
        _ when status == 401 => messages.isNotEmpty
            ? ApiFailure(messageKey: messages.join(' '))
            : const ApiFailure(messageKey: 'errors.unauthorized'),
        _ when status == 403 => ApiFailure(
          messageKey:
              messages.any(
                (m) => m.toLowerCase().contains('device is not registered'),
              )
              ? 'errors.deviceLoginAccess'
              : (message.contains('locked') ||
                    (message.contains('failed') && message.contains('login')))
              ? 'errors.accountLocked'
              : messages.isNotEmpty
              ? messages.join(' ')
              : 'errors.forbidden',
        ),
        _ when status == 404 => ApiFailure(
          messageKey: messages.isNotEmpty
              ? messages.join(' ')
              : 'errors.notFound',
        ),
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
        _ when status != null && status >= 500 => ApiFailure(
          messageKey: messages.isNotEmpty
              ? messages.join(' ')
              : 'errors.server',
        ),
        _ => messages.isNotEmpty
            ? ApiFailure(messageKey: messages.join(' '))
            : const ApiFailure(messageKey: 'errors.unknown'),
      };
    }
    return const ApiFailure(messageKey: 'errors.unknown');
  }
}
