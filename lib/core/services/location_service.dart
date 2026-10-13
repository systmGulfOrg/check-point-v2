import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_sample.dart';

class LocationService {
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// Returns the current position as a plain [LatLng] for backwards
  /// compatibility with code that does not yet use integrity checks.
  Future<LatLng?> getCurrentPosition() async {
    final sample = await getCurrentSample();
    return sample?.position;
  }

  /// Returns an enriched [LocationSample] with all metadata needed for
  /// integrity analysis. Returns null if permission is denied or an error
  /// occurs.
  Future<LocationSample?> getCurrentSample() async {
    try {
      final hasPermission = await handleLocationPermission();
      if (!hasPermission) return null;

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      return LocationSample(
        position: LatLng(position.latitude, position.longitude),
        accuracy: position.accuracy,
        timestampMs: position.timestamp.millisecondsSinceEpoch,
        speed: position.speed < 0 ? 0.0 : position.speed,
        provider: 'fused', // Geolocator uses the fused provider on Android
        isMockFromNative: position.isMocked,
      );
    } catch (_) {
      return null;
    }
  }

  Future<String?> getAddressFromCoordinates(
    double latitude,
    double longitude, {
    String? localeIdentifier,
  }) async {
    try {
      final geocoding = Geocoding();
      final placemarks = await geocoding.placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isEmpty) return null;

      final p = placemarks.first;
      final parts = <String>[
        if (p.street != null && p.street!.trim().isNotEmpty) p.street!.trim(),
        if (p.subLocality != null && p.subLocality!.trim().isNotEmpty)
          p.subLocality!.trim(),
        if (p.locality != null && p.locality!.trim().isNotEmpty)
          p.locality!.trim(),
        if (p.administrativeArea != null &&
            p.administrativeArea!.trim().isNotEmpty)
          p.administrativeArea!.trim(),
        if (p.country != null && p.country!.trim().isNotEmpty)
          p.country!.trim(),
      ];

      return parts.where((part) => part.isNotEmpty).join(', ');
    } catch (_) {
      return null;
    }
  }
}
