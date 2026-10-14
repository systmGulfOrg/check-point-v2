import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

class AppImageCompressor {
  const AppImageCompressor._();

  /// Resizes and compresses image [bytes] to a max dimension of [maxDimension].
  /// Returns a data URL string like `data:image/jpeg;base64,...`.
  static Future<String> compressAndEncodeBase64(
    Uint8List bytes, {
    int maxDimension = 768,
    String mimeType = 'image/jpeg',
  }) async {
    try {
      final imageDescriptor = await ui.ImmutableBuffer.fromUint8List(bytes);
      final imageInfo = await ui.ImageDescriptor.encoded(imageDescriptor);
      final largestDimension = imageInfo.width > imageInfo.height
          ? imageInfo.width
          : imageInfo.height;
      final scale = maxDimension / largestDimension;
      final targetWidth = (imageInfo.width * scale)
          .round()
          .clamp(1, maxDimension)
          .toInt();
      final targetHeight = (imageInfo.height * scale)
          .round()
          .clamp(1, maxDimension)
          .toInt();
      imageInfo.dispose();
      imageDescriptor.dispose();

      final codec = await ui.instantiateImageCodec(
        bytes,
        targetWidth: targetWidth,
        targetHeight: targetHeight,
      );
      final frame = await codec.getNextFrame();
      final image = frame.image;
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final resizedBytes = byteData.buffer.asUint8List();
        return 'data:$mimeType;base64,${base64Encode(resizedBytes)}';
      }
    } catch (_) {
      // Fallback to original bytes
    }
    return 'data:$mimeType;base64,${base64Encode(bytes)}';
  }

  /// If [base64String] is a huge data URI or base64 string, compresses it.
  static Future<String?> compressExistingBase64(
    String? base64String, {
    int maxDimension = 768,
  }) async {
    if (base64String == null || base64String.isEmpty) return base64String;
    if (base64String.startsWith('http://') ||
        base64String.startsWith('https://')) {
      return base64String;
    }
    try {
      String clean = base64String;
      if (clean.contains(',')) {
        clean = clean.split(',').last;
      }
      if (clean.length < 130000) return base64String;

      final bytes = base64Decode(clean);
      return await compressAndEncodeBase64(bytes, maxDimension: maxDimension);
    } catch (_) {
      return base64String;
    }
  }
}
