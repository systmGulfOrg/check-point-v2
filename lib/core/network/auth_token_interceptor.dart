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

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;
    if (status == 401 || status == 403) {
      _inMemoryToken = null;
      await secureStorage.delete(key: AppConfig.authTokenKey);

      final errorCode = err.response?.headers.value('x-error-code');
      if (errorCode != null && _tenantBlockedCodes.contains(errorCode)) {
        onTenantBlocked?.call(errorCode);
      }
    }
    handler.next(err);
  }
}
