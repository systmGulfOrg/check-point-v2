import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../auth/biometric_auth_service.dart';
import 'location_integrity_result.dart';
import 'location_integrity_service.dart';
import 'location_service.dart';

class AttendanceVerificationResult {
  const AttendanceVerificationResult({
    required this.isAllowed,
    this.location,
    this.messageKey,
    this.integrityResult,
  });

  final bool isAllowed;
  final LatLng? location;
  final String? messageKey;

  /// The integrity assessment for this verification attempt. May be null if
  /// the location was unavailable before integrity could be checked.
  final LocationIntegrityResult? integrityResult;
}

class AttendanceVerificationService {
  AttendanceVerificationService({
    required this.locationService,
    required this.biometricAuthService,
    required this.locationIntegrityService,
  });

  final LocationService locationService;
  final BiometricAuthService biometricAuthService;
  final LocationIntegrityService locationIntegrityService;

  Future<AttendanceVerificationResult> verify({
    required String biometricReason,
    LatLng? center,
    double radiusMeters = 150,
    List<LatLng> polygon = const [],
  }) async {
    // 1. Obtain an enriched location sample
    final sample = await locationService.getCurrentSample();
    if (sample == null) {
      return const AttendanceVerificationResult(
        isAllowed: false,
        messageKey: 'errors.locationUnavailable',
      );
    }

    // 2. Location integrity check (mock detection + anomaly analysis)
    final integrityResult = await locationIntegrityService.assess(sample);
    if (!integrityResult.isAllowed) {
      return AttendanceVerificationResult(
        isAllowed: false,
        messageKey: integrityResult.messageKey,
        integrityResult: integrityResult,
      );
    }

    final location = sample.position;

    // 3. Geofence check
    if (!isWithinArea(
      point: location,
      center: center,
      radiusMeters: radiusMeters,
      polygon: polygon,
    )) {
      return AttendanceVerificationResult(
        isAllowed: false,
        location: null,
        messageKey: 'errors.outsideAttendanceArea',
        integrityResult: integrityResult,
      );
    }

    // 4. Biometric authentication
    final isBiometricAvailable = await biometricAuthService.isAvailable();
    if (isBiometricAvailable) {
      final authenticated = await biometricAuthService.authenticate(
        localizedReason: biometricReason,
      );
      if (!authenticated) {
        return AttendanceVerificationResult(
          isAllowed: false,
          messageKey: 'errors.biometricRequired',
          integrityResult: integrityResult,
        );
      }
    }

    return AttendanceVerificationResult(
      isAllowed: true,
      location: location,
      integrityResult: integrityResult,
    );
  }

  bool isWithinArea({
    required LatLng point,
    LatLng? center,
    double radiusMeters = 150,
    List<LatLng> polygon = const [],
  }) {
    final insideCircle =
        center == null || _distanceMeters(center, point) <= radiusMeters;
    final insidePolygon = polygon.isEmpty || _isInsidePolygon(point, polygon);
    return insideCircle && insidePolygon;
  }

  double _distanceMeters(LatLng first, LatLng second) {
    const earthRadius = 6371000.0;
    final lat1 = first.latitude * pi / 180;
    final lat2 = second.latitude * pi / 180;
    final dLat = (second.latitude - first.latitude) * pi / 180;
    final dLon = (second.longitude - first.longitude) * pi / 180;
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    return earthRadius * 2 * atan2(sqrt(a), sqrt(1 - a));
  }

  bool _isInsidePolygon(LatLng point, List<LatLng> polygon) {
    var intersections = 0;
    for (var i = 0; i < polygon.length; i++) {
      final next = (i + 1) % polygon.length;
      final first = polygon[i];
      final second = polygon[next];
      if ((first.longitude > point.longitude) !=
          (second.longitude > point.longitude)) {
        final latitude =
            (second.latitude - first.latitude) *
                (point.longitude - first.longitude) /
                (second.longitude - first.longitude) +
            first.latitude;
        if (point.latitude < latitude) intersections++;
      }
    }
    return intersections.isOdd;
  }
}
