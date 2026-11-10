import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AppDocumentGenericFileCardWidget extends StatelessWidget {
  const AppDocumentGenericFileCardWidget({
    super.key,
    required this.fileName,
    required this.extension,
    required this.formattedSize,
    required this.icon,
    required this.iconColor,
  });

  final String fileName;
  final String extension;
  final String formattedSize;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 44.r, color: iconColor),
          ),
          hSpace(12),
          Text(
            fileName,
            style: AppTextStyles.font14Bold,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          hSpace(4),
          Text(
            '${extension.toUpperCase()} • $formattedSize',
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
