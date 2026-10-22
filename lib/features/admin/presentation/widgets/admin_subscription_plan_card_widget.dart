import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminSubscriptionPlanCardWidget extends StatelessWidget {
  const AdminSubscriptionPlanCardWidget({
    required this.isTrial,
    super.key,
    this.companyName,
    this.planName,
    this.trialEndsAt,
    this.seatLimit,
    this.usedSeats = 0,
  });

  final String? companyName;
  final String? planName;
  final bool isTrial;
  final DateTime? trialEndsAt;
  final int? seatLimit;
  final int usedSeats;

  @override
  Widget build(BuildContext context) {
    final usedPct = seatLimit != null && seatLimit! > 0
        ? (usedSeats / seatLimit!).clamp(0.0, 1.0)
        : 0.0;

    final today = DateTime.now();
    final daysLeft = trialEndsAt != null
        ? DateTime(
            trialEndsAt!.year,
            trialEndsAt!.month,
            trialEndsAt!.day,
          ).difference(DateTime(today.year, today.month, today.day)).inDays
        : null;

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  companyName ?? '',
                  style: AppTextStyles.font16Bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 10.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: isTrial
                      ? AppColors.softBrandBackground
                      : AppColors.softGreenBackground,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  isTrial
                      ? 'admin.subscription.planTrial'.tr(context: context)
                      : (planName ??
                            'admin.subscription.planActive'.tr(
                              context: context,
                            )),
                  style: AppTextStyles.font12Medium.copyWith(
                    color: isTrial ? AppColors.brandPrimary : AppColors.success,
                  ),
                ),
              ),
            ],
          ),
          if (isTrial && daysLeft != null) ...[
            hSpace(8),
            Text(
              daysLeft <= 0
                  ? 'admin.dashboard.trialBanner.expiresToday'.tr(
                      context: context,
                    )
                  : 'admin.dashboard.trialBanner.daysLeft'.tr(
                      context: context,
                      args: ['$daysLeft'],
                    ),
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.placeholder,
              ),
            ),
          ],
          hSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'admin.subscription.usersLabel'.tr(context: context),
                style: AppTextStyles.font13SemiBold,
              ),
              Text(
                seatLimit != null ? '$usedSeats / $seatLimit' : '$usedSeats',
                style: AppTextStyles.font13Bold,
              ),
            ],
          ),
          hSpace(8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999.r),
            child: LinearProgressIndicator(
              value: seatLimit != null ? usedPct : 0,
              minHeight: 8.h,
              backgroundColor: AppColors.border,
              color: usedPct >= 0.9 ? AppColors.error : AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}
