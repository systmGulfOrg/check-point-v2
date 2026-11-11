import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee_record/data/models/employee_record_model.dart';
import 'employee_record_total_chip_widget.dart';

/// Month totals: present, late, covered by permit, absent, leave, holidays, days off.
class EmployeeRecordTotalsWidget extends StatelessWidget {
  const EmployeeRecordTotalsWidget({required this.totals, super.key});

  final RecordTotalsModel totals;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsetsDirectional.only(bottom: 12.h),
    child: Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        EmployeeRecordTotalChipWidget(labelKey: 'record.totals.present', value: totals.presentDays, color: AppColors.success),
        EmployeeRecordTotalChipWidget(labelKey: 'record.totals.late', value: totals.lateDays, color: AppColors.error),
        EmployeeRecordTotalChipWidget(labelKey: 'record.totals.covered', value: totals.coveredDays, color: AppColors.success),
        EmployeeRecordTotalChipWidget(labelKey: 'record.totals.absent', value: totals.absentDays, color: AppColors.error),
        EmployeeRecordTotalChipWidget(labelKey: 'record.totals.leave', value: totals.leaveDays, color: AppColors.info),
        EmployeeRecordTotalChipWidget(labelKey: 'record.totals.holiday', value: totals.holidayDays, color: AppColors.purpleText),
        EmployeeRecordTotalChipWidget(labelKey: 'record.totals.weeklyOff', value: totals.weeklyOffDays, color: AppColors.textSecondary),
        EmployeeRecordTotalChipWidget(labelKey: 'record.totals.permits', value: totals.permits, color: AppColors.brandInk),
      ],
    ),
  );
}
