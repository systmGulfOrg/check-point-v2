import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_history_model.dart';
import '../../data/models/points_summary_model.dart';
import 'points_history_item_card_widget.dart';
import 'points_level_progress_card_widget.dart';

class AdminEmployeePointsSkeletonWidget extends StatelessWidget {
  const AdminEmployeePointsSkeletonWidget({super.key});

  static final summary = PointsSummaryModel(
    level: const PointsLevelModel(
      tier: 'SILVER',
      currentPoints: 125,
      nextLevelPoints: 200,
      progress: 0.62,
    ),
  );

  static final history = List.generate(
    5,
    (index) => PointsHistoryItemModel(
      id: 'skeleton-$index',
      pointType: 'GREEN',
      status: 'CONFIRMED',
      source: 'ATTENDANCE',
      points: 20,
      attendanceDate: '2026-10-13T00:00:00.000Z',
      reason: 'Attendance points',
      createdAt: '2026-10-13T08:00:00.000Z',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PointsLevelProgressCardWidget(summary: summary),
          hSpace(14),
          Container(
            height: 92.h,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          hSpace(18),
          Container(width: 150.w, height: 20.h, color: AppColors.border),
          hSpace(10),
          ...history.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: PointsHistoryItemCardWidget(item: item),
            ),
          ),
        ],
      ),
    );
  }
}
