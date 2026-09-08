import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';

class BiometricLoginButtonWidget extends StatelessWidget {
  const BiometricLoginButtonWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 48.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        side: const BorderSide(color: AppColors.brandPrimary),
      ),
      onPressed: onPressed,
      icon: Icon(
        Icons.fingerprint_rounded,
        color: AppColors.brandPrimary,
        size: 22.r,
      ),
      label: Text(
        'auth.login.loginWithBiometrics'.tr(context: context),
        style: AppTextStyles.font14Medium.copyWith(
          color: AppColors.brandPrimary,
        ),
      ),
    );
  }
}
