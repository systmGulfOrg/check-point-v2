import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminAttendanceTodaySummaryWidget extends StatelessWidget {
  const AdminAttendanceTodaySummaryWidget({
    required this.presentCount,
    required this.absentCount,
    required this.onTapAbsent,
    super.key,
  });

  final int presentCount;
  final int absentCount;
  final VoidCallback onTapAbsent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // 1. Present Card
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    color: AppColors.softGreenBackground,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.success,
                    size: 20.r,
                  ),
                ),
                wSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$presentCount',
                        style: AppTextStyles.font16Bold.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                      Text(
                        'admin.attendance.presentToday'.tr(context: context),
                        style: AppTextStyles.font11Medium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 32.h,
            width: 1.w,
            color: AppColors.border,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
          ),
          // 2. Absent Card (Clickable)
          Expanded(
            child: InkWell(
              onTap: onTapAbsent,
              borderRadius: BorderRadius.circular(10.r),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Row(
                  children: [
                    Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: BoxDecoration(
                        color: AppColors.softRedBackground,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.person_off_outlined,
                        color: AppColors.error,
                        size: 20.r,
                      ),
                    ),
                    wSpace(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                '$absentCount',
                                style: AppTextStyles.font16Bold.copyWith(
                                  color: AppColors.error,
                                ),
                              ),
                              wSpace(4),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 11.r,
                                color: AppColors.error,
                              ),
                            ],
                          ),
                          Text(
                            'admin.attendance.absentToday'.tr(context: context),
                            style: AppTextStyles.font11Medium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
