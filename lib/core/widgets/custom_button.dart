import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

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
    this.padding,
    this.textStyle,
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
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
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
          padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w),
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
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
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
                      wSpace(6),
                    ],
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle ??
                              AppTextStyles.font16Bold.copyWith(
                                color: textColor,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
