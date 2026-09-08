import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'employee_attendance_record_data.dart';
import 'employee_status_badge_widget.dart';

class EmployeeAttendanceRecordCardWidget extends StatelessWidget {
  const EmployeeAttendanceRecordCardWidget({required this.record, super.key});

  final EmployeeAttendanceRecordData record;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 16.r,
                    color: AppColors.textSecondary,
                  ),
                  wSpace(6),
                  Text(
                    record.date,
                    style: AppTextStyles.font14SemiBold.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              EmployeeStatusBadgeWidget(status: record.status),
            ],
          ),
          hSpace(8),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.login_rounded,
                      size: 16.r,
                      color: AppColors.success,
                    ),
                    wSpace(4),
                    Text(
                      'In ${record.checkIn}',
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      size: 16.r,
                      color: record.checkOut != null && record.checkOut != '--:--'
                          ? AppColors.brandPrimary
                          : AppColors.placeholder,
                    ),
                    wSpace(4),
                    Text(
                      'Out ${record.checkOut ?? '--:--'}',
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: record.checkOut != null && record.checkOut != '--:--'
                            ? AppColors.textPrimary
                            : AppColors.placeholder,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (record.area != null && record.area!.isNotEmpty && record.area != '-') ...[
            hSpace(6),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14.r,
                  color: AppColors.placeholder,
                ),
                wSpace(4),
                Text(
                  record.area!,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
