import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee_record/data/models/employee_record_args.dart';

/// Opens the full day-by-day record of an employee. The server decides
/// whether the viewer may see it (own / team / all).
class EmployeeRecordButtonWidget extends StatelessWidget {
  const EmployeeRecordButtonWidget({
    this.employeeId = 'me',
    this.employeeName,
    super.key,
  });

  final String employeeId;
  final String? employeeName;

  @override
  Widget build(BuildContext context) => CustomButton(
    text: 'record.open'.tr(context: context),
    icon: Icons.event_note_rounded,
    backgroundColor: AppColors.softBrandBackground,
    textColor: AppColors.brandPrimaryDark,
    onTap: () => Navigator.pushNamed(
      context,
      AppRoutes.employeeRecord,
      arguments: EmployeeRecordArgs(employeeId: employeeId, employeeName: employeeName),
    ),
  );
}
