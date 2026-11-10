
import 'package:check_point_v2/core/utils/app_image_compressor.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final original = AppImageCompressor.encodeJpeg;
  tearDown(() => AppImageCompressor.encodeJpeg = original);

  group('AppImageCompressor.compressAndEncodeBase64', () {
    test('returns a JPEG data URL of the compressed bytes', () async {
      int? dimension;
      int? quality;
      AppImageCompressor.encodeJpeg = (bytes, max, q) async {
        dimension = max;
        quality = q;
        return Uint8List.fromList([1, 2, 3]);
      };

      final result = await AppImageCompressor.compressAndEncodeBase64(
        Uint8List.fromList(List.filled(1000, 7)),
      );

      expect(result, 'data:image/jpeg;base64,AQID');
      expect(dimension, AppImageCompressor.defaultMaxDimension);
      expect(quality, AppImageCompressor.jpegQuality);
    });

    test('returns null (never the original bytes) when compression fails', () async {
      AppImageCompressor.encodeJpeg = (_, _, _) async => throw PlatformException(code: 'decode');
      final result = await AppImageCompressor.compressAndEncodeBase64(
        Uint8List.fromList(List.filled(1000, 7)),
      );
      expect(result, isNull);
    });

    test('returns null for an empty result', () async {
      AppImageCompressor.encodeJpeg = (_, _, _) async => Uint8List(0);
      expect(await AppImageCompressor.compressAndEncodeBase64(Uint8List(10)), isNull);
    });
  });

  group('AppImageCompressor.compressExistingBase64', () {
    test('keeps URLs and small values unchanged', () async {
      expect(await AppImageCompressor.compressExistingBase64('https://x/y.jpg'), 'https://x/y.jpg');
      expect(await AppImageCompressor.compressExistingBase64('/api/v2/media/a'), '/api/v2/media/a');
      expect(await AppImageCompressor.compressExistingBase64('data:image/jpeg;base64,AQID'), 'data:image/jpeg;base64,AQID');
    });
  });
}
