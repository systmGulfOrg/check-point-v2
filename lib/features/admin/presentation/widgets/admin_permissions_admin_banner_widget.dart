import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminPermissionsAdminBannerWidget extends StatelessWidget {
  const AdminPermissionsAdminBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.softBrandBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.brandPrimary.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: AppColors.brandPrimary,
            size: 42.r,
          ),
          hSpace(10),
          Text(
            'admin.permissions.adminAccess'.tr(context: context),
            style: AppTextStyles.font16Bold,
          ),
          hSpace(4),
          Text(
            'admin.permissions.adminDescription'.tr(context: context),
            textAlign: TextAlign.center,
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
