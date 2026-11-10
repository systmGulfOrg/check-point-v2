import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:check_point_v2/core/utils/app_logger.dart';

/// Shrinks photos before upload: JPEG, longest side about [maxDimension]px.
///
/// The previous version encoded PNG (lossless, about 1 MB for a 768px photo)
/// and fell back to the original full-size bytes when decoding failed, which
/// produced request bodies the server rejected as too large (HTTP 413).
/// This version never returns the original bytes: when the image cannot be
/// processed it returns `null`, and the caller shows an error instead.
class AppImageCompressor {
  const AppImageCompressor._();

  static const int defaultMaxDimension = 1280;
  static const int jpegQuality = 75;

  /// The native JPEG encoder. Replaced in tests, where no plugin is available.
  @visibleForTesting
  static Future<Uint8List> Function(Uint8List bytes, int maxDimension, int quality)
      encodeJpeg = _pluginEncodeJpeg;

  static Future<Uint8List> _pluginEncodeJpeg(Uint8List bytes, int maxDimension, int quality) =>
      FlutterImageCompress.compressWithList(
        bytes,
        minWidth: maxDimension,
        minHeight: maxDimension,
        quality: quality,
        format: CompressFormat.jpeg,
      );

  static Future<String?> compressAndEncodeBase64(
    Uint8List bytes, {
    int maxDimension = defaultMaxDimension,
  }) async {
    try {
      final output = await encodeJpeg(bytes, maxDimension, jpegQuality);
      if (output.isEmpty) return null;
      return 'data:image/jpeg;base64,${base64Encode(output)}';
    } catch (e) {
      AppLogger.error('Image compression failed: ${e.runtimeType}');
      return null;
    }
  }

  /// Re-compresses an existing large base64 photo; URLs and small values are
  /// returned unchanged, and so is the value when it cannot be processed.
  static Future<String?> compressExistingBase64(
    String? base64String, {
    int maxDimension = defaultMaxDimension,
  }) async {
    if (base64String == null || base64String.isEmpty) return base64String;
    if (base64String.startsWith('http://') ||
        base64String.startsWith('https://') ||
        base64String.startsWith('/')) {
      return base64String;
    }
    try {
      String clean = base64String;
      if (clean.contains(',')) {
        clean = clean.split(',').last;
      }
      if (clean.length < 130000) return base64String;

      final bytes = base64Decode(clean);
      return await compressAndEncodeBase64(bytes, maxDimension: maxDimension) ??
          base64String;
    } catch (e) {
      AppLogger.error('Existing photo could not be decoded: ${e.runtimeType}');
      return base64String;
    }
  }
}
