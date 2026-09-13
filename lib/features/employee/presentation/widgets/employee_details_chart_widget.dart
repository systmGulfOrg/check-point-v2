import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeDetailsChartWidget extends StatelessWidget {
  const EmployeeDetailsChartWidget({
    required this.attendedDays,
    required this.absentDays,
    required this.lateDays,
    required this.earlyLeaveDays,
    super.key,
  });

  final int attendedDays;
  final int absentDays;
  final int lateDays;
  final int earlyLeaveDays;

  @override
  Widget build(BuildContext context) {
    final values = [attendedDays, absentDays, lateDays, earlyLeaveDays];
    final maxValue = values.fold<int>(
      1,
      (max, value) => value > max ? value : max,
    );
    final labels = [
      'employee.details.attendedDays',
      'employee.details.absentDays',
      'employee.details.lateDays',
      'employee.details.earlyDays',
    ];
    final colors = [
      AppColors.success,
      AppColors.placeholder,
      AppColors.warningOrange,
      AppColors.info,
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 16.h, 14.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'employee.details.monthlyOverview'.tr(context: context),
            style: AppTextStyles.font16Bold,
          ),
          hSpace(18),
          SizedBox(
            height: 130.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int index = 0; index < values.length; index++)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${values[index]}',
                            style: AppTextStyles.font12SemiBold.copyWith(
                              color: colors[index],
                            ),
                          ),
                          hSpace(5),
                          TweenAnimationBuilder<double>(
                            tween: Tween(
                              begin: 0,
                              end: values[index] / maxValue,
                            ),
                            duration: const Duration(milliseconds: 650),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, child) => Container(
                              height: 78.h * value,
                              decoration: BoxDecoration(
                                color: colors[index],
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8.r),
                                ),
                              ),
                            ),
                          ),
                          hSpace(8),
                          Text(
                            labels[index].tr(context: context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.font10Medium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
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
