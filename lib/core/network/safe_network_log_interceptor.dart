import 'package:dio/dio.dart';

import '../utils/app_logger.dart';

class SafeNetworkLogInterceptor extends Interceptor {
  static const _startedAtKey = 'safe_network_started_at';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startedAtKey] = DateTime.now();
    AppLogger.debug('→ ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    AppLogger.debug(
      '← ${response.statusCode} ${response.requestOptions.method} '
      '${response.requestOptions.uri} (${_duration(response.requestOptions)}ms) '
      'body=${_summarize(response.data)}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error(
      '× ${err.response?.statusCode ?? 'network'} '
      '${err.requestOptions.method} ${err.requestOptions.uri} '
      '(${_duration(err.requestOptions)}ms)',
    );
    handler.next(err);
  }

  int _duration(RequestOptions options) {
    final startedAt = options.extra[_startedAtKey];
    if (startedAt is! DateTime) return 0;
    return DateTime.now().difference(startedAt).inMilliseconds;
  }

  String _summarize(Object? value) {
    if (value == null) return 'null';
    if (value is Map) {
      final entries = value.entries.map(
        (entry) => '${entry.key}:${_summarize(entry.value)}',
      );
      return '{${entries.join(', ')}}';
    }
    if (value is List) return 'list(${value.length})';
    if (value is String) return 'string(${value.length})';
    return value.runtimeType.toString();
  }
}
