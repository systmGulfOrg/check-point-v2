import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminTrialBannerWidget extends StatelessWidget {
  const AdminTrialBannerWidget({
    required this.trialEndsAt,
    this.seatLimit,
    this.onTap,
    super.key,
  });

  final DateTime trialEndsAt;
  final int? seatLimit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final daysLeft = DateTime(
      trialEndsAt.year,
      trialEndsAt.month,
      trialEndsAt.day,
    ).difference(DateTime(today.year, today.month, today.day)).inDays;

    final daysText = daysLeft <= 0
        ? 'admin.dashboard.trialBanner.expiresToday'.tr(context: context)
        : 'admin.dashboard.trialBanner.daysLeft'.tr(
            context: context,
            args: ['$daysLeft'],
          );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 14.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.softBrandBackground,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: AppColors.brandPrimary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.rocket_launch_rounded,
              size: 18.r,
              color: AppColors.brandPrimary,
            ),
            wSpace(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'admin.dashboard.trialBanner.title'.tr(context: context),
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: AppColors.brandInk,
                    ),
                  ),
                  Text(
                    seatLimit != null
                        ? '$daysText، ${'admin.dashboard.trialBanner.seatLimit'.tr(context: context, args: ['$seatLimit'])}'
                        : daysText,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.placeholder,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 18.r,
              color: AppColors.placeholder,
            ),
          ],
        ),
      ),
    );
  }
}
