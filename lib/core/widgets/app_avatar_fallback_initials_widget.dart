import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';

class AppAvatarFallbackInitialsWidget extends StatelessWidget {
  const AppAvatarFallbackInitialsWidget({required this.initials, super.key});

  final String initials;

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      width: 180.r,
      height: 180.r,
      decoration: const BoxDecoration(
        color: AppColors.softBrandBackground,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: AppTextStyles.font24Bold.copyWith(
          color: AppColors.brandPrimary,
          fontSize: 54.sp,
        ),
      ),
    ),
  );
}
