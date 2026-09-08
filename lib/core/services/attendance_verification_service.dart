import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../auth/biometric_auth_service.dart';
import 'location_service.dart';

class AttendanceVerificationResult {
  const AttendanceVerificationResult({
    required this.isAllowed,
    this.location,
    this.messageKey,
  });

  final bool isAllowed;
  final LatLng? location;
  final String? messageKey;
}

class AttendanceVerificationService {
  AttendanceVerificationService({
    required this.locationService,
    required this.biometricAuthService,
  });

  final LocationService locationService;
  final BiometricAuthService biometricAuthService;

  Future<AttendanceVerificationResult> verify({
    required String biometricReason,
    LatLng? center,
    double radiusMeters = 150,
    List<LatLng> polygon = const [],
  }) async {
    final location = await locationService.getCurrentPosition();
    if (location == null) {
      return const AttendanceVerificationResult(
        isAllowed: false,
        messageKey: 'errors.locationUnavailable',
      );
    }

    if (!isWithinArea(
      point: location,
      center: center,
      radiusMeters: radiusMeters,
      polygon: polygon,
    )) {
      return const AttendanceVerificationResult(
        isAllowed: false,
        location: null,
        messageKey: 'errors.outsideAttendanceArea',
      );
    }

    final authenticated = await biometricAuthService.authenticate(
      localizedReason: biometricReason,
    );
    if (!authenticated) {
      return const AttendanceVerificationResult(
        isAllowed: false,
        messageKey: 'errors.biometricRequired',
      );
    }

    return AttendanceVerificationResult(isAllowed: true, location: location);
  }

  bool isWithinArea({
    required LatLng point,
    LatLng? center,
    double radiusMeters = 150,
    List<LatLng> polygon = const [],
  }) {
    final insideCircle = center == null ||
        _distanceMeters(center, point) <= radiusMeters;
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
