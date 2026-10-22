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
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 10.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.infoBackground,
          borderRadius: BorderRadius.circular(7.r),
          border: Border.all(
            color: AppColors.brandPrimary.withValues(alpha: 0.25),
            width: 1.3.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              textDirection: Directionality.of(context),
              children: [
                Container(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 8.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.brandPrimary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'auth.companyCode.trialFreeBadge'.tr(context: context),
                    style: AppTextStyles.font11Bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                wSpace(6),
                Expanded(
                  child: Text(
                    'auth.companyCode.startTrial'.tr(context: context),
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: AppColors.brandInk,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            hSpace(2),
            Text(
              'auth.trialSignup.trialBadge'.tr(context: context),
              style: AppTextStyles.font11Regular.copyWith(
                color: AppColors.placeholder,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
