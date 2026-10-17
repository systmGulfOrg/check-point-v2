import 'package:check_point_v2/core/env/env.dart';

class AppConfig {
  const AppConfig._();

  static String get baseUrl => Env.baseUrl.isNotEmpty
      ? Env.baseUrl
      : 'https://app.checkpoint.systmgulf.com';
  static String get odooBaseUrl =>
      Env.odooBaseUrl.isNotEmpty ? Env.odooBaseUrl : baseUrl;
  static String get odooApiKey => Env.odooApiKey;
  static String get googlePlacesApiKey => Env.googlePlacesApiKey;
  static String get authTokenKey => Env.authTokenKey;
  static String get deviceTokenKey => Env.deviceTokenKey;
}
