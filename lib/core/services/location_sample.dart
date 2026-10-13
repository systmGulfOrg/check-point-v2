import 'package:google_maps_flutter/google_maps_flutter.dart';

/// A single enriched GPS observation used for integrity analysis.
class LocationSample {
  const LocationSample({
    required this.position,
    required this.accuracy,
    required this.timestampMs,
    required this.speed,
    required this.provider,
    this.isMockFromNative,
    this.nativeDetectionMethod,
    this.nativeApiLevel,
  });

  final LatLng position;

  /// Horizontal accuracy radius in metres.
  final double accuracy;

  /// Unix epoch milliseconds from the device clock.
  final int timestampMs;

  /// Speed in m/s reported by the location provider.
  final double speed;

  /// Location provider string (e.g. "gps", "fused", "network").
  final String provider;

  /// The mock flag reported by the platform location provider. Null means the
  /// provider did not expose a mock-location signal.
  final bool? isMockFromNative;

  /// String identifier of the native detection API used.
  final String? nativeDetectionMethod;

  /// Android API level at the time of the check.
  final int? nativeApiLevel;

  DateTime get timestamp => DateTime.fromMillisecondsSinceEpoch(timestampMs);
}
