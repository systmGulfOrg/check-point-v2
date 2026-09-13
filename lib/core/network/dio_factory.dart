import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:check_point_v2/core/app/app_config.dart';
import 'auth_token_interceptor.dart';

class DioFactory {
  const DioFactory._();

  static Dio create({required FlutterSecureStorage secureStorage}) {
    return Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
      ..interceptors.add(AuthTokenInterceptor(secureStorage: secureStorage))
      ..interceptors.add(
        PrettyDioLogger(
          enabled: kDebugMode,
          requestHeader: false,
          requestBody: false,
          responseHeader: false,
          responseBody: false,
          error: true,
          compact: true,
          maxWidth: 120,
        ),
      );
  }
}
