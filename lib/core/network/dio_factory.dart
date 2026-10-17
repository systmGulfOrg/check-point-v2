import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:check_point_v2/core/app/app_config.dart';
import 'auth_token_interceptor.dart';

class DioFactory {
  const DioFactory._();

  static Dio create({required FlutterSecureStorage secureStorage}) {
    return Dio(
        BaseOptions(
          baseUrl: AppConfig.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 20),
          sendTimeout: const Duration(seconds: 15),
          headers: {
            'Accept': 'application/json',
            'Accept-Encoding': 'gzip, deflate',
          },
        ),
      )
      ..interceptors.add(AuthTokenInterceptor(secureStorage: secureStorage))
      ..interceptors.add(
        PrettyDioLogger(
          enabled: kDebugMode,
          requestHeader: false,
          // Never dump Base64 images/documents into Android Studio logs.
          requestBody: false,
          responseHeader: false,
          responseBody: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
  }
}
