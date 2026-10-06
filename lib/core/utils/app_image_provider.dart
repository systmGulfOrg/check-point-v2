import 'dart:convert';

import 'package:flutter/material.dart';

class AppImageProvider {
  AppImageProvider._();

  static ImageProvider? resolve(String? source) {
    if (source == null) return null;
    final trimmed = source.trim();
    if (trimmed.isEmpty) return null;

    try {
      if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
        return NetworkImage(trimmed);
      }

      if (trimmed.startsWith('assets/')) {
        return AssetImage(trimmed);
      }

      if (trimmed.startsWith('data:image')) {
        final commaIndex = trimmed.indexOf(',');
        final rawBase64 = commaIndex != -1
            ? trimmed.substring(commaIndex + 1)
            : trimmed;
        final bytes = base64Decode(rawBase64.trim());
        return MemoryImage(bytes);
      }

      // Check if it's a raw base64 string
      if (_looksLikeBase64(trimmed)) {
        final bytes = base64Decode(trimmed);
        return MemoryImage(bytes);
      }
    } catch (_) {
      // Silently fallback to null if image parsing or decoding fails
      return null;
    }

    return null;
  }

  static bool _looksLikeBase64(String str) {
    if (str.length < 16) return false;
    // Base64 strings only contain A-Z, a-z, 0-9, +, /, and = (for padding)
    final regex = RegExp(r'^[A-Za-z0-9+/=]+$');
    return regex.hasMatch(str.replaceAll(RegExp(r'\s+'), ''));
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
