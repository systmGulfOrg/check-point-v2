import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  final double accuracy;

  final int timestampMs;

  final double speed;

  final String provider;

  final bool? isMockFromNative;

  final String? nativeDetectionMethod;

  final int? nativeApiLevel;

  DateTime get timestamp => DateTime.fromMillisecondsSinceEpoch(timestampMs);
}
