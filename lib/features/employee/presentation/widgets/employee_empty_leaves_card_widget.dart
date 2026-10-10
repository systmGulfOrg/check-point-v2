import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeEmptyLeavesCardWidget extends StatelessWidget {
  const EmployeeEmptyLeavesCardWidget({
    required this.onRequestLeave,
    super.key,
  });

  final VoidCallback onRequestLeave;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: const BoxDecoration(
              color: AppColors.softBrandBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.beach_access_outlined,
              color: AppColors.brandPrimary,
              size: 28.r,
            ),
          ),
          hSpace(12),
          Text(
            'employee.home.noRecentLeaves'.tr(context: context),
            style: AppTextStyles.font14Medium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          hSpace(14),
          OutlinedButton.icon(
            onPressed: onRequestLeave,
            icon: Icon(Icons.add, size: 16.r),
            label: Text('employee.home.applyNow'.tr(context: context)),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.brandPrimary,
              side: const BorderSide(color: AppColors.brandPrimary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            ),
          ),
        ],
      ),
    );
  }
}
