import '../app/app_config.dart';

class DeviceIdentityProvider {
  const DeviceIdentityProvider();

  String get mobileId => AppConfig.mobileId;
  String get deviceToken => AppConfig.deviceToken;
}
