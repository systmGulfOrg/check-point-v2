import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class StartTrialBannerWidget extends StatelessWidget {
  const StartTrialBannerWidget({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.softBrandBackground,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.brandPrimary.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'auth.companyCode.startTrial'.tr(context: context),
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: AppColors.brandInk,
                    ),
                  ),
                  hSpace(2),
                  Text(
                    'auth.trialSignup.trialBadge'.tr(context: context),
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.placeholder,
                    ),
                  ),
                ],
              ),
            ),
            wSpace(10),
            Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: AppColors.brandPrimary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.rocket_launch_rounded,
                size: 18.r,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
