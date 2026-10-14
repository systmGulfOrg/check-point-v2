import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AppImageViewerDialog extends StatelessWidget {
  const AppImageViewerDialog({required this.imageUrl, this.title, super.key});

  final String imageUrl;
  final String? title;

  static void show(
    BuildContext context, {
    required String imageUrl,
    String? title,
  }) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => AppImageViewerDialog(imageUrl: imageUrl, title: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      imageWidget = Image.network(
        imageUrl,
        fit: BoxFit.contain,
        cacheWidth: 1600,
        cacheHeight: 1600,
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.broken_image_outlined,
          size: 64,
          color: Colors.white70,
        ),
      );
    } else if (imageUrl.startsWith('/') || imageUrl.contains(':')) {
      imageWidget = Image.file(
        File(imageUrl),
        fit: BoxFit.contain,
        cacheWidth: 1600,
        cacheHeight: 1600,
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.broken_image_outlined,
          size: 64,
          color: Colors.white70,
        ),
      );
    } else {
      imageWidget = const Icon(
        Icons.person_rounded,
        size: 100,
        color: Colors.white70,
      );
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                const SizedBox.shrink(),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          InteractiveViewer(
            clipBehavior: Clip.none,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: imageWidget,
            ),
          ),
        ],
      ),
    );
  }
}
