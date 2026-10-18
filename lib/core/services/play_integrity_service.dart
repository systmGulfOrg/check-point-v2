import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'package:check_point_v2/core/utils/app_logger.dart';

class IntegrityTokenPackage {
  const IntegrityTokenPackage({
    required this.token,
    required this.challenge,
    required this.requestHash,
  });

  final String token;
  final String challenge;
  final String requestHash;
}

/// Service managing Google Play Integrity API requests on Android.
///
/// Uses the Standard Integrity API flow with cloud project number 481143074801.
class PlayIntegrityService {
  PlayIntegrityService({
    required this.dio,
    MethodChannel? channel,
  }) : channel =
           channel ??
           const MethodChannel('com.systmgulf.checkpoint/play_integrity');

  final Dio dio;
  final MethodChannel channel;
  static IntegrityTokenPackage? currentPackage;
  IntegrityTokenPackage? get latestPackage => currentPackage;

  /// Builds the canonical JSON with fixed key order and coordinate precision.
  static String computeCanonicalJson({
    required String action,
    double? latitude,
    double? longitude,
    double? accuracy,
    String? deviceId,
    int? timestamp,
  }) {
    final sorted = {
      'accuracy':
          accuracy != null && accuracy.isFinite
              ? double.parse(accuracy.toStringAsFixed(1))
              : 0,
      'action': action,
      'deviceId': deviceId ?? '',
      'latitude':
          latitude != null && latitude.isFinite
              ? double.parse(latitude.toStringAsFixed(6))
              : 0,
      'longitude':
          longitude != null && longitude.isFinite
              ? double.parse(longitude.toStringAsFixed(6))
              : 0,
      'timestamp': timestamp ?? 0,
    };
    return jsonEncode(sorted);
  }

  /// Computes: base64url(SHA-256(challenge + SHA-256(canonical JSON)))
  static String computeRequestHash({
    required String challenge,
    required String canonicalJson,
  }) {
    final innerHash = sha256.convert(utf8.encode(canonicalJson)).toString();
    final outerBytes = sha256.convert(utf8.encode(challenge + innerHash)).bytes;
    return base64Url.encode(outerBytes).replaceAll('=', '');
  }

  /// Warms up the Standard Integrity token provider with retry.
  Future<bool> prepareIntegrityToken({int retries = 2}) async {
    if (!Platform.isAndroid) return false;

    for (var attempt = 0; attempt <= retries; attempt++) {
      try {
        final success = await channel.invokeMethod<bool>('prepareIntegrityToken');
        if (success == true) return true;
      } catch (e) {
        AppLogger.error('Attempt $attempt: Failed to prepare Play Integrity token: $e');
        if (attempt < retries) {
          await Future<void>.delayed(const Duration(milliseconds: 1000));
        }
      }
    }
    return false;
  }

  /// Requests a fresh single-use challenge from the backend.
  Future<String?> requestChallenge({
    required String action,
    String? deviceId,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/api/v2/integrity/challenge',
        data: {
          'action': action,
          'deviceId': ?deviceId,
        },
      );
      final data = response.data;
      if (data == null) return null;

      if (data['value'] is Map<String, dynamic>) {
        return (data['value'] as Map<String, dynamic>)['challenge'] as String?;
      }
      return data['challenge'] as String?;
    } catch (e) {
      AppLogger.error('Failed to request integrity challenge: $e');
      return null;
    }
  }

  /// Acquires an integrity token bound to the request payload and challenge.
  /// If provider is expired or fails, re-prepares and retries once.
  Future<IntegrityTokenPackage?> acquireTokenForAction({
    required String action,
    double? latitude,
    double? longitude,
    double? accuracy,
    String? deviceId,
    int? timestamp,
  }) async {
    if (!Platform.isAndroid) return null;

    final challenge = await requestChallenge(action: action, deviceId: deviceId);
    if (challenge == null) {
      AppLogger.error('Cannot acquire integrity token: Challenge request failed');
      return null;
    }

    final canonicalJson = computeCanonicalJson(
      action: action,
      latitude: latitude,
      longitude: longitude,
      accuracy: accuracy,
      deviceId: deviceId,
      timestamp: timestamp,
    );

    final requestHash = computeRequestHash(
      challenge: challenge,
      canonicalJson: canonicalJson,
    );

    var token = await _requestNativeToken(requestHash);

    // If failed, re-prepare and retry once
    if (token == null) {
      AppLogger.debug('Integrity token request failed; re-preparing provider and retrying...');
      await prepareIntegrityToken(retries: 1);
      token = await _requestNativeToken(requestHash);
    }

    if (token == null) return null;

    final package = IntegrityTokenPackage(
      token: token,
      challenge: challenge,
      requestHash: requestHash,
    );
    currentPackage = package;
    return package;
  }

  Future<String?> _requestNativeToken(String requestHash) async {
    try {
      return await channel.invokeMethod<String>(
        'requestIntegrityToken',
        {'requestHash': requestHash},
      );
    } catch (e) {
      AppLogger.error('Error invoking requestIntegrityToken: $e');
      return null;
    }
  }
}
