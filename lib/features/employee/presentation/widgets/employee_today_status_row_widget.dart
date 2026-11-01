import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

/// Today's attendance status on one side, today's work mode on the other.
class EmployeeTodayStatusRowWidget extends StatelessWidget {
  const EmployeeTodayStatusRowWidget({
    required this.isCheckedIn,
    required this.hasCheckedOut,
    required this.isOnTime,
    required this.workModeText,
    super.key,
  });

  final bool isCheckedIn;
  final bool hasCheckedOut;
  final bool isOnTime;
  final String workModeText;

  @override
  Widget build(BuildContext context) {
    final (key, color, background, icon) = switch ((
      isCheckedIn,
      hasCheckedOut,
    )) {
      (_, true) => (
        'employee.home.status.dayDone',
        AppColors.info,
        AppColors.softBlueBackground,
        Icons.check_circle_outline_rounded,
      ),
      (true, _) when !isOnTime => (
        'employee.home.status.checkedInLate',
        AppColors.amberDark,
        AppColors.softYellowBackground,
        Icons.schedule_rounded,
      ),
      (true, _) => (
        'employee.home.status.checkedIn',
        AppColors.success,
        AppColors.softGreenBackground,
        Icons.radio_button_checked_rounded,
      ),
      _ => (
        'employee.home.status.notCheckedIn',
        AppColors.error,
        AppColors.softRedBackground,
        Icons.radio_button_unchecked_rounded,
      ),
    };
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppStatusPillWidget(
          label: key.tr(context: context),
          color: color,
          backgroundColor: background,
          icon: icon,
        ),
        AppStatusPillWidget(
          label: workModeText,
          color: AppColors.info,
          backgroundColor: AppColors.softBlueBackground,
          icon: Icons.home_work_outlined,
        ),
      ],
    );
  }
}
