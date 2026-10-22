import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminGreetingWidget extends StatelessWidget {
  const AdminGreetingWidget({
    required this.userNameKey,
    required this.dateText,
    this.greetingKey = 'admin.dashboard.greeting',
    this.userName,
    super.key,
  });

  final String userNameKey;
  final String dateText;
  final String greetingKey;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greetingKey.tr(context: context),
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(4),
              Text(
                userName ?? userNameKey.tr(context: context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font24Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        wSpace(12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.softBrandBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.brandPrimary.withValues(alpha: 0.25),
            ),
          ),
          child: Text(
            dateText,
            style: AppTextStyles.font13Bold.copyWith(
              color: AppColors.brandPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
