import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';

import 'package:check_point_v2/core/auth/biometric_auth_service.dart';
import 'package:check_point_v2/core/services/attendance_verification_service.dart';
import 'package:check_point_v2/core/services/location_integrity_service.dart';
import 'package:check_point_v2/core/services/location_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('remote attendance does not require device location', () async {
    final service = AttendanceVerificationService(
      locationService: LocationService(),
      biometricAuthService: BiometricAuthService(
        localAuthentication: LocalAuthentication(),
      ),
      locationIntegrityService: LocationIntegrityService(),
    );

    final result = await service.verify(
      biometricReason: 'Test remote attendance',
      requireLocation: false,
    );

    expect(result.isAllowed, isTrue);
    expect(result.location, isNull);
  });
}
