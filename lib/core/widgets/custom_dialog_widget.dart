import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'custom_button.dart';

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget({
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmLabel,
    this.cancelLabel,
    this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.confirmButtonColor,
    this.confirmButtonTextColor,
    super.key,
  });

  final String title;
  final String message;
  final VoidCallback onConfirm;
  final String? confirmLabel;
  final String? cancelLabel;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? confirmButtonColor;
  final Color? confirmButtonTextColor;

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: AppColors.cardBackground,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
    child: Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Container(
              width: 56.r,
              height: 56.r,
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? AppColors.brandPrimary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.brandPrimary,
                size: 28.r,
              ),
            ),
            hSpace(16),
          ],
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.font18Bold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          hSpace(8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          hSpace(20),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: cancelLabel ?? 'auth.login.cancel'.tr(context: context),
                  onTap: () => Navigator.pop(context),
                  backgroundColor: AppColors.pageBackground,
                  textColor: AppColors.textPrimary,
                  height: 44,
                ),
              ),
              wSpace(12),
              Expanded(
                child: CustomButton(
                  text: confirmLabel ?? 'auth.login.confirmTransfer'.tr(context: context),
                  onTap: onConfirm,
                  backgroundColor: confirmButtonColor ?? AppColors.brandPrimary,
                  textColor: confirmButtonTextColor ?? AppColors.white,
                  height: 44,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
