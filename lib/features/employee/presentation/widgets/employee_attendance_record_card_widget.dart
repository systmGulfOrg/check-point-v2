import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'employee_attendance_date_block_widget.dart';
import 'employee_attendance_record_data.dart';

/// One day of attendance history: date block, in and out times, place, and
/// whether the day was on time, late or left early.
class EmployeeAttendanceRecordCardWidget extends StatelessWidget {
  const EmployeeAttendanceRecordCardWidget({required this.record, super.key});

  final EmployeeAttendanceRecordData record;

  @override
  Widget build(BuildContext context) {
    final (statusKey, color, background) = record.isLate
        ? (
            'employee.attendance.statusLate',
            AppColors.amberDark,
            AppColors.softYellowBackground,
          )
        : record.isEarly
        ? (
            'employee.attendance.statusEarly',
            AppColors.info,
            AppColors.softBlueBackground,
          )
        : (
            'employee.attendance.statusOnTime',
            AppColors.success,
            AppColors.softGreenBackground,
          );
    final checkOut = record.checkOut ?? '--:--';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          EmployeeAttendanceDateBlockWidget(
            day: record.day,
            fallback: record.date,
          ),
          wSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${'employee.attendance.in'.tr(context: context)} ${record.checkIn}  ·  ${'employee.attendance.out'.tr(context: context)} $checkOut',
                  style: AppTextStyles.font13SemiBold,
                ),
                if (record.area != null &&
                    record.area!.isNotEmpty &&
                    record.area != '-')
                  Text(
                    record.area!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          AppStatusPillWidget(
            label: statusKey.tr(context: context),
            color: color,
            backgroundColor: background,
          ),
        ],
      ),
    );
  }
}
