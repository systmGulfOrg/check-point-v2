import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_leaderboard_model.dart';
import 'points_leaderboard_item_tile_widget.dart';
import 'points_leaderboard_podium_widget.dart';

class PointsLeaderboardSkeletonWidget extends StatelessWidget {
  const PointsLeaderboardSkeletonWidget({super.key});

  static List<PointsLeaderboardEntryModel> get _entries => List.generate(
    6,
    (index) => PointsLeaderboardEntryModel(
      rank: index + 1,
      employeeId: 'skeleton-$index',
      name: 'Employee name',
      departmentName: 'Department',
      points: 120,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final entries = _entries;

    return Skeletonizer(
      child: Column(
        children: [
          PointsLeaderboardPodiumWidget(
            first: entries[0],
            second: entries[1],
            third: entries[2],
          ),
          hSpace(12),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: entries.length,
              separatorBuilder: (_, _) => hSpace(8),
              itemBuilder: (context, index) =>
                  PointsLeaderboardItemTileWidget(entry: entries[index]),
            ),
          ),
        ],
      ),
    );
  }
}
