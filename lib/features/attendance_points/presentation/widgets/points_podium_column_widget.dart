import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_leaderboard_model.dart';

class PointsPodiumColumnWidget extends StatelessWidget {
  const PointsPodiumColumnWidget({
    required this.entry,
    required this.rank,
    required this.height,
    required this.color,
    super.key,
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
                '${entry.effectivePoints} pts',
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
