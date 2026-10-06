import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  BiometricAuthService({required this.localAuthentication});

  final LocalAuthentication localAuthentication;

  Future<bool> isAvailable() async {
    try {
      final canCheckBiometrics = await localAuthentication.canCheckBiometrics;
      final isDeviceSupported = await localAuthentication.isDeviceSupported();
      if (!canCheckBiometrics && !isDeviceSupported) {
        return false;
      }
      final availableBiometrics =
          await localAuthentication.getAvailableBiometrics();
      return availableBiometrics.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate({required String localizedReason}) async {
    try {
      final available = await isAvailable();
      if (!available) return true;

      return await localAuthentication.authenticate(
        localizedReason: localizedReason,
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );
    } catch (_) {
      return false;
    }
  }
}
