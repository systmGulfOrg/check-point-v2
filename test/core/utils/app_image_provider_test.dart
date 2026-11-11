import 'package:cached_network_image/cached_network_image.dart';
import 'package:check_point_v2/core/app/app_config.dart';
import 'package:check_point_v2/core/utils/app_image_provider.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppImageProvider.resolve', () {
    test('loads absolute URLs through the disk cache', () {
      final provider = AppImageProvider.resolve('https://cdn.example.com/a.jpg');
      expect(provider, isA<ResizeImage>());
      final inner = (provider! as ResizeImage).imageProvider;
      expect(inner, isA<CachedNetworkImageProvider>());
      expect((inner as CachedNetworkImageProvider).url, 'https://cdn.example.com/a.jpg');
    });

    test('resolves backend media paths against the base URL, cached', () {
      final provider = AppImageProvider.resolve('/api/v2/media/t/photos/a.jpg?sig=x&size=thumb');
      final inner = (provider! as ResizeImage).imageProvider as CachedNetworkImageProvider;
      final base = AppConfig.baseUrl.replaceFirst(RegExp(r'/+$'), '');
      expect(inner.url, '$base/api/v2/media/t/photos/a.jpg?sig=x&size=thumb');
    });

    test('returns null for empty values', () {
      expect(AppImageProvider.resolve(null), isNull);
      expect(AppImageProvider.resolve('  '), isNull);
    });
  });
}
