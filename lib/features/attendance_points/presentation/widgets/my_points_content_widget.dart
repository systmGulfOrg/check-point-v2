import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_summary_model.dart';
import '../cubit/points_cubit.dart';
import 'points_action_button_widget.dart';
import 'points_balances_grid_widget.dart';
import 'points_level_progress_card_widget.dart';

class MyPointsContentWidget extends StatelessWidget {
  const MyPointsContentWidget({
    super.key,
    required this.summary,
  });

  final PointsSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PointsLevelProgressCardWidget(summary: summary),
          hSpace(16),
          PointsBalancesGridWidget(balances: summary.balances),
          hSpace(20),
          Row(
            children: [
              Expanded(
                child: PointsActionButtonWidget(
                  title: 'points.exchangeTitle'.tr(context: context),
                  icon: Icons.swap_horiz_rounded,
                  color: AppColors.brandPrimary,
                  onTap: () async {
                    await Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.pointExchange, arguments: summary);
                    if (context.mounted) {
                      context.read<PointsCubit>().loadAllPointsData();
                    }
                  },
                ),
              ),
              wSpace(12),
              Expanded(
                child: PointsActionButtonWidget(
                  title: 'points.historyTitle'.tr(context: context),
                  icon: Icons.history_rounded,
                  color: AppColors.textPrimary,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.pointsHistory);
                  },
                ),
              ),
            ],
          ),
          hSpace(12),
          Row(
            children: [
              Expanded(
                child: PointsActionButtonWidget(
                  title: 'points.badgesTitle'.tr(context: context),
                  icon: Icons.military_tech_rounded,
                  color: AppColors.warningOrange,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.pointsBadges);
                  },
                ),
              ),
              wSpace(12),
              Expanded(
                child: PointsActionButtonWidget(
                  title: 'points.leaderboardTitle'.tr(context: context),
                  icon: Icons.leaderboard_rounded,
                  color: AppColors.info,
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.pointsLeaderboard);
                  },
                ),
              ),
            ],
          ),
          hSpace(24),
        ],
      ),
    );
  }
}
