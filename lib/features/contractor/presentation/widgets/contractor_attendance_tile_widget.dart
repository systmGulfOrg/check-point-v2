import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_attendance_model.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class ContractorAttendanceTileWidget extends StatelessWidget {
  const ContractorAttendanceTileWidget({
    super.key,
    required this.attendance,
  });

  final ContractorAttendanceModel attendance;

  Color get statusColor {
    switch (attendance.status.toLowerCase()) {
      case 'present':
        return AppColors.success;
      case 'late':
        return AppColors.warning;
      case 'absent':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              attendance.isInsideGeofence
                  ? Icons.check_circle_outline_rounded
                  : Icons.warning_amber_rounded,
              color: statusColor,
              size: 20.r,
            ),
          ),
          wSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attendance.workerName,
                  style: AppTextStyles.font14Bold,
                ),
                hSpace(2),
                Text(
                  '${attendance.siteName} • ${attendance.jobTitle}',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                attendance.checkInTime ?? '--:--',
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              hSpace(2),
              Text(
                attendance.status,
                style: AppTextStyles.font11Medium.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
