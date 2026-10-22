import 'dart:async';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationLinkParser {
  static Future<LatLng?> parseLocation(String input) async {
    final trimmed = input.trim();
    if (trimmed.isEmpty) return null;

    LatLng? parsed = _extractCoordinatesFromText(trimmed);
    if (parsed != null) return parsed;

    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      try {
        final client = HttpClient();
        client.connectionTimeout = const Duration(seconds: 4);
        final request = await client.getUrl(Uri.parse(trimmed));
        request.followRedirects = true;
        request.maxRedirects = 5;
        final response = await request.close();
        final redirectLocation = response.headers.value(
          HttpHeaders.locationHeader,
        );
        final finalUrl = response.redirects.isNotEmpty
            ? response.redirects.last.location.toString()
            : (redirectLocation ?? trimmed);
        client.close();

        if (finalUrl.isNotEmpty) {
          parsed = _extractCoordinatesFromText(finalUrl);
          if (parsed != null) return parsed;
        }
      } catch (_) {}
    }

    return null;
  }

  static LatLng? _extractCoordinatesFromText(String text) {
    final atPattern = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
    final atMatch = atPattern.firstMatch(text);
    if (atMatch != null) {
      final lat = double.tryParse(atMatch.group(1)!);
      final lng = double.tryParse(atMatch.group(2)!);
      if (lat != null && lng != null) return LatLng(lat, lng);
    }

    final queryPattern = RegExp(
      r'[?&](?:q|ll|destination|center)=(-?\d+\.\d+),(-?\d+\.\d+)',
    );
    final queryMatch = queryPattern.firstMatch(text);
    if (queryMatch != null) {
      final lat = double.tryParse(queryMatch.group(1)!);
      final lng = double.tryParse(queryMatch.group(2)!);
      if (lat != null && lng != null) return LatLng(lat, lng);
    }

    final pathPattern = RegExp(
      r'/(?:place|dir)/[^/]*?(-?\d+\.\d+),(-?\d+\.\d+)',
    );
    final pathMatch = pathPattern.firstMatch(text);
    if (pathMatch != null) {
      final lat = double.tryParse(pathMatch.group(1)!);
      final lng = double.tryParse(pathMatch.group(2)!);
      if (lat != null && lng != null) return LatLng(lat, lng);
    }

    final rawPattern = RegExp(r'^#?\s*(-?\d+\.\d+)\s*[\s,]\s*(-?\d+\.\d+)\s*$');
    final rawMatch = rawPattern.firstMatch(text);
    if (rawMatch != null) {
      final lat = double.tryParse(rawMatch.group(1)!);
      final lng = double.tryParse(rawMatch.group(2)!);
      if (lat != null && lng != null) return LatLng(lat, lng);
    }

    final generalPattern = RegExp(r'(-?\d{1,2}\.\d+)\s*,\s*(-?\d{1,3}\.\d+)');
    final generalMatch = generalPattern.firstMatch(text);
    if (generalMatch != null) {
      final lat = double.tryParse(generalMatch.group(1)!);
      final lng = double.tryParse(generalMatch.group(2)!);
      if (lat != null && lng != null) {
        if (lat >= -90 && lat <= 90 && lng >= -180 && lng <= 180) {
          return LatLng(lat, lng);
        }
      }
    }

    return null;
  }
}
