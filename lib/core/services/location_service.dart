import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  Future<LatLng?> getCurrentPosition() async {
    try {
      final hasPermission = await handleLocationPermission();
      if (!hasPermission) return null;

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      return LatLng(position.latitude, position.longitude);
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
