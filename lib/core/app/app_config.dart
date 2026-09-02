class AppConfig {
  const AppConfig._();

  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String env = String.fromEnvironment('ENV', defaultValue: 'dev');
}
