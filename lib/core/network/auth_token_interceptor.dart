import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:check_point_v2/core/app/app_config.dart';
import 'package:check_point_v2/core/network/api_constants.dart';
import 'package:check_point_v2/core/network/device_identity_provider.dart';
import 'package:check_point_v2/core/tenant/tenant_storage.dart';

class AuthTokenInterceptor extends QueuedInterceptor {
  AuthTokenInterceptor({
    required this.secureStorage,
    this.tenantStorage,
    this.deviceIdentityProvider,
  });

  final FlutterSecureStorage secureStorage;
  final TenantStorage? tenantStorage;
  final DeviceIdentityProvider? deviceIdentityProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.read(key: AppConfig.authTokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Device UUID injection
    String? deviceUuid;
    if (deviceIdentityProvider != null) {
      deviceUuid = await deviceIdentityProvider!.getOrGenerateMobileId();
    } else {
      deviceUuid = await secureStorage.read(key: 'device_mobile_id');
    }
    if (deviceUuid != null && deviceUuid.isNotEmpty) {
      options.headers['x-device-uuid'] = deviceUuid;
    }

    // Tenant slug injection
    if (tenantStorage != null) {
      final tenantSlug = await tenantStorage!.readTenantSlug();
      if (tenantSlug != null && tenantSlug.isNotEmpty) {
        options.headers['x-tenant-slug'] = tenantSlug;
      }
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

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.path;

    // Avoid refresh loops for login or refresh calls themselves
    final isAuthEndpoint =
        path.contains(ApiConstants.login) ||
        path.contains(ApiConstants.refreshToken) ||
        path.toLowerCase().contains('/auth/login') ||
        path.toLowerCase().contains('/auth/refresh');

    if (statusCode == 401 && !isAuthEndpoint) {
      final refreshToken = await secureStorage.read(key: 'refresh_token');
      final tenantSlug =
          await tenantStorage?.readTenantSlug() ??
          await tenantStorage?.readTenantCode() ??
          '';

      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          final refreshDio = Dio(
            BaseOptions(
              baseUrl: AppConfig.baseUrl,
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 15),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                if (tenantSlug.isNotEmpty) 'x-tenant-slug': tenantSlug,
              },
            ),
          );

          final refreshResponse = await refreshDio.post(
            ApiConstants.refreshToken,
            data: {
              'tenantSlug': tenantSlug,
              'refreshToken': refreshToken,
            },
          );

          final responseData = refreshResponse.data;
          String? newAccessToken;
          String? newRefreshToken;

          if (responseData is Map) {
            final value = responseData['value'];
            if (value is Map) {
              newAccessToken =
                  value['accessToken'] as String? ??
                  value['token'] as String?;
              newRefreshToken = value['refreshToken'] as String?;
            } else {
              newAccessToken =
                  responseData['accessToken'] as String? ??
                  responseData['token'] as String?;
              newRefreshToken = responseData['refreshToken'] as String?;
            }
          }

          if (newAccessToken != null && newAccessToken.isNotEmpty) {
            await secureStorage.write(
              key: AppConfig.authTokenKey,
              value: newAccessToken,
            );
            if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
              await secureStorage.write(
                key: 'refresh_token',
                value: newRefreshToken,
              );
            }

            // Retry failed request with new access token
            final retryOptions = err.requestOptions;
            retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
            if (tenantSlug.isNotEmpty) {
              retryOptions.headers['x-tenant-slug'] = tenantSlug;
            }

            final retryDio = Dio(
              BaseOptions(
                baseUrl: AppConfig.baseUrl,
                connectTimeout: const Duration(seconds: 30),
                receiveTimeout: const Duration(seconds: 30),
              ),
            );

            final retryResponse = await retryDio.fetch(retryOptions);
            return handler.resolve(retryResponse);
          }
        } catch (_) {
          // Token renewal failed completely - clear invalid session
          await secureStorage.delete(key: AppConfig.authTokenKey);
          await secureStorage.delete(key: 'refresh_token');
        }
      }
    }

    handler.next(err);
  }
}
