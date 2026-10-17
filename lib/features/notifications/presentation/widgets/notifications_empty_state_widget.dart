import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class NotificationsEmptyStateWidget extends StatelessWidget {
  const NotificationsEmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                color: AppColors.softBrandBackground,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.notifications_off_outlined,
                color: AppColors.brandPrimary,
                size: 32.r,
              ),
            ),
            hSpace(16),
            Text(
              'common.noData'.tr(context: context),
              style: AppTextStyles.font16Bold.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
