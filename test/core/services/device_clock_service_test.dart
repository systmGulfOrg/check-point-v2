import 'package:flutter_test/flutter_test.dart';
import 'package:check_point_v2/core/services/device_clock_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('DeviceClockService returns valid snapshot with fallback when native unavailable', () async {
    final service = DeviceClockService();
    final snapshot = await service.getClockSnapshot();

    expect(snapshot.monotonicMs, isNonNegative);
    expect(snapshot.bootId, isNotEmpty);
    expect(snapshot.wallClock.isBefore(DateTime.now().toUtc().add(const Duration(seconds: 1))), isTrue);
  });
}
