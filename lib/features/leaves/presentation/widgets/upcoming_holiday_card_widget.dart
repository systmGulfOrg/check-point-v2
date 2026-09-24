import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class UpcomingHolidayCardWidget extends StatelessWidget {
  const UpcomingHolidayCardWidget({
    required this.isTodayHoliday,
    required this.holidayName,
    this.holidayDate,
    this.daysRemaining,
    super.key,
  });

  final bool isTodayHoliday;
  final String holidayName;
  final DateTime? holidayDate;
  final int? daysRemaining;

  @override
  Widget build(BuildContext context) {
    if (isTodayHoliday) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.softGreenBackground,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.success.withValues(alpha: 0.35),
            width: 1.2,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.celebration_rounded,
                size: 24.r,
                color: AppColors.success,
              ),
            ),
            wSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${'holidays.todayHolidayTitle'.tr(context: context)}: $holidayName',
                          style: AppTextStyles.font14Bold.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      wSpace(6),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          'holidays.officialHolidayBadge'.tr(context: context),
                          style: AppTextStyles.font11Medium.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  hSpace(4),
                  Text(
                    'holidays.todayHolidayGreeting'.tr(context: context),
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final formattedDate = holidayDate != null
        ? DateFormat('d MMMM yyyy', context.locale.toString()).format(holidayDate!)
        : '';

    final countdownText = (daysRemaining ?? 0) <= 1
        ? 'holidays.tomorrow'.tr(context: context)
        : 'holidays.daysRemaining'.tr(
            context: context,
            args: [daysRemaining?.toString() ?? ''],
          );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.brandPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.beach_access_rounded,
              size: 22.r,
              color: AppColors.brandPrimary,
            ),
          ),
          wSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'holidays.nearestHolidayTitle'.tr(context: context),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                hSpace(2),
                Text(
                  holidayName,
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (formattedDate.isNotEmpty) ...[
                  hSpace(2),
                  Text(
                    formattedDate,
                    style: AppTextStyles.font11Regular.copyWith(
                      color: AppColors.placeholder,
                    ),
                  ),
                ],
              ],
            ),
          ),
          wSpace(8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.softYellowBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.warningOrange.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              countdownText,
              style: AppTextStyles.font12Bold.copyWith(
                color: AppColors.warningOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
