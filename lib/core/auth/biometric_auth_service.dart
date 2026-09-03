import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  BiometricAuthService({required this.localAuthentication});

  final LocalAuthentication localAuthentication;

  Future<bool> isAvailable() async {
    try {
      final canCheckBiometrics = await localAuthentication.canCheckBiometrics;
      final enrolledBiometrics = await localAuthentication
          .getAvailableBiometrics();
      return canCheckBiometrics && enrolledBiometrics.isNotEmpty;
    } on LocalAuthException {
      return false;
    }
  }

  Future<bool> authenticate({required String localizedReason}) async {
    try {
      return await localAuthentication.authenticate(
        localizedReason: localizedReason,
        biometricOnly: true,
      );
    } on LocalAuthException {
      return false;
    }
  }
}
