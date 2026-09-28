import 'package:check_point_v2/core/services/geofence_policy_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  const service = GeofencePolicyService();

  group('GeofencePolicyService', () {
    test('accepts a point inside a circle and returns distance', () {
      final result = service.validate(
        point: const LatLng(30.0005, 31),
        boundaryType: 'circle',
        center: const LatLng(30, 31),
        radiusMeters: 100,
      );

      expect(result.isInside, isTrue);
      expect(result.distanceMeters, lessThan(100));
    });

    test('rejects poor GPS accuracy before evaluating location', () {
      final result = service.validate(
        point: const LatLng(30, 31),
        boundaryType: 'circle',
        center: const LatLng(30, 31),
        accuracyMeters: 101,
      );

      expect(result.failure, GeofenceFailure.poorAccuracy);
    });

    test('accepts polygon interior and boundary points', () {
      const polygon = [
        LatLng(30, 31),
        LatLng(30, 31.001),
        LatLng(30.001, 31.001),
        LatLng(30.001, 31),
      ];

      expect(
        service
            .validate(
              point: const LatLng(30.0005, 31.0005),
              boundaryType: 'polygon',
              polygon: polygon,
            )
            .isInside,
        isTrue,
      );
      expect(
        service
            .validate(
              point: const LatLng(30, 31),
              boundaryType: 'polygon',
              polygon: polygon,
            )
            .isInside,
        isTrue,
      );
    });

    test('rejects invalid polygon and outside points', () {
      expect(
        service
            .validate(
              point: const LatLng(30, 31),
              boundaryType: 'polygon',
              polygon: const [LatLng(30, 31), LatLng(30, 31.001)],
            )
            .failure,
        GeofenceFailure.invalidBoundary,
      );
      expect(
        service
            .validate(
              point: const LatLng(31, 32),
              boundaryType: 'polygon',
              polygon: const [
                LatLng(30, 31),
                LatLng(30, 31.001),
                LatLng(30.001, 31.001),
                LatLng(30.001, 31),
              ],
            )
            .failure,
        GeofenceFailure.outside,
      );
    });
  });
}
