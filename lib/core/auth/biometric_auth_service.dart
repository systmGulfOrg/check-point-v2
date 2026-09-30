import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  BiometricAuthService({required this.localAuthentication});

  final LocalAuthentication localAuthentication;

  static const Set<String> _bypassErrorCodes = {
    'NotEnrolled',
    'notEnrolled',
    'NotAvailable',
    'notAvailable',
    'PasscodeNotSet',
    'passcodeNotSet',
    'OtherOperatingSystem',
    'otherOperatingSystem',
  };

  Future<bool> isAvailable() async {
    try {
      final canCheckBiometrics = await localAuthentication.canCheckBiometrics;
      if (!canCheckBiometrics) return false;
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
      );
    } on PlatformException catch (e) {
      if (_bypassErrorCodes.contains(e.code)) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
