import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../cubit/admin_attendance_cubit.dart';

class AdminAttendanceFilterBarWidget extends StatelessWidget {
  const AdminAttendanceFilterBarWidget({super.key});

  Future<void> _pickCustomDateRange(BuildContext context) async {
    final cubit = context.read<AdminAttendanceCubit>();
    final initialRange = (cubit.customStartDate != null && cubit.customEndDate != null)
        ? DateTimeRange(start: cubit.customStartDate!, end: cubit.customEndDate!)
        : DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now(),
          );

    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: initialRange,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.brandPrimary,
            onPrimary: AppColors.white,
            surface: AppColors.cardBackground,
            onSurface: AppColors.textPrimary,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      cubit.setDateFilter(
        AdminAttendanceDateFilter.custom,
        startDate: picked.start,
        endDate: picked.end,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AdminAttendanceCubit>();
    final selectedFilter = cubit.selectedDateFilter;

    final filters = [
      (
        AdminAttendanceDateFilter.today,
        'admin.attendance.filter.today'.tr(context: context),
      ),
      (
        AdminAttendanceDateFilter.last30Days,
        'admin.attendance.filter.last30'.tr(context: context),
      ),
      (
        AdminAttendanceDateFilter.last90Days,
        'admin.attendance.filter.last90'.tr(context: context),
      ),
      (
        AdminAttendanceDateFilter.last180Days,
        'admin.attendance.filter.last180'.tr(context: context),
      ),
      (
        AdminAttendanceDateFilter.custom,
        cubit.customStartDate != null && cubit.customEndDate != null
            ? '${DateFormat('MM/dd').format(cubit.customStartDate!)} - ${DateFormat('MM/dd').format(cubit.customEndDate!)}'
            : 'admin.attendance.filter.custom'.tr(context: context),
      ),
      (
        AdminAttendanceDateFilter.all,
        'admin.attendance.filter.all'.tr(context: context),
      ),
    ];

    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => vSpace(8),
        itemBuilder: (context, index) {
          final item = filters[index];
          final isSelected = selectedFilter == item.$1;

          return ChoiceChip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.$1 == AdminAttendanceDateFilter.custom) ...[
                  Icon(
                    Icons.date_range_rounded,
                    size: 14.r,
                    color: isSelected
                        ? AppColors.brandPrimary
                        : AppColors.textSecondary,
                  ),
                  vSpace(4),
                ],
                Text(item.$2),
              ],
            ),
            selected: isSelected,
            onSelected: (_) {
              if (item.$1 == AdminAttendanceDateFilter.custom) {
                _pickCustomDateRange(context);
              } else {
                cubit.setDateFilter(item.$1);
              }
            },
            selectedColor: AppColors.softBrandBackground,
            backgroundColor: AppColors.cardBackground,
            labelStyle: AppTextStyles.font13SemiBold.copyWith(
              color: isSelected
                  ? AppColors.brandPrimary
                  : AppColors.textSecondary,
            ),
            side: BorderSide(
              color: isSelected
                  ? AppColors.brandPrimary.withValues(alpha: 0.4)
                  : AppColors.border,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            showCheckmark: false,
          );
        },
      ),
    );
  }
}
