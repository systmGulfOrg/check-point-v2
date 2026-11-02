import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

/// Day number over a short weekday, e.g. "1 / الأحد".
class EmployeeAttendanceDateBlockWidget extends StatelessWidget {
  const EmployeeAttendanceDateBlockWidget({
    required this.day,
    required this.fallback,
    super.key,
  });

  final DateTime? day;
  final String fallback;

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    return Container(
      width: 52.r,
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.softBrandBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            day == null ? '--' : '${day!.day}',
            style: AppTextStyles.font16Bold.copyWith(
              color: AppColors.brandPrimaryDark,
            ),
          ),
          Text(
            day == null
                ? fallback
                : DateFormat('EEE', languageCode).format(day!),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font11Medium.copyWith(
              color: AppColors.brandPrimaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
