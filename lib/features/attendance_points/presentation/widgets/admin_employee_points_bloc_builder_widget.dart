import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../cubit/points_state.dart';
import '../cubit/points_cubit.dart';
import 'points_balances_grid_widget.dart';
import 'points_history_item_card_widget.dart';
import 'points_level_progress_card_widget.dart';

class AdminEmployeePointsBlocBuilderWidget extends StatelessWidget {
  const AdminEmployeePointsBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointsCubit, PointsState>(
      builder: (context, state) => switch (state) {
        PointsInitial() ||
        PointsLoading() => const Center(child: CircularProgressIndicator()),
        PointsError(:final message) => Center(
          child: Text(message, style: AppTextStyles.font14Regular),
        ),
        PointsLoaded(:final summary, :final history) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PointsLevelProgressCardWidget(summary: summary),
            hSpace(14),
            PointsBalancesGridWidget(balances: summary.balances),
            hSpace(18),
            Text(
              'points.historyTitle'.tr(context: context),
              style: AppTextStyles.font16Bold,
            ),
            hSpace(10),
            if (history.isEmpty)
              Text(
                'points.emptyHistory'.tr(context: context),
                style: AppTextStyles.font13Regular,
              )
            else
              ...history.map(
                (item) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: PointsHistoryItemCardWidget(item: item),
                ),
              ),
          ],
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
