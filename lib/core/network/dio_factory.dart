import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:check_point_v2/core/app/app_config.dart';
import 'package:check_point_v2/core/network/device_identity_provider.dart';
import 'package:check_point_v2/core/tenant/tenant_storage.dart';
import 'auth_token_interceptor.dart';
import 'retry_interceptor.dart';

class DioFactory {
  const DioFactory._();

  static Dio create({
    required FlutterSecureStorage secureStorage,
    TenantStorage? tenantStorage,
    DeviceIdentityProvider? deviceIdentityProvider,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    return dio
      ..interceptors.add(
        AuthTokenInterceptor(
          secureStorage: secureStorage,
          tenantStorage: tenantStorage,
          deviceIdentityProvider: deviceIdentityProvider,
        ),
      )
      ..interceptors.add(
        RetryInterceptor(dio: dio),
      )
      ..interceptors.add(
        PrettyDioLogger(
          enabled: kDebugMode,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 120,
        ),
      );
  }
}
