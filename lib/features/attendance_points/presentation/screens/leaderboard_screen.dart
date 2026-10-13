import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_leaderboard_model.dart';
import '../cubit/points_cubit.dart';
import '../cubit/points_state.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'points.leaderboardTitle'.tr(context: context),
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
                child: Text(message, style: AppTextStyles.font14Regular),
              ),
            ),
            PointsLoaded(:final leaderboard) => leaderboard.isEmpty
                ? Center(
                    child: Text(
                      'points.emptyLeaderboard'.tr(context: context),
                      style: AppTextStyles.font14Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => context.read<PointsCubit>().loadAllPointsData(),
                    child: Column(
                      children: [
                        // Podium for Top 3 if available
                        if (leaderboard.length >= 3) ...[
                          _LeaderboardPodium(
                            first: leaderboard[0],
                            second: leaderboard[1],
                            third: leaderboard[2],
                          ),
                          hSpace(12),
                        ],

                        // Full rank list
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            itemCount: leaderboard.length,
                            separatorBuilder: (_, _) => hSpace(8),
                            itemBuilder: (context, index) {
                              final entry = leaderboard[index];
                              return _LeaderboardItemTile(entry: entry);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

class _LeaderboardPodium extends StatelessWidget {
  const _LeaderboardPodium({
    required this.first,
    required this.second,
    required this.third,
  });

  final PointsLeaderboardEntryModel first;
  final PointsLeaderboardEntryModel second;
  final PointsLeaderboardEntryModel third;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardBackground,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 2nd Place
          _PodiumColumn(
            entry: second,
            rank: 2,
            height: 90.h,
            color: const Color(0xFFC0C0C0), // Silver
          ),
          // 1st Place
          _PodiumColumn(
            entry: first,
            rank: 1,
            height: 120.h,
            color: const Color(0xFFFFD700), // Gold
          ),
          // 3rd Place
          _PodiumColumn(
            entry: third,
            rank: 3,
            height: 75.h,
            color: const Color(0xFFCD7F32), // Bronze
          ),
        ],
      ),
    );
  }
}

class _PodiumColumn extends StatelessWidget {
  const _PodiumColumn({
    required this.entry,
    required this.rank,
    required this.height,
    required this.color,
  });

  final PointsLeaderboardEntryModel entry;
  final int rank;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Name & points
        SizedBox(
          width: 85.w,
          child: Column(
            children: [
              Text(
                entry.name,
                style: AppTextStyles.font12Bold,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              hSpace(2),
              Text(
                '${entry.points} pts',
                style: AppTextStyles.font10Medium.copyWith(
                  color: AppColors.brandPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        hSpace(8),
        // Column bar
        Container(
          width: 70.w,
          height: height,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              '$rank',
              style: AppTextStyles.font24Bold.copyWith(color: color),
            ),
          ),
        ),
      ],
    );
  }
}

class _LeaderboardItemTile extends StatelessWidget {
  const _LeaderboardItemTile({required this.entry});

  final PointsLeaderboardEntryModel entry;

  @override
  Widget build(BuildContext context) {
    final isMe = entry.isCurrentUser;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isMe
            ? AppColors.brandPrimary.withValues(alpha: 0.08)
            : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isMe ? AppColors.brandPrimary : AppColors.border,
          width: isMe ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: entry.rank <= 3
                  ? AppColors.warningOrange.withValues(alpha: 0.15)
                  : AppColors.border.withValues(alpha: 0.4),
            ),
            child: Center(
              child: Text(
                '${entry.rank}',
                style: AppTextStyles.font12Bold.copyWith(
                  color: entry.rank <= 3 ? AppColors.warningOrange : AppColors.textPrimary,
                ),
              ),
            ),
          ),
          wSpace(12),

          // Name & department
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        entry.name,
                        style: AppTextStyles.font14Bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isMe) ...[
                      wSpace(6),
                      Text(
                        'points.you'.tr(context: context),
                        style: AppTextStyles.font12Bold.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ],
                  ],
                ),
                if (entry.departmentName != null) ...[
                  hSpace(2),
                  Text(
                    entry.departmentName!,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Points & streak
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${entry.points} pts',
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.success,
                ),
              ),
              if (entry.currentStreak > 0) ...[
                hSpace(2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded,
                      size: 14.r,
                      color: AppColors.warningOrange,
                    ),
                    Text(
                      '${entry.currentStreak}',
                      style: AppTextStyles.font10Medium.copyWith(
                        color: AppColors.warningOrange,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
