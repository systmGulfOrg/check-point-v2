import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class AppMessageWidget extends StatelessWidget {
  const AppMessageWidget({
    required this.messageKey,
    this.titleKey,
    this.icon = Icons.info_outline_rounded,
    this.iconColor,
    this.iconBackgroundColor,
    this.padding,
    super.key,
  });

  final String messageKey;
  final String? titleKey;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final resolvedIconColor = iconColor ?? AppColors.brandPrimary;

    return Padding(
      padding:
          padding ?? EdgeInsetsDirectional.fromSTEB(24.w, 32.h, 24.w, 32.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 68.r,
              height: 68.r,
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? AppColors.softBrandBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: resolvedIconColor, size: 34.r),
            ),
            if (titleKey != null) ...[
              hSpace(16),
              Text(
                titleKey!.tr(context: context),
                textAlign: TextAlign.center,
                style: AppTextStyles.font16Bold,
              ),
            ],
            SizedBox(height: titleKey == null ? 16.h : 8.h),
            Text(
              messageKey.tr(context: context),
              textAlign: TextAlign.center,
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
