import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../cubit/points_cubit.dart';
import '../cubit/points_state.dart';

class MyPointsScreen extends StatefulWidget {
  const MyPointsScreen({super.key});

  @override
  State<MyPointsScreen> createState() => _MyPointsScreenState();
}

class _MyPointsScreenState extends State<MyPointsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PointsCubit>().loadAllPointsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'points.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
        centerTitle: true,
        backgroundColor: AppColors.cardBackground,
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
            PointsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            PointsError(:final message) => Center(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline_rounded, size: 48.r, color: AppColors.error),
                    hSpace(12),
                    Text(message, textAlign: TextAlign.center, style: AppTextStyles.font14Regular),
                    hSpace(16),
                    ElevatedButton(
                      onPressed: () => context.read<PointsCubit>().loadAllPointsData(),
                      child: Text('admin.attendance.tryAgain'.tr(context: context)),
                    ),
                  ],
                ),
              ),
            ),
            PointsLoaded(:final summary) => RefreshIndicator(
              onRefresh: () => context.read<PointsCubit>().loadAllPointsData(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Level & Progress Card
                    _LevelProgressCard(summary: summary),
                    hSpace(16),

                    // Balances Grid
                    _BalancesGrid(balances: summary.balances),
                    hSpace(20),

                    // Quick Actions
                    Row(
                      children: [
                        Expanded(
                          child: _ActionButton(
                            title: 'points.exchangeTitle'.tr(context: context),
                            icon: Icons.swap_horiz_rounded,
                            color: AppColors.brandPrimary,
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes.pointExchange);
                            },
                          ),
                        ),
                        wSpace(12),
                        Expanded(
                          child: _ActionButton(
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
                          child: _ActionButton(
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
                          child: _ActionButton(
                            title: 'points.leaderboardTitle'.tr(context: context),
                            icon: Icons.leaderboard_rounded,
                            color: AppColors.info,
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes.pointsLeaderboard);
                            },
                          ),
                        ),
                      ],
                    ),
                    hSpace(24),
                  ],
                ),
              ),
            ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

class _LevelProgressCard extends StatelessWidget {
  const _LevelProgressCard({required this.summary});

  final dynamic summary;

  @override
  Widget build(BuildContext context) {
    final level = summary.level;
    final streak = summary.streak;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.brandPrimary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.stars_rounded, color: AppColors.brandPrimary, size: 24.r),
                  ),
                  wSpace(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(level.tier, style: AppTextStyles.font18Bold),
                      Text(
                        '${level.currentPoints} pts',
                        style: AppTextStyles.font13Regular.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
              if (streak.currentStreak > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.warningOrange.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.local_fire_department_rounded, size: 16.r, color: AppColors.warningOrange),
                      wSpace(4),
                      Text(
                        'points.streakDays'.tr(context: context, args: [streak.currentStreak.toString()]),
                        style: AppTextStyles.font12Bold.copyWith(color: AppColors.warningOrange),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          hSpace(16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: level.progress.clamp(0.0, 1.0),
              minHeight: 8.h,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brandPrimary),
            ),
          ),
          hSpace(8),
          Text(
            'points.nextLevel'.tr(
              context: context,
              args: [(level.nextLevelPoints - level.currentPoints).toString()],
            ),
            style: AppTextStyles.font11Regular.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _BalancesGrid extends StatelessWidget {
  const _BalancesGrid({required this.balances});

  final dynamic balances;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'points.greenConfirmed'.tr(context: context),
                count: '+${balances.greenConfirmed}',
                color: AppColors.success,
                icon: Icons.check_circle_outline_rounded,
              ),
            ),
            wSpace(12),
            Expanded(
              child: _StatCard(
                title: 'points.greenPending'.tr(context: context),
                count: '+${balances.greenPending}',
                color: AppColors.info,
                icon: Icons.hourglass_top_rounded,
              ),
            ),
          ],
        ),
        hSpace(12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'points.red'.tr(context: context),
                count: '-${balances.red}',
                color: AppColors.error,
                icon: Icons.remove_circle_outline_rounded,
              ),
            ),
            wSpace(12),
            Expanded(
              child: _StatCard(
                title: 'points.black'.tr(context: context),
                count: '-${balances.black}',
                color: Colors.black87,
                icon: Icons.warning_amber_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  });

  final String title;
  final String count;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.font12Medium.copyWith(color: AppColors.textSecondary)),
              Icon(icon, size: 18.r, color: color),
            ],
          ),
          hSpace(8),
          Text(count, style: AppTextStyles.font20Bold.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18.r, color: color),
            ),
            wSpace(10),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.font13Bold.copyWith(color: AppColors.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
