import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class PendingAttendanceReasonBadgeWidget extends StatelessWidget {
  const PendingAttendanceReasonBadgeWidget({
    super.key,
    required this.reason,
  });

  final String reason;

  @override
  Widget build(BuildContext context) {
    final label = switch (reason) {
      'CLOCK_DRIFT' => 'فارق زمني',
      'CLOCK_UNANCHORED' => 'بدون مرجع زمني',
      'MOCK_LOCATION' => 'موقع وهمي',
      'LOW_ACCURACY' => 'دقة موقع منخفضة',
      'OUTSIDE_GEOFENCE' => 'خارج النطاق',
      'DEVICE_UNVERIFIED' => 'جهاز غير موثق',
      _ => reason,
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFB45309), // amber-700
        ),
      ),
    );
  }
}
