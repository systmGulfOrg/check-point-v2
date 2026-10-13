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
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
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
                    width: 48.r,
                    height: 48.r,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.brandPrimary.withValues(alpha: 0.2),
                          AppColors.brandPrimary.withValues(alpha: 0.05),
                        ],
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.stars_rounded, color: AppColors.brandPrimary, size: 28.r),
                  ),
                  wSpace(14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        level.tier.toUpperCase(),
                        style: AppTextStyles.font18Bold.copyWith(
                          letterSpacing: 0.8,
                        ),
                      ),
                      hSpace(2),
                      Text(
                        '${level.currentPoints} pts',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (streak.currentStreak > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.warningOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColors.warningOrange.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.local_fire_department_rounded, size: 18.r, color: AppColors.warningOrange),
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
          hSpace(20),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: LinearProgressIndicator(
              value: level.progress.clamp(0.0, 1.0),
              minHeight: 10.h,
              backgroundColor: AppColors.border.withValues(alpha: 0.4),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brandPrimary),
            ),
          ),
          hSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'points.nextLevel'.tr(
                  context: context,
                  args: [(level.nextLevelPoints - level.currentPoints).toString()],
                ),
                style: AppTextStyles.font11Medium.copyWith(color: AppColors.textSecondary),
              ),
              Text(
                '${(level.progress * 100).toInt()}%',
                style: AppTextStyles.font11Bold.copyWith(color: AppColors.brandPrimary),
              ),
            ],
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
                icon: Icons.check_circle_rounded,
                bgColor: AppColors.success.withValues(alpha: 0.05),
              ),
            ),
            wSpace(12),
            Expanded(
              child: _StatCard(
                title: 'points.greenPending'.tr(context: context),
                count: '+${balances.greenPending}',
                color: AppColors.info,
                icon: Icons.hourglass_top_rounded,
                bgColor: AppColors.info.withValues(alpha: 0.05),
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
                icon: Icons.remove_circle_rounded,
                bgColor: AppColors.error.withValues(alpha: 0.05),
              ),
            ),
            wSpace(12),
            Expanded(
              child: _StatCard(
                title: 'points.black'.tr(context: context),
                count: '-${balances.black}',
                color: AppColors.brandInk,
                icon: Icons.warning_amber_rounded,
                bgColor: AppColors.brandInk.withValues(alpha: 0.05),
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
    required this.bgColor,
  });

  final String title;
  final String count;
  final Color color;
  final IconData icon;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.font12Medium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16.r, color: color),
              ),
            ],
          ),
          hSpace(12),
          Text(
            count,
            style: AppTextStyles.font24Bold.copyWith(
              color: color,
              letterSpacing: 0.5,
            ),
          ),
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
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20.r, color: color),
            ),
            wSpace(12),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
