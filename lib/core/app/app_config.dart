import 'package:check_point_v2/core/env/env.dart';

class AppConfig {
  const AppConfig._();

  static String get baseUrl => Env.baseUrl;
  static String get odooBaseUrl =>
      Env.odooBaseUrl.isNotEmpty ? Env.odooBaseUrl : Env.baseUrl;
  static String get odooApiKey => Env.odooApiKey;
  static String get googlePlacesApiKey => Env.googlePlacesApiKey;
  static String get authTokenKey => Env.authTokenKey;
  static String get deviceTokenKey => Env.deviceTokenKey;
  static String get deviceToken => Env.deviceTokenKey;

  // Tenant context is configured at build time and is not selected in the UI.
  static const String tenantId = String.fromEnvironment(
    'TENANT_ID',
    defaultValue: 'samco-construction-tenant',
  );
  static const String tenantCode = String.fromEnvironment(
    'TENANT_CODE',
    defaultValue: 'samco',
  );
  static const String tenantCompanyName = String.fromEnvironment(
    'TENANT_NAME',
    defaultValue: 'SAMCO Construction',
  );
}
