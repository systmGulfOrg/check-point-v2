import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'employee_attendance_record_data.dart';
import 'employee_status_badge_widget.dart';

class EmployeeAttendanceRecordCardWidget extends StatelessWidget {
  const EmployeeAttendanceRecordCardWidget({required this.record, super.key});

  final EmployeeAttendanceRecordData record;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.date, style: AppTextStyles.font14SemiBold),
                hSpace(4),
                Text(record.checkIn, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
          wSpace(12),
          EmployeeStatusBadgeWidget(status: record.status),
        ],
      ),
    );
  }
}
