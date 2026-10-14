import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:check_point_v2/core/app/app_config.dart';

class AppImageProvider {
  AppImageProvider._();

  static final Map<int, ImageProvider> _cache = {};
  static const int _maxCacheEntries = 150;

  static ImageProvider? _cacheProvider(int key, ImageProvider provider) {
    if (_cache.length >= _maxCacheEntries) {
      _cache.remove(_cache.keys.first);
    }
    _cache[key] = provider;
    return provider;
  }

  static ImageProvider? resolve(String? source) {
    if (source == null) return null;
    final trimmed = source.trim();
    if (trimmed.isEmpty) return null;

    final cacheKey = source.hashCode;
    final cached = _cache[cacheKey];
    if (cached != null) return cached;

    try {
      if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
        return _cacheProvider(
          cacheKey,
          ResizeImage(NetworkImage(trimmed), width: 400, height: 400),
        );
      }

      if (trimmed.startsWith('assets/')) {
        return _cacheProvider(cacheKey, AssetImage(trimmed));
      }

      if (trimmed.startsWith('/api/')) {
        final baseUrl = AppConfig.baseUrl.replaceFirst(RegExp(r'/+$'), '');
        return _cacheProvider(
          cacheKey,
          ResizeImage(
            NetworkImage('$baseUrl$trimmed'),
            width: 400,
            height: 400,
          ),
        );
      }

      if (trimmed.startsWith('/') || trimmed.startsWith('file://')) {
        final path = trimmed.startsWith('file://')
            ? trimmed.replaceFirst('file://', '')
            : trimmed;
        final file = File(path);
        if (file.existsSync()) {
          return _cacheProvider(cacheKey, FileImage(file));
        }
      }

      if (trimmed.startsWith('data:image')) {
        final commaIndex = trimmed.indexOf(',');
        final rawBase64 = commaIndex != -1
            ? trimmed.substring(commaIndex + 1)
            : trimmed;
        final sanitized = rawBase64.trim().replaceAll(RegExp(r'\s+'), '');
        final bytes = base64Decode(sanitized);
        return _cacheProvider(
          cacheKey,
          ResizeImage(MemoryImage(bytes), width: 400, height: 400),
        );
      }

      // Check if it's a raw base64 string
      if (trimmed.length > 20) {
        try {
          final sanitized = trimmed.replaceAll(RegExp(r'\s+'), '');
          final bytes = base64Decode(sanitized);
          return _cacheProvider(
            cacheKey,
            ResizeImage(MemoryImage(bytes), width: 400, height: 400),
          );
        } catch (_) {}
      }
    } catch (_) {
      // Silently fallback to null if image parsing or decoding fails
      return null;
    }

    return null;
  }

  static String getInitials(String? name, {int maxChars = 2}) {
    if (name == null || name.trim().isEmpty) return '?';
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      final single = parts.first;
      return single
          .substring(0, single.length.clamp(1, maxChars))
          .toUpperCase();
    }
    final first = parts.first.characters.firstOrNull ?? '';
    final last = parts.last.characters.firstOrNull ?? '';
    return '$first$last'.toUpperCase();
  }
}
