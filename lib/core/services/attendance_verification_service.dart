import 'dart:io';
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../auth/biometric_auth_service.dart';
import 'location_sample.dart';
import 'location_integrity_result.dart';
import 'location_integrity_service.dart';
import 'location_service.dart';
import 'play_integrity_service.dart';

class AttendanceVerificationResult {
  const AttendanceVerificationResult({
    required this.isAllowed,
    this.location,
    this.messageKey,
    this.integrityResult,
    this.playIntegrityPackage,
  });

  final bool isAllowed;
  final LatLng? location;
  final String? messageKey;

  final LocationIntegrityResult? integrityResult;

  final IntegrityTokenPackage? playIntegrityPackage;
}

class AttendanceVerificationService {
  AttendanceVerificationService({
    required this.locationService,
    required this.biometricAuthService,
    required this.locationIntegrityService,
    this.playIntegrityService,
  });

  final LocationService locationService;
  final BiometricAuthService biometricAuthService;
  final LocationIntegrityService locationIntegrityService;
  final PlayIntegrityService? playIntegrityService;

  Future<AttendanceVerificationResult> verify({
    required String biometricReason,
    String action = 'clock_in',
    String? deviceId,
    LatLng? center,
    double radiusMeters = 150,
    List<LatLng> polygon = const [],
    bool requireLocation = true,
    bool requirePlayIntegrity = true,
  }) async {
    LocationIntegrityResult? integrityResult;
    LatLng? location;
    LocationSample? sample;

    if (requireLocation) {
      sample = await locationService.getCurrentSample();
      if (sample == null) {
        return const AttendanceVerificationResult(
          isAllowed: false,
          messageKey: 'errors.locationUnavailable',
        );
      }

      integrityResult = await locationIntegrityService.assess(sample);
      if (!integrityResult.isAllowed) {
        return AttendanceVerificationResult(
          isAllowed: false,
          messageKey: integrityResult.messageKey,
          integrityResult: integrityResult,
        );
      }

      location = sample.position;

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
    }

    IntegrityTokenPackage? playIntegrityPackage;
    if (Platform.isAndroid &&
        requirePlayIntegrity &&
        playIntegrityService != null) {
      playIntegrityPackage = await playIntegrityService!.acquireTokenForAction(
        action: action,
        latitude: sample?.position.latitude,
        longitude: sample?.position.longitude,
        accuracy: sample?.accuracy,
        deviceId: deviceId,
        timestamp: sample?.timestampMs,
      );

      if (playIntegrityPackage == null) {
        return AttendanceVerificationResult(
          isAllowed: false,
          location: location,
          messageKey: 'errors.deviceIntegrityFailed',
          integrityResult: integrityResult,
        );
      }
    }

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
          playIntegrityPackage: playIntegrityPackage,
        );
      }
    }

    return AttendanceVerificationResult(
      isAllowed: true,
      location: location,
      integrityResult: integrityResult,
      playIntegrityPackage: playIntegrityPackage,
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
