import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:check_point_v2/core/app/app_config.dart';
import 'package:check_point_v2/core/tenant/tenant_storage.dart';

class AuthTokenInterceptor extends QueuedInterceptor {
  AuthTokenInterceptor({
    required this.secureStorage,
    this.tenantStorage,
  });

  final FlutterSecureStorage secureStorage;
  final TenantStorage? tenantStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.read(key: AppConfig.authTokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    if (tenantStorage != null) {
      final tenantId = await tenantStorage!.readTenantId();
      if (tenantId != null && tenantId.isNotEmpty) {
        options.headers['X-Tenant-Id'] = tenantId;
      }
      final tenantCode = await tenantStorage!.readTenantCode();
      if (tenantCode != null && tenantCode.isNotEmpty) {
        options.headers['X-Tenant-Code'] = tenantCode;
      }
    }

    handler.next(options);
  }
}
