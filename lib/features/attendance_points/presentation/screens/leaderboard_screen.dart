import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../cubit/points_cubit.dart';
import '../cubit/points_state.dart';
import '../widgets/points_leaderboard_item_tile_widget.dart';
import '../widgets/points_leaderboard_podium_widget.dart';

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
                    onRefresh: () =>
                        context.read<PointsCubit>().loadAllPointsData(),
                    child: Column(
                      children: [
                        // Podium for Top 3 if available
                        if (leaderboard.length >= 3) ...[
                          PointsLeaderboardPodiumWidget(
                            first: leaderboard[0],
                            second: leaderboard[1],
                            third: leaderboard[2],
                          ),
                          hSpace(12),
                        ],

                        // Full rank list
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            itemCount: leaderboard.length,
                            separatorBuilder: (_, _) => hSpace(8),
                            itemBuilder: (context, index) {
                              final entry = leaderboard[index];
                              return PointsLeaderboardItemTileWidget(
                                entry: entry,
                              );
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
