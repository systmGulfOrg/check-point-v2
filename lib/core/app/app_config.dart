class AppConfig {
  const AppConfig._();

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://emsdemo.runasp.net',
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
