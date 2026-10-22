import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

/// Shown whenever data fails to load, instead of silently falling back to
/// default/zero values. Always offers a retry affordance.
class AppErrorStateWidget extends StatelessWidget {
  const AppErrorStateWidget({
    required this.messageKey,
    required this.onRetry,
    this.titleKey,
    this.padding,
    super.key,
  });

  final String messageKey;
  final VoidCallback onRetry;
  final String? titleKey;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
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
                color: AppColors.softRedBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                color: AppColors.error,
                size: 34.r,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              (titleKey ?? 'core.errors.somethingWentWrong').tr(
                context: context,
              ),
              textAlign: TextAlign.center,
              style: AppTextStyles.font16Bold,
            ),
            SizedBox(height: 8.h),
            Text(
              messageKey.tr(context: context),
              textAlign: TextAlign.center,
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
              ),
            ),
            SizedBox(height: 16.h),
            OutlinedButton.icon(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.brandPrimary,
                side: const BorderSide(color: AppColors.brandPrimary),
              ),
              icon: Icon(Icons.refresh_rounded, size: 18.r),
              label: Text('core.actions.tryAgain'.tr(context: context)),
            ),
          ],
        ),
      ),
    );
  }
}
