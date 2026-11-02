import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:check_point_v2/core/app/app_config.dart';
import 'package:check_point_v2/core/services/play_integrity_service.dart';

class AuthTokenInterceptor extends Interceptor {
  AuthTokenInterceptor({required this.secureStorage});

  static const _tenantSlugKey = 'tenant_slug';

  static const _tenantBlockedCodes = {
    'TENANT_SUSPENDED',
    'TENANT_EXPIRED',
    'TENANT_ARCHIVED',
    'TENANT_PENDING_DELETION',
    'TENANT_TRIAL_EXPIRED',
  };

  final FlutterSecureStorage secureStorage;
  static String? _inMemoryToken;
  static String? _inMemoryTenantSlug;

  static void Function(String errorCode)? onTenantBlocked;

  static void updateToken(String? token) {
    _inMemoryToken = token;
  }

  static void updateTenantSlug(String? slug) {
    _inMemoryTenantSlug = slug;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var token = _inMemoryToken;
    if (token == null || token.isEmpty) {
      token = await secureStorage.read(key: AppConfig.authTokenKey);
      _inMemoryToken = token;
    }
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    var tenantSlug = _inMemoryTenantSlug;
    if (tenantSlug == null || tenantSlug.isEmpty) {
      tenantSlug = await secureStorage.read(key: _tenantSlugKey);
      _inMemoryTenantSlug = tenantSlug;
    }
    if (tenantSlug != null && tenantSlug.isNotEmpty) {
      options.headers['X-Tenant-Slug'] = tenantSlug;
    }

    final path = options.path.toLowerCase();
    if (path.contains('attendance') ||
        path.contains('/in') ||
        path.contains('/out')) {
      final latest = PlayIntegrityService.currentPackage;
      if (latest != null) {
        options.headers['x-play-integrity-token'] = latest.token;
        options.headers['x-play-integrity-challenge'] = latest.challenge;
        options.headers['x-play-integrity-hash'] = latest.requestHash;
      }
    }

    handler.next(options);
  }

  // These phrases in 401/403 error bodies indicate an auth/token problem
  // (not a business-rule denial), so we must clear the stored token.
  static const _tokenInvalidPhrases = {
    'invalid or expired token',
    'invalid token',
    'expired token',
    'token expired',
    'token is invalid',
    'unauthorized',
  };

  static bool _isTokenError(DioException err) {
    final status = err.response?.statusCode;
    // 401 is always a token/auth issue.
    if (status == 401) return true;
    // 403 may be a business-rule denial (e.g. "You cannot verify your own
    // attendance").  Only treat it as a token error when the body explicitly
    // mentions token/auth language.
    if (status == 403) {
      final payload = err.response?.data;
      final messages = <String>[
        if (payload is Map && payload['errors'] is List)
          ...(payload['errors'] as List).whereType<String>(),
      ];
      final combined = messages.join(' ').toLowerCase();
      return _tokenInvalidPhrases.any(combined.contains);
    }
    return false;
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;

    if (_isTokenError(err)) {
      _inMemoryToken = null;
      await secureStorage.delete(key: AppConfig.authTokenKey);
    }

    if (status == 403) {
      final errorCode = err.response?.headers.value('x-error-code');
      if (errorCode != null && _tenantBlockedCodes.contains(errorCode)) {
        onTenantBlocked?.call(errorCode);
      }
    }

    handler.next(err);
  }
}
