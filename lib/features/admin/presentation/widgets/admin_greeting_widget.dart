import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminGreetingWidget extends StatelessWidget {
  const AdminGreetingWidget({
    required this.userNameKey,
    required this.dateText,
    this.greetingKey = 'admin.dashboard.greeting',
    super.key,
  });

  final String userNameKey;
  final String dateText;
  final String greetingKey;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          userNameKey.tr(context: context),
          style: AppTextStyles.font24Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        hSpace(6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.softBrandBackground,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            dateText,
            style: AppTextStyles.font12Bold.copyWith(
              color: AppColors.brandPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
