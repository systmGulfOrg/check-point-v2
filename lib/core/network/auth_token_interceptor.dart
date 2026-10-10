import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:check_point_v2/core/app/app_config.dart';

class AuthTokenInterceptor extends QueuedInterceptor {
  AuthTokenInterceptor({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.read(key: AppConfig.authTokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
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
      await secureStorage.delete(key: AppConfig.authTokenKey);
    }
    handler.next(err);
  }
}
