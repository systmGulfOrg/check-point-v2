import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee_record/data/models/employee_record_model.dart';

/// Times, minutes, leave type, holiday name and permits of one record day.
class EmployeeRecordDayDetailsWidget extends StatelessWidget {
  const EmployeeRecordDayDetailsWidget({required this.day, super.key});

  final RecordDayModel day;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();
    final time = DateFormat.jm(locale);
    final lines = <String>[
      if (day.clockIn != null)
        'record.details.inOut'.tr(
          context: context,
          namedArgs: {
            'in': time.format(day.clockIn!.toLocal()),
            'out': day.clockOut == null ? '--' : time.format(day.clockOut!.toLocal()),
          },
        ),
      if (day.lateMinutes > 0)
        'record.details.lateMinutes'.tr(
          context: context,
          namedArgs: {'minutes': NumberFormat.decimalPattern(locale).format(day.lateMinutes)},
        ),
      if (day.earlyLeaveMinutes > 0)
        'record.details.earlyMinutes'.tr(
          context: context,
          namedArgs: {'minutes': NumberFormat.decimalPattern(locale).format(day.earlyLeaveMinutes)},
        ),
      if (day.leave != null) day.leave!.typeName,
      if (day.holidayName != null) day.holidayName!,
      for (final permit in day.permits)
        'record.details.permit'.tr(
          context: context,
          namedArgs: {
            'type': 'record.permitType.${permit.permitType}'.tr(context: context),
            'status': 'record.permitStatus.${permit.status}'.tr(context: context),
            'from': permit.startTime,
            'to': permit.endTime,
          },
        ),
    ];
    if (lines.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final line in lines)
            Text(line, style: AppTextStyles.font12Regular.copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
