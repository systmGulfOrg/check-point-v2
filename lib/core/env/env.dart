import 'package:envied/envied.dart';

part 'env.g.dart';

// Environment configuration loaded from .env
@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  static final String baseUrl = _Env.baseUrl;

  @EnviedField(varName: 'ODOO_BASE_URL', obfuscate: true, defaultValue: '')
  static final String odooBaseUrl = _Env.odooBaseUrl;

  @EnviedField(varName: 'ODOO_API_KEY', obfuscate: true, defaultValue: '')
  static final String odooApiKey = _Env.odooApiKey;

  @EnviedField(
    varName: 'GOOGLE_PLACES_API_KEY',
    obfuscate: true,
    defaultValue: '',
  )
  static final String googlePlacesApiKey = _Env.googlePlacesApiKey;

  @EnviedField(
    varName: 'AUTH_TOKEN_KEY',
    obfuscate: true,
    defaultValue: 'auth_token',
  )
  static final String authTokenKey = _Env.authTokenKey;

  @EnviedField(
    varName: 'DEVICE_TOKEN_KEY',
    obfuscate: true,
    defaultValue: 'device_token',
  )
  static final String deviceTokenKey = _Env.deviceTokenKey;
}
