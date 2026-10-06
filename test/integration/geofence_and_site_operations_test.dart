import 'package:flutter_test/flutter_test.dart';
import 'package:check_point_v2/core/services/geofence_policy_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  group('Integration Flow: Geofencing Polygon Calculations & Supervisor Field Operations', () {
    const geofenceService = GeofencePolicyService();

    // Define a square polygon around Cairo Coordinates
    // (30.0, 31.0) to (30.1, 31.1)
    const polygon = [
      LatLng(30.0, 31.0),
      LatLng(30.1, 31.0),
      LatLng(30.1, 31.1),
      LatLng(30.0, 31.1),
    ];

    test('3.1 Point inside polygon is accepted', () {
      final result = geofenceService.validate(
        point: const LatLng(30.05, 31.05),
        boundaryType: 'polygon',
        polygon: polygon,
        accuracyMeters: 15.0,
      );

      expect(result.isInside, isTrue);
      expect(result.failure, GeofenceFailure.none);
    });

    test('3.2 Point on polygon boundary is accepted', () {
      final result = geofenceService.validate(
        point: const LatLng(30.0, 31.05),
        boundaryType: 'polygon',
        polygon: polygon,
        accuracyMeters: 20.0,
      );

      expect(result.isInside, isTrue);
      expect(result.failure, GeofenceFailure.none);
    });

    test('3.3 Point outside polygon is rejected', () {
      final result = geofenceService.validate(
        point: const LatLng(30.15, 31.05),
        boundaryType: 'polygon',
        polygon: polygon,
        accuracyMeters: 10.0,
      );

      expect(result.isInside, isFalse);
      expect(result.failure, GeofenceFailure.outside);
    });

    test('3.4 Poor GPS accuracy is rejected before location evaluation', () {
      final result = geofenceService.validate(
        point: const LatLng(30.05, 31.05), // Inside position
        boundaryType: 'polygon',
        polygon: polygon,
        accuracyMeters: 185.0, // High inaccuracy > maxAccuracyMeters (100m)
      );

      expect(result.isInside, isFalse);
      expect(result.failure, GeofenceFailure.poorAccuracy);
    });

    test('3.5 Irregular L-shaped Concave Polygon detection', () {
      const lPolygon = [
        LatLng(0, 0),
        LatLng(0, 4),
        LatLng(2, 4),
        LatLng(2, 2),
        LatLng(4, 2),
        LatLng(4, 0),
      ];

      // Point inside first arm
      expect(
        geofenceService.validate(
          point: const LatLng(1, 3),
          boundaryType: 'polygon',
          polygon: lPolygon,
          accuracyMeters: 10.0,
        ).isInside,
        isTrue,
      );

      // Point in the cut-out corner (outside the L)
      expect(
        geofenceService.validate(
          point: const LatLng(3, 3),
          boundaryType: 'polygon',
          polygon: lPolygon,
          accuracyMeters: 10.0,
        ).isInside,
        isFalse,
      );
    });
  });
}
