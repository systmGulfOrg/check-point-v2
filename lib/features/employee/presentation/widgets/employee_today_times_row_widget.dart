import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'employee_today_time_cell_widget.dart';

/// Check-in, check-out and worked hours side by side.
class EmployeeTodayTimesRowWidget extends StatelessWidget {
  const EmployeeTodayTimesRowWidget({
    required this.checkInTime,
    required this.checkOutTime,
    required this.workedHours,
    super.key,
  });

  final String checkInTime;
  final String checkOutTime;
  final String? workedHours;

  @override
  Widget build(BuildContext context) {
    final divider = Container(width: 1, height: 32.h, color: AppColors.border);
    return Row(
      children: [
        EmployeeTodayTimeCellWidget(
          label: 'employee.home.checkInLabel'.tr(context: context),
          value: checkInTime,
        ),
        divider,
        EmployeeTodayTimeCellWidget(
          label: 'employee.home.checkOutLabel'.tr(context: context),
          value: checkOutTime,
        ),
        divider,
        EmployeeTodayTimeCellWidget(
          label: 'employee.home.workedHours'.tr(context: context),
          value: workedHours ?? '--:--',
        ),
      ],
    );
  }
}
