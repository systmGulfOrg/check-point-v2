import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;
    final screenHeight = mediaQuery.size.height;
    
    // Position floating snackbar near top of screen
    final bottomMargin = screenHeight - topPadding - 110.h;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor ?? AppColors.white, size: 20.r),
              wSpace(10),
            ],
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.font14Medium.copyWith(
                  color: textColor ?? AppColors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor ?? AppColors.textPrimary,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(
          bottom: bottomMargin > 0 ? bottomMargin : 600.h,
          left: 16.w,
          right: 16.w,
        ),
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
    );
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: AppColors.success,
      icon: Icons.check_circle_outline_rounded,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: AppColors.error,
      icon: Icons.error_outline_rounded,
      duration: duration,
    );
  }
}

void showCustomSnackBar(
  BuildContext context, {
  required String message,
  Color? backgroundColor,
  Color? textColor,
  IconData? icon,
  Duration duration = const Duration(seconds: 3),
}) {
  CustomSnackBar.show(
    context,
    message: message,
    backgroundColor: backgroundColor,
    textColor: textColor,
    icon: icon,
    duration: duration,
  );
}
