import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class ProfilePointsBadgeWidget extends StatelessWidget {
  const ProfilePointsBadgeWidget({
    required this.tier,
    required this.points,
    super.key,
  });

  final String tier;
  final int points;

  @override
  Widget build(BuildContext context) {
    final colors = switch (tier.toLowerCase()) {
      'gold' => (
        background: AppColors.amberSoftBg,
        border: AppColors.amberBorder,
        foreground: AppColors.amberDark,
      ),
      'platinum' => (
        background: AppColors.softPurpleBackground,
        border: AppColors.softPurpleBackground,
        foreground: AppColors.purpleText,
      ),
      'silver' => (
        background: AppColors.softBlueBackground,
        border: AppColors.border,
        foreground: AppColors.brandInk,
      ),
      _ => (
        background: AppColors.softOrangeLightBackground,
        border: AppColors.orangeBorder,
        foreground: AppColors.amberDark,
      ),
    };

    return Container(
      padding: EdgeInsetsDirectional.only(
        start: 7.w,
        end: 10.w,
        top: 5.h,
        bottom: 5.h,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.8),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24.r,
            height: 24.r,
            decoration: BoxDecoration(
              color: colors.foreground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.workspace_premium_rounded,
              color: AppColors.white,
              size: 15.r,
            ),
          ),
          wSpace(5),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tier.toUpperCase(),
                style: AppTextStyles.font10Bold.copyWith(
                  color: colors.foreground,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                '$points pts',
                style: AppTextStyles.font10Medium.copyWith(
                  color: colors.foreground.withValues(alpha: 0.75),
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
