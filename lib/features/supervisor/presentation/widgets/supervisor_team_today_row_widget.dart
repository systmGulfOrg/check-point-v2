import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';

class SupervisorTeamTodayRowWidget extends StatelessWidget {
  const SupervisorTeamTodayRowWidget({required this.record, super.key});

  final AdminAttendanceModel record;

  @override
  Widget build(BuildContext context) {
    final name = record.employeeName ?? 'Employee';
    final initials = name.isNotEmpty
        ? name
              .split(' ')
              .take(2)
              .map((e) => e.isNotEmpty ? e[0].toUpperCase() : '')
              .join()
        : 'EM';
    final isLate = record.isLate ?? false;
    final statusKey = isLate
        ? 'supervisor.status.late'
        : 'supervisor.status.present';
    final statusColor = isLate ? AppColors.warningOrange : AppColors.success;
    final statusBgColor = isLate
        ? AppColors.softYellowBackground
        : AppColors.softGreenBackground;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.softBrandBackground,
            child: Text(
              initials,
              style: AppTextStyles.font14SemiBold.copyWith(
                color: AppColors.brandPrimary,
              ),
            ),
          ),
          wSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                hSpace(2),
                Text(
                  record.clockInTime != null
                      ? 'supervisor.attendance.clockIn'.tr(
                          context: context,
                          args: [
                            AppDateFormatter.formatTimeString(
                              record.clockInTime,
                            ),
                          ],
                        )
                      : (record.area ?? 'Active'),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6.r,
                  height: 6.r,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                wSpace(6),
                Text(
                  statusKey.tr(context: context),
                  style: AppTextStyles.font12Bold.copyWith(color: statusColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
