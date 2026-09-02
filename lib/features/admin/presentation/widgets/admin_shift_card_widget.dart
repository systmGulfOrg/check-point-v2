import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'admin_shift_data.dart';

class AdminShiftCardWidget extends StatelessWidget {
  const AdminShiftCardWidget({
    required this.shift,
    required this.onTap,
    super.key,
  });

  final AdminShiftData shift;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 19.r,
              backgroundColor: AppColors.softBlueBackground,
              child: Icon(
                Icons.access_time_rounded,
                color: AppColors.info,
                size: 20.r,
              ),
            ),
            vSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shift.nameKey.tr(context: context),
                    style: AppTextStyles.font14SemiBold,
                  ),
                  hSpace(3),
                  Text(
                    shift.descriptionKey.tr(context: context),
                    style: AppTextStyles.font12Regular,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.softGreenBackground,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                'admin.shifts.status.active'.tr(context: context),
                style: AppTextStyles.font12Bold.copyWith(
                  color: AppColors.success,
                ),
              ),
            ),
            vSpace(8),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.placeholder,
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}
