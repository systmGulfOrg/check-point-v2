class AppConfig {
  const AppConfig._();

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:5000',
  );
  static const String env = String.fromEnvironment('ENV', defaultValue: 'dev');
  static const String mobileId = String.fromEnvironment(
    'MOBILE_ID',
    defaultValue: 'desktop-device',
  );
  static const String deviceToken = String.fromEnvironment(
    'DEVICE_TOKEN',
    defaultValue: 'desktop-device-token',
  );
}
