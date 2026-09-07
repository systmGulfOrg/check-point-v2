import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  BiometricAuthService({required this.localAuthentication});

  final LocalAuthentication localAuthentication;

  Future<bool> isAvailable() async {
    try {
      final canCheckBiometrics = await localAuthentication.canCheckBiometrics;
      final isDeviceSupported = await localAuthentication.isDeviceSupported();
      final enrolledBiometrics = await localAuthentication
          .getAvailableBiometrics();
      return (canCheckBiometrics || isDeviceSupported) &&
          enrolledBiometrics.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate({required String localizedReason}) async {
    try {
      final available = await isAvailable();
      if (!available) return false;

      return await localAuthentication.authenticate(
        localizedReason: localizedReason,
        biometricOnly: false,
      );
    } catch (_) {
      return false;
    }
  }
}
