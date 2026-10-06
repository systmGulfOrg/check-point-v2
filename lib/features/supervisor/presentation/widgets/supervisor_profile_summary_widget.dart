import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class SupervisorProfileSummaryWidget extends StatelessWidget {
  const SupervisorProfileSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          AppAvatarWidget(
            name: 'supervisor.profile.name'.tr(context: context),
            initials: 'SJ',
            subtitle: 'supervisor.profile.email'.tr(context: context),
            radius: 32.r,
            backgroundColor: AppColors.softBlueBackground,
            textColor: AppColors.info,
            enablePreview: true,
          ),
          hSpace(12),
          Text(
            'supervisor.profile.name'.tr(context: context),
            style: AppTextStyles.font18Bold,
          ),
          hSpace(4),
          Text(
            'supervisor.profile.email'.tr(context: context),
            style: AppTextStyles.font13Regular,
          ),
          hSpace(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.softBlueBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'auth.role.supervisor'.tr(context: context),
                  style: AppTextStyles.font12Bold.copyWith(
                    color: AppColors.info,
                  ),
                ),
              ),
              vSpace(8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  'supervisor.profile.employeeId'.tr(context: context),
                  style: AppTextStyles.font12Regular,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
