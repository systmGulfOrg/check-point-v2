import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/services/location_integrity_service.dart';
import 'package:check_point_v2/core/services/location_integrity_result.dart';
import 'package:check_point_v2/core/services/location_sample.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('com.systmgulf.checkpoint/location_integrity');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          return <String, dynamic>{
            'isMock': false,
            'mockCheckAvailable': true,
            'detectionMethod': 'test',
            'apiLevel': 35,
          };
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  LocationSample sample({
    double latitude = 30.0444,
    double longitude = 31.2357,
    double accuracy = 10,
    int? timestampMs,
    bool? isMockFromNative = false,
  }) {
    return LocationSample(
      position: LatLng(latitude, longitude),
      accuracy: accuracy,
      timestampMs: timestampMs ?? DateTime.now().millisecondsSinceEpoch,
      speed: 0,
      provider: 'gps',
      isMockFromNative: isMockFromNative,
    );
  }

  test('rejects a sample explicitly marked as mock by Android', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          return <String, dynamic>{
            'isMock': true,
            'mockCheckAvailable': true,
            'detectionMethod': 'test',
          };
        });

    final result = await LocationIntegrityService().assess(sample());

    expect(result.status, LocationIntegrityStatus.mockLocationDetected);
  });

  test('accepts a fresh accurate GPS sample', () async {
    final result = await LocationIntegrityService().assess(sample());

    expect(result.status, LocationIntegrityStatus.trusted);
  });

  test('classifies poor accuracy without calling it mock', () async {
    final result = await LocationIntegrityService().assess(
      sample(accuracy: 100),
    );

    expect(result.status, LocationIntegrityStatus.lowAccuracy);
    expect(result.reasonCode, 'accuracy_too_low');
  });

  test('rejects an impossible coordinate jump', () async {
    final service = LocationIntegrityService();
    final now = DateTime.now().millisecondsSinceEpoch;

    await service.assess(sample(timestampMs: now));
    final result = await service.assess(
      sample(latitude: 30.0544, timestampMs: now + 1000),
    );

    expect(result.status, LocationIntegrityStatus.locationAnomaly);
    expect(result.reasonCode, 'position_jump');
  });

  test('rejects a replayed sample', () async {
    final service = LocationIntegrityService();
    final first = sample(timestampMs: DateTime.now().millisecondsSinceEpoch);

    await service.assess(first);
    final result = await service.assess(first);

    expect(result.status, LocationIntegrityStatus.locationAnomaly);
    expect(result.reasonCode, 'replayed_sample');
  });

  test('returns unknown when native mock metadata is unavailable', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          return <String, dynamic>{
            'isMock': false,
            'mockCheckAvailable': false,
          };
        });

    final result = await LocationIntegrityService().assess(
      sample(isMockFromNative: null),
    );

    expect(result.status, LocationIntegrityStatus.unknown);
    expect(result.reasonCode, 'native_mock_signal_unavailable');
  });

  test('continues location validation when the native channel is unavailable',
      () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);

    final result = await LocationIntegrityService().assess(sample());

    expect(result.status, LocationIntegrityStatus.trusted);
  });
}
