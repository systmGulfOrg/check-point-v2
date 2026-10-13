import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_history_model.dart';
import 'points_history_item_card_widget.dart';

class PointsHistorySkeletonWidget extends StatelessWidget {
  const PointsHistorySkeletonWidget({super.key});

  static final List<PointsHistoryItemModel> _items = List.generate(
    6,
    (index) => PointsHistoryItemModel(
      id: 'skeleton-$index',
      pointType: 'GREEN',
      status: 'CONFIRMED',
      source: 'ATTENDANCE',
      points: 20,
      attendanceDate: '2026-01-15T00:00:00.000Z',
      reason: 'Early attendance points',
      createdAt: '2026-01-15T08:00:00.000Z',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: [
          Container(
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            color: AppColors.white,
            child: Row(
              children: List.generate(
                4,
                (index) => Padding(
                  padding: EdgeInsetsDirectional.only(end: 8.w),
                  child: Container(
                    width: index == 0 ? 58.w : 72.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.border,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16.r),
              itemCount: _items.length,
              separatorBuilder: (_, _) => hSpace(10),
              itemBuilder: (context, index) =>
                  PointsHistoryItemCardWidget(item: _items[index]),
            ),
          ),
        ],
      ),
    );
  }
}
