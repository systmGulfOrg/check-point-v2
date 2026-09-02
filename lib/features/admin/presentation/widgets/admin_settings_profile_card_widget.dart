import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminSettingsProfileCardWidget extends StatelessWidget {
  const AdminSettingsProfileCardWidget({super.key});

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
          CircleAvatar(
            radius: 32.r,
            backgroundColor: AppColors.softBrandBackground,
            child: Text(
              'SA',
              style: AppTextStyles.font18Bold.copyWith(
                color: AppColors.brandPrimary,
              ),
            ),
          ),
          hSpace(12),
          Text(
            'admin.settings.userName'.tr(context: context),
            style: AppTextStyles.font18Bold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          hSpace(4),
          Text(
            'admin.settings.userEmail'.tr(context: context),
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          hSpace(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.softBrandBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'admin.settings.badgeRole'.tr(context: context),
                  style: AppTextStyles.font12Bold.copyWith(
                    color: AppColors.brandPrimary,
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
                  'admin.settings.badgeEmpId'.tr(context: context),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
