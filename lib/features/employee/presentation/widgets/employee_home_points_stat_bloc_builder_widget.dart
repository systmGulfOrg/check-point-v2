import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/points_cubit.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/points_state.dart';
import 'employee_home_stat_card_widget.dart';

/// "My points" card: current points and tier; opens the points screen.
class EmployeeHomePointsStatBlocBuilderWidget extends StatelessWidget {
  const EmployeeHomePointsStatBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointsCubit, PointsState>(
      builder: (context, state) {
        final level = switch (state) {
          PointsLoaded(:final summary) => summary.level,
          _ => null,
        };
        return EmployeeHomeStatCardWidget(
          label: 'employee.home.stats.points'.tr(context: context),
          value: '${level?.currentPoints ?? '--'}',
          trailing: level == null
              ? null
              : AppStatusPillWidget(
                  label: 'points.tier.${level.tier.toUpperCase()}'.tr(
                    context: context,
                  ),
                  color: AppColors.amberDark,
                  backgroundColor: AppColors.softYellowBackground,
                ),
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.myPoints),
        );
      },
    );
  }
}
