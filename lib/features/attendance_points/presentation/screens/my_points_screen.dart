import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_summary_model.dart';
import '../cubit/points_cubit.dart';
import '../cubit/points_state.dart';
import '../widgets/points_action_button_widget.dart';
import '../widgets/points_balances_grid_widget.dart';
import '../widgets/points_level_progress_card_widget.dart';

class MyPointsScreen extends StatefulWidget {
  const MyPointsScreen({super.key});

  @override
  State<MyPointsScreen> createState() => _MyPointsScreenState();
}

class _MyPointsScreenState extends State<MyPointsScreen> {
  static const _dummySummary = PointsSummaryModel(
    level: PointsLevelModel(
      tier: 'Silver',
      currentPoints: 125,
      nextLevelPoints: 301,
      progress: 0.12,
    ),
    streak: PointsStreakModel(
      currentStreak: 12,
      highestStreak: 20,
    ),
    balances: PointsBalancesModel(
      greenConfirmed: 125,
      greenPending: 5,
      red: 5,
      black: 2,
    ),
  );

  @override
  void initState() {
    super.initState();
    context.read<PointsCubit>().loadAllPointsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'points.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => context.read<PointsCubit>().loadAllPointsData(),
          ),
        ],
      ),
      body: BlocBuilder<PointsCubit, PointsState>(
        builder: (context, state) {
          return switch (state) {
            PointsLoading() => Skeletonizer(
                enabled: true,
                child: _buildPointsContent(context, _dummySummary),
              ),
            PointsError(:final message) => Center(
                child: Padding(
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 48.r,
                        color: AppColors.error,
                      ),
                      hSpace(12),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.font14Regular,
                      ),
                      hSpace(16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<PointsCubit>().loadAllPointsData(),
                        child: Text(
                          'admin.attendance.tryAgain'.tr(context: context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            PointsLoaded(:final summary) => RefreshIndicator(
                onRefresh: () => context.read<PointsCubit>().loadAllPointsData(),
                child: _buildPointsContent(context, summary),
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildPointsContent(
    BuildContext context,
    PointsSummaryModel summary,
  ) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Level & Progress Card
          PointsLevelProgressCardWidget(summary: summary),
          hSpace(16),

          // Balances Grid
          PointsBalancesGridWidget(balances: summary.balances),
          hSpace(20),

          // Quick Actions
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
                    Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.pointsHistory);
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
                    Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.pointsBadges);
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
