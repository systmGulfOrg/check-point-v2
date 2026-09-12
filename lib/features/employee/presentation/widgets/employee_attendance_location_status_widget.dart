import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeAttendanceLocationStatusWidget extends StatelessWidget {
  const EmployeeAttendanceLocationStatusWidget({
    required Object? userLocation,
    required this.isInside,
    super.key,
  }) : hasUserLocation = userLocation != null;

  final bool hasUserLocation;
  final bool isInside;

  @override
  Widget build(BuildContext context) {
    final color = !hasUserLocation
        ? AppColors.textSecondary
        : isInside
        ? AppColors.success
        : AppColors.error;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: !hasUserLocation
            ? AppColors.pageBackground
            : isInside
            ? AppColors.softGreenBackground
            : AppColors.softRedBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: !hasUserLocation
              ? AppColors.border
              : isInside
              ? AppColors.success.withValues(alpha: .35)
              : AppColors.error.withValues(alpha: .35),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            !hasUserLocation
                ? Icons.gps_fixed_rounded
                : isInside
                ? Icons.check_circle_rounded
                : Icons.location_off_rounded,
            color: color,
            size: 22.r,
          ),
          wSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  !hasUserLocation
                      ? 'attendance.locationLoading'.tr()
                      : isInside
                      ? 'attendance.insideArea'.tr()
                      : 'attendance.outsideArea'.tr(),
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: !hasUserLocation ? AppColors.textPrimary : color,
                  ),
                ),
                hSpace(4),
                Text(
                  isInside
                      ? 'attendance.readyNote'.tr()
                      : 'attendance.moveToLocationNote'.tr(),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
