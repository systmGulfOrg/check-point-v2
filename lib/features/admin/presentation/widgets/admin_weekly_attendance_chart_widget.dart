import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_attendance_legend_item_widget.dart';
import 'admin_weekly_attendance_chart_painter.dart';

class AdminWeeklyAttendanceChartWidget extends StatelessWidget {
  const AdminWeeklyAttendanceChartWidget({required this.weeklyData, super.key});

  final List<({int present, int late, int absent})> weeklyData;

  @override
  Widget build(BuildContext context) {
    final days = <String>[
      'admin.shifts.days.tue'.tr(context: context),
      'admin.shifts.days.wed'.tr(context: context),
      'admin.shifts.days.thu'.tr(context: context),
      'admin.shifts.days.fri'.tr(context: context),
      'admin.shifts.days.sat'.tr(context: context),
      'admin.shifts.days.sun'.tr(context: context),
      'admin.shifts.days.mon'.tr(context: context),
    ];
    final maxValue = weeklyData.fold(1, (currentMax, day) {
      return [
        day.present,
        day.late,
        day.absent,
      ].fold(currentMax, (max, value) => value > max ? value : max);
    });
    final levels = List.generate(
      5,
      (index) => '${(maxValue * (4 - index) / 4).round()}',
    );

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.bar_chart_rounded,
                color: AppColors.cyanAccent,
                size: 20.r,
              ),
              vSpace(8),
              Text(
                'admin.dashboard.thisWeek'.tr(context: context),
                style: AppTextStyles.font16Bold,
              ),
              const Spacer(),
              AdminAttendanceLegendItemWidget(
                color: AppColors.success,
                label: 'admin.dashboard.present'.tr(context: context),
              ),
              vSpace(12),
              AdminAttendanceLegendItemWidget(
                color: AppColors.warningOrange,
                label: 'admin.dashboard.late'.tr(context: context),
              ),
              vSpace(12),
              AdminAttendanceLegendItemWidget(
                color: AppColors.error,
                label: 'admin.dashboard.absent'.tr(context: context),
              ),
            ],
          ),
          hSpace(12),
          SizedBox(
            height: 150.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 30.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final level in levels)
                        Text(
                          level,
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 10.sp,
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: CustomPaint(
                          painter: AdminWeeklyAttendanceChartPainter(
                            weeklyData: weeklyData,
                            maxValue: maxValue,
                          ),
                          child: SizedBox.expand(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (final day in days)
                            Text(
                              day,
                              style: AppTextStyles.font12Regular.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 10.sp,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
