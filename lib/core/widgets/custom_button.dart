import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.onTap,
    super.key,
    this.isLoading = false,
    this.enabled = true,
    this.backgroundColor = AppColors.brandPrimary,
    this.textColor = AppColors.white,
    this.height = 48,
    this.gradient,
    this.icon,
  });

  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final bool enabled;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final Gradient? gradient;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final isInteractive = enabled && !isLoading;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: isInteractive ? onTap : null,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          height: height.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: gradient == null && enabled
                ? backgroundColor
                : gradient == null
                ? backgroundColor.withValues(alpha: 0.5)
                : null,
            gradient: enabled ? gradient : null,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: isLoading
              ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.white,
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: textColor, size: 18.r),
                      SizedBox(width: 6.w),
                    ],
                    Text(
                      text,
                      style: AppTextStyles.font16Bold.copyWith(
                        color: textColor,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
