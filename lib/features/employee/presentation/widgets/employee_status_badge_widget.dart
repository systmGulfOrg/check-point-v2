import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeStatusBadgeWidget extends StatelessWidget {
  const EmployeeStatusBadgeWidget({required this.status, super.key});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor, dotColor) = switch (status) {
      'On Time' => (
        AppColors.softGreenBackground,
        AppColors.success,
        AppColors.success,
      ),
      'Overdue' => (const Color(0xFFFEE2E2), AppColors.error, AppColors.error),
      'In Progress' => (
        AppColors.softBlueBackground,
        AppColors.info,
        AppColors.info,
      ),
      _ => (
        AppColors.infoBackground,
        AppColors.textSecondary,
        AppColors.placeholder,
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.r,
            height: 6.r,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          wSpace(6),
          Text(
            status,
            style: AppTextStyles.font12Medium.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
