import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:check_point_v2/core/app/app_config.dart';

class AuthTokenInterceptor extends Interceptor {
  AuthTokenInterceptor({required this.secureStorage});

  final FlutterSecureStorage secureStorage;
  static String? _inMemoryToken;

  static void updateToken(String? token) {
    _inMemoryToken = token;
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
    }
    handler.next(err);
  }
}
