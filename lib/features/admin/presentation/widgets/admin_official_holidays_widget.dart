import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/leaves/data/models/official_holiday_model.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class AdminOfficialHolidaysWidget extends StatelessWidget {
  const AdminOfficialHolidaysWidget({required this.holidays, super.key});

  final List<OfficialHolidayModel> holidays;

  @override
  Widget build(BuildContext context) {
    if (holidays.isEmpty) {
      return Center(
        child: Text(
          'admin.leaveManagement.noHolidays'.tr(context: context),
          style: AppTextStyles.font14Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      itemCount: holidays.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (context, index) {
        final holiday = holidays[index];
        return Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(
                  Icons.event_available_outlined,
                  color: AppColors.brandPrimary,
                ),
              ),
              wSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(holiday.name, style: AppTextStyles.font14SemiBold),
                    hSpace(4),
                    Text(
                      DateFormat.yMMMMd(
                        context.locale.languageCode,
                      ).format(holiday.date),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.lock_outline,
                size: 18.r,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        );
      },
    );
  }
}
