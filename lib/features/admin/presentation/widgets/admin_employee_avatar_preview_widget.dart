import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminEmployeeAvatarPreviewWidget extends StatelessWidget {
  const AdminEmployeeAvatarPreviewWidget({
    required this.photoPath,
    this.fallbackBackgroundColor = AppColors.pageBackground,
    this.fallbackIconSize,
    super.key,
  });

  final String? photoPath;
  final Color fallbackBackgroundColor;
  final double? fallbackIconSize;

  @override
  Widget build(BuildContext context) {
    final path = photoPath;
    if (path != null) {
      if (path.startsWith('data:image') || path.length > 300) {
        try {
          final clean = path.contains(',') ? path.split(',').last : path;
          final bytes = base64Decode(clean);
          return Image.memory(bytes, fit: BoxFit.cover);
        } catch (_) {}
      }
      final file = File(path);
      if (file.existsSync()) {
        return Image.file(file, fit: BoxFit.cover);
      }
      if (path.startsWith('http')) {
        return Image(
          image: CachedNetworkImageProvider(path),
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const Icon(Icons.broken_image_outlined),
        );
      }
    }
    return Container(
      color: fallbackBackgroundColor,
      child: Icon(
        Icons.person_rounded,
        size: fallbackIconSize ?? 46.r,
        color: AppColors.placeholder,
      ),
    );
  }
}
