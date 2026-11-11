import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminCustomerVisitActionBadgeWidget extends StatelessWidget {
  const AdminCustomerVisitActionBadgeWidget({
    super.key,
    required this.action,
  });

  final String action;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, label, icon) = switch (action.toLowerCase()) {
      'created' => (
        AppColors.softBlueBackground,
        AppColors.info,
        'إنشاء الزيارة',
        Icons.add_circle_outline_rounded,
      ),
      'rescheduled' => (
        AppColors.softYellowBackground,
        AppColors.amberStatus,
        'تعديل الموعد',
        Icons.edit_calendar_rounded,
      ),
      'visited' => (
        AppColors.softGreenBackground,
        AppColors.success,
        'تسجيل الحضور',
        Icons.location_on_rounded,
      ),
      'completed' => (
        AppColors.softGreenBackground,
        AppColors.success,
        'تسجيل التقرير',
        Icons.assignment_turned_in_rounded,
      ),
      'cancelled' => (
        AppColors.softRedBackground,
        AppColors.error,
        'إلغاء الزيارة',
        Icons.cancel_outlined,
      ),
      _ => (
        AppColors.pageBackground,
        AppColors.textSecondary,
        'تحديث البيانات',
        Icons.history_rounded,
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: fg.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.r, color: fg),
          SizedBox(width: 6.w),
          Text(label, style: AppTextStyles.font12Bold.copyWith(color: fg)),
        ],
      ),
    );
  }
}
