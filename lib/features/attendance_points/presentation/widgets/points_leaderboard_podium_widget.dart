import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_leaderboard_model.dart';
import 'points_podium_column_widget.dart';

class PointsLeaderboardPodiumWidget extends StatelessWidget {
  const PointsLeaderboardPodiumWidget({
    required this.first,
    required this.second,
    required this.third,
    super.key,
  });

  final PointsLeaderboardEntryModel first;
  final PointsLeaderboardEntryModel second;
  final PointsLeaderboardEntryModel third;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PointsPodiumColumnWidget(
            entry: second,
            rank: 2,
            height: 90.h,
            color: AppColors.medalSilver,
          ),
          PointsPodiumColumnWidget(
            entry: first,
            rank: 1,
            height: 120.h,
            color: AppColors.medalGold,
          ),
          PointsPodiumColumnWidget(
            entry: third,
            rank: 3,
            height: 75.h,
            color: AppColors.medalBronze,
          ),
        ],
      ),
    );
  }
}
