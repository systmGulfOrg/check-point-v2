import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'employee_stat_card_widget.dart';

class EmployeeStatsRowWidget extends StatelessWidget {
  const EmployeeStatsRowWidget({
    required this.activeTasksCount,
    required this.upcomingPlansCount,
    required this.pendingLeavesCount,
    super.key,
  });

  final int activeTasksCount;
  final int upcomingPlansCount;
  final int pendingLeavesCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: EmployeeStatCardWidget(
            icon: Icons.assignment_outlined,
            iconBgColor: AppColors.softBlueBackground,
            iconColor: AppColors.info,
            count: activeTasksCount,
            label: 'employee.home.activeTasks'.tr(context: context),
          ),
        ),
        wSpace(10),
        Expanded(
          child: EmployeeStatCardWidget(
            icon: Icons.map_outlined,
            iconBgColor: AppColors.softBrandBackground,
            iconColor: AppColors.brandPrimary,
            count: upcomingPlansCount,
            label: 'employee.home.upcomingPlans'.tr(context: context),
          ),
        ),
        wSpace(10),
        Expanded(
          child: EmployeeStatCardWidget(
            icon: Icons.calendar_today_outlined,
            iconBgColor: AppColors.softYellowBackground,
            iconColor: AppColors.warningOrange,
            count: pendingLeavesCount,
            label: 'employee.home.pendingLeaves'.tr(context: context),
          ),
        ),
      ],
    );
  }
}
