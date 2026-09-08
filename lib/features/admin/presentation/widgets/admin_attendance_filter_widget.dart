import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminAttendanceFilterWidget extends StatelessWidget {
  const AdminAttendanceFilterWidget({
    required this.selectedFilter,
    required this.onSelected,
    super.key,
  });

  final String selectedFilter;
  final ValueChanged<String> onSelected;

  static const filters = <String>[
    'all',
    'onTime',
    'late',
    'absent',
    'manual',
    'edited',
    'earlyCheckout',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children: [
        for (final filter in filters)
          InkWell(
            onTap: () => onSelected(filter),
            borderRadius: BorderRadius.circular(7.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: selectedFilter == filter
                    ? AppColors.brandPrimary
                    : AppColors.pageBackground,
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Text(
                'admin.attendance.filters.$filter'.tr(context: context),
                style: AppTextStyles.font11Medium.copyWith(
                  color: selectedFilter == filter
                      ? AppColors.white
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
