import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminRescheduleHolidayTabButtonWidget extends StatelessWidget {
  const AdminRescheduleHolidayTabButtonWidget({
    required this.isSelected,
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final bool isSelected;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 15.r,
              color: isSelected
                  ? AppColors.brandPrimary
                  : AppColors.placeholder,
            ),
            SizedBox(width: 4.w),
            Text(
              title,
              style: AppTextStyles.font10Bold.copyWith(
                color: isSelected
                    ? AppColors.brandPrimary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
