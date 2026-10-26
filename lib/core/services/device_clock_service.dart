import 'package:flutter/services.dart';

class DeviceClockSnapshot {
  final int monotonicMs;
  final String bootId;
  final DateTime wallClock;

  const DeviceClockSnapshot({
    required this.monotonicMs,
    required this.bootId,
    required this.wallClock,
  });
}

class DeviceClockService {
  static const MethodChannel _channel = MethodChannel('com.systmgulf.checkpoint/device_clock');
  static final Stopwatch _fallbackStopwatch = Stopwatch()..start();

  Future<DeviceClockSnapshot> getClockSnapshot() async {
    final now = DateTime.now().toUtc();
    try {
      final res = await _channel.invokeMapMethod<String, dynamic>('getClockSnapshot');
      if (res != null && res['monotonicMs'] != null && res['bootId'] != null) {
        final mono = (res['monotonicMs'] as num).toInt();
        final bootId = res['bootId'].toString();
        return DeviceClockSnapshot(
          monotonicMs: mono,
          bootId: bootId,
          wallClock: now,
        );
      }
    } catch (_) {
      // Fallback if native channel is unavailable or during tests
    }

    return DeviceClockSnapshot(
      monotonicMs: _fallbackStopwatch.elapsedMilliseconds,
      bootId: 'fallback-boot-0',
      wallClock: now,
    );
  }
}
