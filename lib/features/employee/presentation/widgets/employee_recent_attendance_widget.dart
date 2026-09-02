import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'employee_attendance_record_card_widget.dart';
import 'employee_attendance_record_data.dart';

class EmployeeRecentAttendanceWidget extends StatelessWidget {
  const EmployeeRecentAttendanceWidget({
    required this.records,
    super.key,
  });

  final List<EmployeeAttendanceRecordData> records;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'employee.clock.recentAttendance'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
        hSpace(12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              for (int i = 0; i < records.length; i++) ...[
                EmployeeAttendanceRecordCardWidget(record: records[i]),
                if (i < records.length - 1)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.border,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
