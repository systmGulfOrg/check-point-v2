import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'employee_home_points_stat_bloc_builder_widget.dart';
import 'employee_home_stat_card_widget.dart';

class EmployeeHomeStatsRowWidget extends StatelessWidget {
  const EmployeeHomeStatsRowWidget({required this.leaveBalance, super.key});

  final int? leaveBalance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: EmployeeHomeStatCardWidget(
            label: 'employee.home.stats.leaveBalance'.tr(context: context),
            value: '${leaveBalance ?? '--'}',
            trailing: Text(
              'employee.home.stats.days'.tr(context: context),
              style: AppTextStyles.font12Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.leavesDashboard),
          ),
        ),
        SizedBox(width: 10.w),
        const Expanded(child: EmployeeHomePointsStatBlocBuilderWidget()),
      ],
    );
  }
}
