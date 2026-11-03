import 'package:check_point_v2/core/env/env.dart';

class AppConfig {
  const AppConfig._();

  static const bool useLocalBackend = true;

  static String get baseUrl {
    if (useLocalBackend) {
      return 'http://10.0.2.2:4100';
    }
    final url = Env.baseUrl.trim();
    if (url.isEmpty || url.contains('137.184.223.222')) {
      return 'https://app.checkpoint.systmgulf.com';
    }
    return url;
  }

  static const String privacyPolicyUrl = 'https://systmgulf.com/privacy-policy';

  static String get odooBaseUrl =>
      Env.odooBaseUrl.isNotEmpty ? Env.odooBaseUrl : baseUrl;
  static String get odooApiKey => Env.odooApiKey;
  static String get googlePlacesApiKey => Env.googlePlacesApiKey;
  static String get authTokenKey => Env.authTokenKey;
  static String get deviceTokenKey => Env.deviceTokenKey;
}
