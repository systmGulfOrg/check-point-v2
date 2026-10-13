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
      if (normalizedMessage.contains('locked') ||
          (normalizedMessage.contains('failed') &&
              normalizedMessage.contains('login') &&
              normalizedMessage.contains('lock'))) {
        return const ApiFailure(messageKey: 'errors.accountLocked');
      }
      if (normalizedMessage.contains('invalid credential') ||
          normalizedMessage.contains('invalid user') ||
          normalizedMessage.contains('invalid password') ||
          normalizedMessage == 'invalid credentials') {
        return const ApiFailure(messageKey: 'errors.invalidCredentials');
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
      if (message.contains('overtime must be at least')) {
        return const ApiFailure(messageKey: 'overtime.minDuration');
      }
      if (message.contains('overtime end time') ||
          message.contains('endtime must be later')) {
        return const ApiFailure(messageKey: 'overtime.invalidTimeRange');
      }
      if (message.contains('requestdate must be a valid date')) {
        return const ApiFailure(messageKey: 'overtime.invalidDate');
      }
      if ((message.contains('device') || message.contains('devise')) &&
          message.contains('access') &&
          message.contains('login')) {
        return const ApiFailure(messageKey: 'errors.deviceLoginAccess');
      }
      if (message.contains('password') &&
          (message.contains('policy') ||
              message.contains('weak') ||
              message.contains('meet') ||
              message.contains('character'))) {
        return const ApiFailure(messageKey: 'errors.passwordPolicy');
      }
      if (message.contains('username') &&
          (message.contains('already') ||
              message.contains('exist') ||
              message.contains('taken'))) {
        return const ApiFailure(messageKey: 'errors.usernameExists');
      }
      if (message.contains('locked') ||
          (message.contains('failed') &&
              message.contains('login') &&
              (message.contains('lock') || message.contains('try again')))) {
        return const ApiFailure(messageKey: 'errors.accountLocked');
      }
      if (message.contains('invalid credential') ||
          message.contains('invalid user') ||
          message.contains('invalid password') ||
          (message.contains('invalid') && status == 401) ||
          (error.requestOptions.path.toLowerCase().contains('login') &&
              status == 401)) {
        return const ApiFailure(messageKey: 'errors.invalidCredentials');
      }
      return switch (error.type) {
        DioExceptionType.connectionError ||
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.sendTimeout => const ApiFailure(
          messageKey: 'errors.network',
        ),
        _ when status == 401 => const ApiFailure(
          messageKey: 'errors.invalidCredentials',
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
        _ when status == 413 => const ApiFailure(
          messageKey: 'errors.entityTooLarge',
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
