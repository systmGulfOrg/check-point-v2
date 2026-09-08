import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class SupervisorNotificationCardWidget extends StatelessWidget {
  const SupervisorNotificationCardWidget({
    required this.typeKey,
    required this.titleKey,
    required this.messageKey,
    required this.isWarning,
    super.key,
  });

  final String typeKey;
  final String titleKey;
  final String messageKey;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    final color = isWarning ? AppColors.warningOrange : AppColors.info;
    final background = isWarning
        ? AppColors.softYellowBackground
        : AppColors.softBlueBackground;
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              typeKey.tr(context: context),
              style: AppTextStyles.font11Medium.copyWith(color: color),
            ),
          ),
          vSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleKey.tr(context: context),
                  style: AppTextStyles.font14SemiBold,
                ),
                hSpace(6),
                Text(
                  messageKey.tr(context: context),
                  style: AppTextStyles.font12Regular,
                ),
                hSpace(6),
                Text(
                  'supervisor.notifications.oneMinuteAgo'.tr(context: context),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 8.r,
            height: 8.r,
            margin: EdgeInsets.only(top: 3.h),
            decoration: const BoxDecoration(
              color: AppColors.brandPrimary,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
