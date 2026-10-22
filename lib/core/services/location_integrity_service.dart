import 'dart:math';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_sample.dart';
import 'location_integrity_result.dart';

class LocationIntegrityService {
  static const MethodChannel _channel = MethodChannel(
    'com.systmgulf.checkpoint/location_integrity',
  );

  static const double _maxAccuracyMeters = 50.0;
  static const double _maxSpeedMs = 39.0;
  static const int _maxStalenessMs = 30000;
  static const double _maxJumpMeters = 500.0;
  static const int _jumpWindowMs = 3000;

  LocationSample? _lastAcceptedSample;

  Future<LocationIntegrityResult> assess(LocationSample sample) async {
    final nativeResult = await _runNativeCheck(sample);
    if (nativeResult != null) return nativeResult;

    if (sample.accuracy > _maxAccuracyMeters) {
      return LocationIntegrityResult(
        status: LocationIntegrityStatus.lowAccuracy,
        reasonCode: 'accuracy_too_low',
        details:
            'Accuracy: ${sample.accuracy.toStringAsFixed(1)} m '
            '(max $_maxAccuracyMeters m)',
      );
    }

    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final ageMs = nowMs - sample.timestampMs;
    if (ageMs > _maxStalenessMs || ageMs < -5000) {
      return LocationIntegrityResult(
        status: LocationIntegrityStatus.locationAnomaly,
        reasonCode: 'stale_timestamp',
        details: 'Age: ${ageMs}ms (max $_maxStalenessMs ms)',
      );
    }

    if (sample.speed > _maxSpeedMs) {
      return LocationIntegrityResult(
        status: LocationIntegrityStatus.locationAnomaly,
        reasonCode: 'impossible_speed',
        details:
            'Speed: ${sample.speed.toStringAsFixed(1)} m/s (max $_maxSpeedMs m/s)',
      );
    }

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

    _lastAcceptedSample = sample;
    return const LocationIntegrityResult(
      status: LocationIntegrityStatus.trusted,
      reasonCode: 'passed',
    );
  }

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

      return null;
    } on MissingPluginException {
      return null;
    } catch (e) {
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

  void reset() => _lastAcceptedSample = null;
}
