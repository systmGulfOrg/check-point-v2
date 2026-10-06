import 'package:dio/dio.dart';

import 'api_constants.dart';
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
        return const ApiFailure(
          messageKey: 'errors.deviceLoginAccess',
          code: ApiErrorCodes.deviceNotApproved,
        );
      }
      if (normalizedMessage.contains('locked') ||
          (normalizedMessage.contains('failed') &&
              normalizedMessage.contains('login') &&
              normalizedMessage.contains('lock'))) {
        return const ApiFailure(
          messageKey: 'errors.accountLocked',
          code: ApiErrorCodes.accountLocked,
          lockoutMinutes: 15,
        );
      }
      if (normalizedMessage.contains('outside') &&
          (normalizedMessage.contains('zone') ||
              normalizedMessage.contains('site') ||
              normalizedMessage.contains('boundary'))) {
        return const ApiFailure(
          messageKey: 'errors.outsideZone',
          code: ApiErrorCodes.outsideZone,
        );
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
      return ApiFailure(
        messageKey: firstMessage.trim(),
        rawMessage: firstMessage.trim(),
      );
    }
    return ApiFailure(messageKey: fallbackMessageKey);
  }

  static ApiFailure map(Object error) {
    if (error is DioException) {
      final response = error.response;
      final payload = response?.data;
      final status = response?.statusCode;

      String? code;
      Map<String, dynamic>? detailsMap;
      int? lockoutMinutes;

      if (payload is Map) {
        detailsMap = Map<String, dynamic>.from(payload);
        if (payload['code'] is String) {
          code = payload['code'] as String;
        } else if (payload['errorCode'] is String) {
          code = payload['errorCode'] as String;
        }
      }

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
      final combinedMessage = messages.join(' ');
      final lowerCombined = combinedMessage.toLowerCase();

      // Check specific error codes from SAMCO dictionary
      if (code == ApiErrorCodes.outsideZone ||
          lowerCombined.contains('outside the site boundary') ||
          (lowerCombined.contains('outside') &&
              lowerCombined.contains('zone')) ||
          lowerCombined.contains('restricted to your assigned site') ||
          lowerCombined.contains('site zone') ||
          lowerCombined.contains('outside_zone') ||
          lowerCombined.contains('خارج نطاق') ||
          lowerCombined.contains('خارج حدود')) {
        String? siteName = detailsMap?['siteName'] as String? ??
            detailsMap?['site_name'] as String?;
        if (siteName == null || siteName.isEmpty) {
          final match = RegExp(r'\((.*?)\)').firstMatch(combinedMessage);
          if (match != null) {
            siteName = match.group(1)?.trim();
          }
        }
        return ApiFailure(
          messageKey: 'auth.login.outsideZoneMessage',
          code: ApiErrorCodes.outsideZone,
          statusCode: status ?? 403,
          details: {
            if (detailsMap != null) ...detailsMap,
            'siteName': ?siteName,
          },
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        );
      }

      if (code == ApiErrorCodes.accountLocked ||
          status == 423 ||
          lowerCombined.contains('account locked') ||
          (lowerCombined.contains('locked') &&
              lowerCombined.contains('repeated failed logins'))) {
        // extract minutes if mentioned
        lockoutMinutes = 15;
        final match = RegExp(r'(\d+)\s*minute').firstMatch(lowerCombined);
        if (match != null) {
          lockoutMinutes = int.tryParse(match.group(1) ?? '15') ?? 15;
        }
        return ApiFailure(
          messageKey: 'errors.accountLocked',
          code: ApiErrorCodes.accountLocked,
          statusCode: status ?? 403,
          details: detailsMap,
          lockoutMinutes: lockoutMinutes,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        );
      }

      if (code == ApiErrorCodes.oneSitePerDayViolation ||
          lowerCombined.contains('one_site_per_day') ||
          lowerCombined.contains('مسجل بالفعل اليوم في موقع')) {
        return ApiFailure(
          messageKey: 'errors.oneSitePerDay',
          code: ApiErrorCodes.oneSitePerDayViolation,
          statusCode: status ?? 400,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        );
      }

      if (code == ApiErrorCodes.gpsAccuracyTooLow ||
          lowerCombined.contains('gps accuracy') ||
          lowerCombined.contains('دقة الـ gps ضعيفة')) {
        return ApiFailure(
          messageKey: 'errors.gpsAccuracyTooLow',
          code: ApiErrorCodes.gpsAccuracyTooLow,
          statusCode: status ?? 403,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        );
      }

      if (code == ApiErrorCodes.fakeGpsDetected ||
          lowerCombined.contains('fake_gps') ||
          lowerCombined.contains('mock gps') ||
          lowerCombined.contains('mock location') ||
          lowerCombined.contains('تزييف موقع')) {
        return ApiFailure(
          messageKey: 'errors.fakeGpsDetected',
          code: ApiErrorCodes.fakeGpsDetected,
          statusCode: status ?? 400,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        );
      }

      if (code == ApiErrorCodes.faceSpoofDetected ||
          lowerCombined.contains('face_spoof') ||
          lowerCombined.contains('anti-spoof') ||
          lowerCombined.contains('liveness') ||
          lowerCombined.contains('فحص الحيوية')) {
        return ApiFailure(
          messageKey: 'errors.faceSpoofDetected',
          code: ApiErrorCodes.faceSpoofDetected,
          statusCode: status ?? 400,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        );
      }

      if (code == ApiErrorCodes.faceNotMatched ||
          lowerCombined.contains('face_not_matched') ||
          lowerCombined.contains('face mismatch') ||
          lowerCombined.contains('بصمة الوجه غير متطابقة')) {
        return ApiFailure(
          messageKey: 'errors.faceNotMatched',
          code: ApiErrorCodes.faceNotMatched,
          statusCode: status ?? 400,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        );
      }

      if (code == ApiErrorCodes.deviceNotApproved ||
          (lowerCombined.contains('device') &&
              (lowerCombined.contains('access') ||
                  lowerCombined.contains('registered') ||
                  lowerCombined.contains('approved') ||
                  lowerCombined.contains('bound')))) {
        return ApiFailure(
          messageKey: 'errors.deviceLoginAccess',
          code: ApiErrorCodes.deviceNotApproved,
          statusCode: status ?? 403,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        );
      }

      if (code == ApiErrorCodes.officialHoliday ||
          lowerCombined.contains('official holiday') ||
          lowerCombined.contains('عطلة رسمية')) {
        return ApiFailure(
          messageKey: 'errors.officialHoliday',
          code: ApiErrorCodes.officialHoliday,
          statusCode: status ?? 403,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        );
      }

      if (lowerCombined.contains('invalid credential') ||
          lowerCombined.contains('invalid username') ||
          lowerCombined.contains('invalid password') ||
          lowerCombined.contains('wrong password') ||
          lowerCombined.contains('incorrect username') ||
          lowerCombined.contains('incorrect password') ||
          lowerCombined.contains('user not found') ||
          lowerCombined.contains('password is incorrect')) {
        return ApiFailure(
          messageKey: 'errors.invalidCredentials',
          statusCode: status ?? 400,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        );
      }

      return switch (error.type) {
        DioExceptionType.connectionError ||
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.sendTimeout => const ApiFailure(
          messageKey: 'errors.network',
        ),
        _ when status == 401 => ApiFailure(
          messageKey: messages.isNotEmpty
              ? messages.join(' ')
              : 'errors.unauthorized',
          code: ApiErrorCodes.unauthorized,
          statusCode: 401,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        ),
        _ when status == 403 => ApiFailure(
          messageKey: messages.isNotEmpty ? messages.join(' ') : 'errors.forbidden',
          statusCode: 403,
          code: code,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        ),
        _ when status == 404 => ApiFailure(
          messageKey: messages.isNotEmpty ? messages.join(' ') : 'errors.notFound',
          statusCode: 404,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        ),
        _ when status == 409 => ApiFailure(
          messageKey: messages.isNotEmpty ? messages.join(' ') : 'errors.conflict',
          statusCode: 409,
          code: code,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        ),
        _ when status == 400 => ApiFailure(
          messageKey: messages.isNotEmpty ? messages.join(' ') : 'errors.validation',
          statusCode: 400,
          code: code,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        ),
        _ when status == 429 => ApiFailure(
          messageKey: messages.isNotEmpty ? messages.join(' ') : 'errors.rateLimit',
          statusCode: 429,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        ),
        _ when status != null && status >= 500 => ApiFailure(
          messageKey: messages.isNotEmpty ? messages.join(' ') : 'errors.server',
          statusCode: status,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        ),
        _ => ApiFailure(
          messageKey: messages.isNotEmpty ? messages.join(' ') : 'errors.unknown',
          statusCode: status,
          code: code,
          details: detailsMap,
          rawMessage: combinedMessage.isNotEmpty ? combinedMessage : null,
        ),
      };
    }
    return const ApiFailure(messageKey: 'errors.unknown');
  }
}
