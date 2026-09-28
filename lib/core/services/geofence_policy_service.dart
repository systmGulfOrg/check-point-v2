import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

enum GeofenceFailure { none, invalidBoundary, outside, poorAccuracy }

class GeofenceValidationResult {
  const GeofenceValidationResult({
    required this.isInside,
    this.failure = GeofenceFailure.none,
    this.distanceMeters,
  });

  final bool isInside;
  final GeofenceFailure failure;
  final double? distanceMeters;
}

/// Pure geofence policy logic shared by check-in validation and map previews.
/// It deliberately has no location or UI dependency.
class GeofencePolicyService {
  const GeofencePolicyService();

  GeofenceValidationResult validate({
    required LatLng point,
    required String boundaryType,
    LatLng? center,
    double radiusMeters = 150,
    List<LatLng> polygon = const [],
    double? accuracyMeters,
    double maxAccuracyMeters = 100,
  }) {
    final normalizedType = boundaryType.toLowerCase();
    if (normalizedType == 'circle') {
      if (center == null || radiusMeters <= 0) {
        return const GeofenceValidationResult(
          isInside: false,
          failure: GeofenceFailure.invalidBoundary,
        );
      }
      if (accuracyMeters != null && accuracyMeters > maxAccuracyMeters) {
        return const GeofenceValidationResult(
          isInside: false,
          failure: GeofenceFailure.poorAccuracy,
        );
      }
      final distance = distanceMeters(center, point);
      return GeofenceValidationResult(
        isInside: distance <= radiusMeters,
        failure: distance <= radiusMeters
            ? GeofenceFailure.none
            : GeofenceFailure.outside,
        distanceMeters: distance,
      );
    }

    if (normalizedType != 'polygon' || polygon.length < 3) {
      return const GeofenceValidationResult(
        isInside: false,
        failure: GeofenceFailure.invalidBoundary,
      );
    }
    if (accuracyMeters != null && accuracyMeters > maxAccuracyMeters) {
      return const GeofenceValidationResult(
        isInside: false,
        failure: GeofenceFailure.poorAccuracy,
      );
    }
    final inside = _isInsidePolygon(point, polygon);
    return GeofenceValidationResult(
      isInside: inside,
      failure: inside ? GeofenceFailure.none : GeofenceFailure.outside,
    );
  }

  double distanceMeters(LatLng first, LatLng second) {
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
    for (var index = 0; index < polygon.length; index++) {
      final current = polygon[index];
      final next = polygon[(index + 1) % polygon.length];
      if (_isOnSegment(point, current, next)) return true;
    }

    var inside = false;
    for (var index = 0; index < polygon.length; index++) {
      final current = polygon[index];
      final next = polygon[(index + 1) % polygon.length];
      final crosses =
          (current.longitude > point.longitude) !=
          (next.longitude > point.longitude);
      if (!crosses) continue;
      final latitude =
          (next.latitude - current.latitude) *
              (point.longitude - current.longitude) /
              (next.longitude - current.longitude) +
          current.latitude;
      if (point.latitude < latitude) inside = !inside;
    }
    return inside;
  }

  bool _isOnSegment(LatLng point, LatLng first, LatLng second) {
    const epsilon = 1e-9;
    final cross =
        (point.latitude - first.latitude) *
            (second.longitude - first.longitude) -
        (point.longitude - first.longitude) *
            (second.latitude - first.latitude);
    if (cross.abs() > epsilon) return false;
    return point.latitude >= min(first.latitude, second.latitude) - epsilon &&
        point.latitude <= max(first.latitude, second.latitude) + epsilon &&
        point.longitude >= min(first.longitude, second.longitude) - epsilon &&
        point.longitude <= max(first.longitude, second.longitude) + epsilon;
  }
}
