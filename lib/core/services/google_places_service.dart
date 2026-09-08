import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/app/app_config.dart';

class GooglePlaceSuggestion {
  const GooglePlaceSuggestion({
    required this.placeId,
    required this.description,
  });

  final String placeId;
  final String description;
}

class GooglePlaceLocation {
  const GooglePlaceLocation({required this.latLng, required this.address});

  final LatLng latLng;
  final String address;
}

class GooglePlacesService {
  GooglePlacesService({required this.dio});

  final Dio dio;

  Future<List<GooglePlaceSuggestion>> autocomplete(
    String query, {
    String language = 'en',
  }) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return const [];

    try {
      final response = await dio.get<Map<String, dynamic>>(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          'input': trimmed,
          'key': AppConfig.googlePlacesApiKey,
          'language': language,
        },
      );

      final data = response.data;
      if (data == null) return const [];

      final predictions = (data['predictions'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(
            (prediction) => GooglePlaceSuggestion(
              placeId: prediction['place_id'] as String? ?? '',
              description: prediction['description'] as String? ?? '',
            ),
          )
          .where((prediction) => prediction.placeId.isNotEmpty)
          .toList();

      return predictions;
    } catch (_) {
      return const [];
    }
  }

  Future<GooglePlaceLocation?> getPlaceLocation(
    String placeId, {
    String language = 'en',
  }) async {
    if (placeId.isEmpty) return null;

    try {
      final response = await dio.get<Map<String, dynamic>>(
        'https://maps.googleapis.com/maps/api/place/details/json',
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry/location,formatted_address,name',
          'key': AppConfig.googlePlacesApiKey,
          'language': language,
        },
      );

      final data = response.data;
      if (data == null) return null;

      final result = data['result'] as Map<String, dynamic>?;
      final geometry = result?['geometry'] as Map<String, dynamic>?;
      final location = geometry?['location'] as Map<String, dynamic>?;
      final lat = (location?['lat'] as num?)?.toDouble();
      final lng = (location?['lng'] as num?)?.toDouble();

      if (lat == null || lng == null) return null;

      return GooglePlaceLocation(
        latLng: LatLng(lat, lng),
        address:
            result?['formatted_address'] as String? ??
            result?['name'] as String? ??
            '',
      );
    } catch (_) {
      return null;
    }
  }
}
