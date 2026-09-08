import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminManageComingNextWidget extends StatelessWidget {
  const AdminManageComingNextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.softBrandBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'admin.manage.comingNextTitle'.tr(context: context),
            style: AppTextStyles.font12Bold.copyWith(
              color: AppColors.brandPrimary,
              letterSpacing: 0.5,
            ),
          ),
          hSpace(6),
          Text(
            'admin.manage.comingNextDesc'.tr(context: context),
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
