import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

/// Shown in place of the attendance button on a holiday or weekly day off.
class EmployeeTodayDayOffBannerWidget extends StatelessWidget {
  const EmployeeTodayDayOffBannerWidget({
    required this.message,
    required this.icon,
    required this.color,
    required this.backgroundColor,
    super.key,
  });

  final String message;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22.r),
          wSpace(8),
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.font13SemiBold.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
