import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class NotificationsErrorWidget extends StatelessWidget {
  const NotificationsErrorWidget({
    required this.messageKey,
    required this.onRetry,
    super.key,
  });

  final String messageKey;
  final VoidCallback onRetry;

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
                color: AppColors.softRedBackground,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: AppColors.error,
                size: 32.r,
              ),
            ),
            hSpace(16),
            Text(
              messageKey.tr(context: context),
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            hSpace(20),
            SizedBox(
              width: 140.w,
              child: CustomButton(
                text: 'common.retry'.tr(context: context),
                onTap: onRetry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
