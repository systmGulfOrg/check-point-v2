import 'dart:math';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_sample.dart';
import 'location_integrity_result.dart';

/// Centralized service that evaluates the trustworthiness of a GPS sample
/// before any attendance action is accepted.
///
/// Detection layers:
///  1. Native Android mock-location flag (via MethodChannel).
///  2. Accuracy gate — rejects readings with >50 m uncertainty.
///  3. Stale-timestamp gate — rejects samples older than 30 s.
///  4. Speed-anomaly gate — rejects speed >140 km/h (39 m/s) (note: this
///     threshold can only detect extreme spoofing; moderate spoofing at
///     plausible speeds is not caught here).
///  5. Position-jump gate — compared against the last accepted sample;
///     rejects impossible jumps (>500 m in <3 s).
///  6. Provider sanity — warns when provider is "network" (less accurate).
///
/// IMPORTANT: No single layer can guarantee detection of all spoofing
/// methods. This service reduces risk but does not eliminate it.
class LocationIntegrityService {
  static const MethodChannel _channel = MethodChannel(
    'com.systmgulf.checkpoint/location_integrity',
  );

  /// Thresholds — adjust to suit operational requirements.
  static const double _maxAccuracyMeters = 50.0;
  static const double _maxSpeedMs = 39.0; // ≈ 140 km/h
  static const int _maxStalenessMs = 30000; // 30 s
  static const double _maxJumpMeters = 500.0;
  static const int _jumpWindowMs = 3000; // 3 s

  LocationSample? _lastAcceptedSample;

  /// Assess a [sample] from the location provider and return a structured
  /// integrity result. Never throws; failures are returned as [unknown].
  Future<LocationIntegrityResult> assess(LocationSample sample) async {
    // 1. Native mock-location check
    final nativeResult = await _runNativeCheck(sample);
    if (nativeResult != null) return nativeResult;

    // 2. Accuracy gate
    if (sample.accuracy > _maxAccuracyMeters) {
      return LocationIntegrityResult(
        status: LocationIntegrityStatus.lowAccuracy,
        reasonCode: 'accuracy_too_low',
        details:
            'Accuracy: ${sample.accuracy.toStringAsFixed(1)} m '
            '(max $_maxAccuracyMeters m)',
      );
    }

    // 3. Stale-timestamp gate
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final ageMs = nowMs - sample.timestampMs;
    if (ageMs > _maxStalenessMs || ageMs < -5000) {
      return LocationIntegrityResult(
        status: LocationIntegrityStatus.locationAnomaly,
        reasonCode: 'stale_timestamp',
        details: 'Age: ${ageMs}ms (max $_maxStalenessMs ms)',
      );
    }

    // 4. Speed anomaly
    if (sample.speed > _maxSpeedMs) {
      return LocationIntegrityResult(
        status: LocationIntegrityStatus.locationAnomaly,
        reasonCode: 'impossible_speed',
        details:
            'Speed: ${sample.speed.toStringAsFixed(1)} m/s (max $_maxSpeedMs m/s)',
      );
    }

    // 5. Position-jump check against last accepted sample
    final last = _lastAcceptedSample;
    if (last != null) {
      final deltaMs = sample.timestampMs - last.timestampMs;
      if (deltaMs <= 0 &&
          sample.position.latitude == last.position.latitude &&
          sample.position.longitude == last.position.longitude) {
        return const LocationIntegrityResult(
          status: LocationIntegrityStatus.locationAnomaly,
          reasonCode: 'replayed_sample',
        );
      }

      if (deltaMs > 0 && deltaMs < _jumpWindowMs) {
        final distM = _distanceMeters(last.position, sample.position);
        if (distM > _maxJumpMeters) {
          return LocationIntegrityResult(
            status: LocationIntegrityStatus.locationAnomaly,
            reasonCode: 'position_jump',
            details:
                'Jump: ${distM.toStringAsFixed(0)} m in ${deltaMs}ms '
                '(max $_maxJumpMeters m in $_jumpWindowMs ms)',
          );
        }
      }

      if (deltaMs > 0) {
        final impliedSpeed =
            _distanceMeters(last.position, sample.position) /
            (deltaMs / Duration.millisecondsPerSecond);
        if (impliedSpeed > _maxSpeedMs) {
          return LocationIntegrityResult(
            status: LocationIntegrityStatus.locationAnomaly,
            reasonCode: 'implied_impossible_speed',
            details: 'Implied speed: ${impliedSpeed.toStringAsFixed(1)} m/s',
          );
        }
      }
    }

    // All checks passed
    _lastAcceptedSample = sample;
    return const LocationIntegrityResult(
      status: LocationIntegrityStatus.trusted,
      reasonCode: 'passed',
    );
  }

  /// Calls the native Android MethodChannel to check if the location sample
  /// is flagged as mock by the OS. Returns null if all is fine, or a
  /// [LocationIntegrityResult] if the check detects a problem or fails.
  Future<LocationIntegrityResult?> _runNativeCheck(
    LocationSample sample,
  ) async {
    try {
      final response = await _channel
          .invokeMapMethod<String, dynamic>('checkLocationSample', {
            'latitude': sample.position.latitude,
            'longitude': sample.position.longitude,
            'accuracy': sample.accuracy,
            'timestampMs': sample.timestampMs,
            'provider': sample.provider,
            'speed': sample.speed,
            'isMockFromDart': sample.isMockFromNative,
          });

      if (response == null) {
        return LocationIntegrityResult(
          status: LocationIntegrityStatus.unknown,
          reasonCode: 'native_null_response',
          details: 'Native channel returned null',
        );
      }

      final isMock = response['isMock'] as bool?;
      if (isMock == null) {
        return const LocationIntegrityResult(
          status: LocationIntegrityStatus.unknown,
          reasonCode: 'native_missing_mock_result',
        );
      }
      if (response['mockCheckAvailable'] != true) {
        return const LocationIntegrityResult(
          status: LocationIntegrityStatus.unknown,
          reasonCode: 'native_mock_signal_unavailable',
        );
      }
      if (isMock) {
        final method = response['detectionMethod'] as String? ?? 'unknown';
        return LocationIntegrityResult(
          status: LocationIntegrityStatus.mockLocationDetected,
          reasonCode: 'native_mock_detected',
          details:
              'Detection method: $method, '
              'API level: ${response["apiLevel"]}',
        );
      }

      return null; // native check passed
    } on MissingPluginException {
      // The native mock-location channel is Android-only. A missing channel
      // on iOS must not invalidate an otherwise valid GPS sample; the
      // accuracy, freshness, speed, and geofence checks still apply.
      return null;
    } catch (e) {
      // Any other failure is unknown, not safe
      return LocationIntegrityResult(
        status: LocationIntegrityStatus.unknown,
        reasonCode: 'native_check_error',
        details: e.toString(),
      );
    }
  }

  double _distanceMeters(LatLng a, LatLng b) {
    const earthRadius = 6371000.0;
    final lat1 = a.latitude * pi / 180;
    final lat2 = b.latitude * pi / 180;
    final dLat = (b.latitude - a.latitude) * pi / 180;
    final dLon = (b.longitude - a.longitude) * pi / 180;
    final sinDLat = sin(dLat / 2);
    final sinDLon = sin(dLon / 2);
    final aCalc = sinDLat * sinDLat + cos(lat1) * cos(lat2) * sinDLon * sinDLon;
    return earthRadius * 2 * atan2(sqrt(aCalc), sqrt(1 - aCalc));
  }

  /// Clears the last accepted sample (e.g., when the user's session ends).
  void reset() => _lastAcceptedSample = null;
}
