import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'app_document_generic_file_card_widget.dart';

class AppDocumentPreviewWidget extends StatelessWidget {
  const AppDocumentPreviewWidget({
    super.key,
    required this.fileUrl,
    required this.isImage,
    required this.fileName,
    required this.extension,
    required this.formattedSize,
    required this.icon,
    required this.iconColor,
  });

  final String? fileUrl;
  final bool isImage;
  final String fileName;
  final String extension;
  final String formattedSize;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final fallback = AppDocumentGenericFileCardWidget(
      fileName: fileName,
      extension: extension,
      formattedSize: formattedSize,
      icon: icon,
      iconColor: iconColor,
    );

    if (fileUrl == null || fileUrl!.isEmpty) {
      return fallback;
    }

    final rawUrl = fileUrl!.trim();
    final trimmed = rawUrl.startsWith('/api/')
        ? '${AppConfig.baseUrl.replaceFirst(RegExp(r'/+$'), '')}$rawUrl'
        : rawUrl;

    if (isImage &&
        (trimmed.startsWith('/') || trimmed.startsWith('file://'))) {
      try {
        final path = trimmed.replaceFirst('file://', '');
        final file = File(path);
        if (file.existsSync()) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              constraints: BoxConstraints(maxHeight: 260.h),
              width: double.infinity,
              color: AppColors.pageBackground,
              child: InteractiveViewer(
                maxScale: 4.0,
                child: Image.file(
                  file,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => fallback,
                ),
              ),
            ),
          );
        }
      } catch (_) {}
    }

    if (isImage &&
        (trimmed.startsWith('data:image/') || !trimmed.startsWith('http'))) {
      try {
        final cleanBase64 = trimmed.contains(',')
            ? trimmed.split(',').last
            : trimmed;
        final bytes = base64Decode(cleanBase64.trim());
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            constraints: BoxConstraints(maxHeight: 260.h),
            width: double.infinity,
            color: AppColors.pageBackground,
            child: InteractiveViewer(
              maxScale: 4.0,
              child: Image.memory(
                Uint8List.fromList(bytes),
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => fallback,
              ),
            ),
          ),
        );
      } catch (_) {}
    }

    if (isImage &&
        (trimmed.startsWith('http://') || trimmed.startsWith('https://'))) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          constraints: BoxConstraints(maxHeight: 260.h),
          width: double.infinity,
          color: AppColors.pageBackground,
          child: InteractiveViewer(
            maxScale: 4.0,
            child: Image.network(
              trimmed,
              fit: BoxFit.contain,
              loadingBuilder: (_, child, progress) {
                if (progress == null) return child;
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.r),
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                );
              },
              errorBuilder: (_, _, _) => fallback,
            ),
          ),
        ),
      );
    }

    return fallback;
  }
}
