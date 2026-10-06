import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeAttendanceFilterWidget extends StatelessWidget {
  const EmployeeAttendanceFilterWidget({
    required this.selectedDaysFilter,
    required this.selectedStatusFilters,
    required this.onDaysFilterChanged,
    required this.onStatusFilterToggled,
    required this.onResetFilters,
    super.key,
  });

  final String selectedDaysFilter;
  final Set<String> selectedStatusFilters;
  final ValueChanged<String> onDaysFilterChanged;
  final ValueChanged<String> onStatusFilterToggled;
  final VoidCallback onResetFilters;

  static const _daysOptions = [
    ('all', 'employee.clock.filter.all'),
    ('today', 'employee.clock.filter.today'),
    ('last7', 'employee.clock.filter.last7'),
    ('last30', 'employee.clock.filter.last30'),
  ];

  static const _statusOptions = [
    ('attended', 'employee.clock.filter.attended', AppColors.success),
    ('late', 'employee.clock.filter.late', AppColors.warningOrange),
    ('early', 'employee.clock.filter.early', AppColors.info),
  ];

  @override
  Widget build(BuildContext context) {
    final hasActiveFilters =
        selectedDaysFilter != 'all' || selectedStatusFilters.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Days Filter Row
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final (key, labelKey) in _daysOptions) ...[
                ChoiceChip(
                  label: Text(labelKey.tr(context: context)),
                  selected: selectedDaysFilter == key,
                  onSelected: (_) => onDaysFilterChanged(key),
                  selectedColor: AppColors.brandPrimary,
                  backgroundColor: AppColors.cardBackground,
                  labelStyle: AppTextStyles.font12Medium.copyWith(
                    color: selectedDaysFilter == key
                        ? AppColors.white
                        : AppColors.textSecondary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    side: BorderSide(
                      color: selectedDaysFilter == key
                          ? AppColors.brandPrimary
                          : AppColors.border,
                    ),
                  ),
                  showCheckmark: false,
                ),
                wSpace(8),
              ],
            ],
          ),
        ),
        hSpace(8),
        // Multi-Select Status Filter Row
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final (key, labelKey, color) in _statusOptions) ...[
                      FilterChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              selectedStatusFilters.contains(key)
                                  ? Icons.check_box_rounded
                                  : Icons.check_box_outline_blank_rounded,
                              size: 16.r,
                              color: selectedStatusFilters.contains(key)
                                  ? AppColors.white
                                  : color,
                            ),
                            wSpace(4),
                            Text(labelKey.tr(context: context)),
                          ],
                        ),
                        selected: selectedStatusFilters.contains(key),
                        onSelected: (_) => onStatusFilterToggled(key),
                        selectedColor: color,
                        backgroundColor: AppColors.cardBackground,
                        labelStyle: AppTextStyles.font12Medium.copyWith(
                          color: selectedStatusFilters.contains(key)
                              ? AppColors.white
                              : AppColors.textPrimary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          side: BorderSide(
                            color: selectedStatusFilters.contains(key)
                                ? color
                                : AppColors.border,
                          ),
                        ),
                        showCheckmark: false,
                      ),
                      wSpace(8),
                    ],
                  ],
                ),
              ),
            ),
            if (hasActiveFilters)
              InkWell(
                onTap: onResetFilters,
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.infoBackground,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh_rounded,
                        size: 14.r,
                        color: AppColors.textSecondary,
                      ),
                      wSpace(4),
                      Text(
                        'admin.attendance.filter.all'.tr(context: context),
                        style: AppTextStyles.font12Medium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
