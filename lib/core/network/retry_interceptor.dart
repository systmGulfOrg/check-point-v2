import 'dart:async';
import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    this.maxRetries = 2,
    this.retryDelay = const Duration(milliseconds: 1000),
  });

  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  static const _retryCountKey = 'retry_count';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    final currentRetryCount =
        (requestOptions.extra[_retryCountKey] as int?) ?? 0;

    if (_shouldRetry(err) && currentRetryCount < maxRetries) {
      requestOptions.extra[_retryCountKey] = currentRetryCount + 1;

      await Future<void>.delayed(retryDelay * (currentRetryCount + 1));

      try {
        final response = await dio.fetch<dynamic>(requestOptions);
        return handler.resolve(response);
      } on DioException catch (retryErr) {
        return super.onError(retryErr, handler);
      } catch (e) {
        return super.onError(err, handler);
      }
    }

    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException error) {
    if (error.type == DioExceptionType.cancel) return false;

    // Retry on timeouts and connection failures
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      return true;
    }

    // Retry on temporary server errors (502, 503, 504)
    final statusCode = error.response?.statusCode;
    if (statusCode != null &&
        (statusCode == 502 || statusCode == 503 || statusCode == 504)) {
      return true;
    }

    return false;
  }
}
