import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

enum SiteMemberFilterType { all, contractors, workers }

class AdminSiteMembersFilterWidget extends StatelessWidget {
  const AdminSiteMembersFilterWidget({
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.allCount,
    required this.contractorsCount,
    required this.workersCount,
    super.key,
  });

  final SiteMemberFilterType selectedFilter;
  final ValueChanged<SiteMemberFilterType> onFilterSelected;
  final int allCount;
  final int contractorsCount;
  final int workersCount;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        _buildFilterChip(
          context,
          type: SiteMemberFilterType.all,
          label: 'admin.siteMembers.all'.tr(context: context),
          count: allCount,
        ),
        vSpace(8),
        _buildFilterChip(
          context,
          type: SiteMemberFilterType.contractors,
          label: 'admin.siteMembers.contractors'.tr(context: context),
          count: contractorsCount,
        ),
        vSpace(8),
        _buildFilterChip(
          context,
          type: SiteMemberFilterType.workers,
          label: 'admin.siteMembers.workers'.tr(context: context),
          count: workersCount,
        ),
      ],
    ),
  );

  Widget _buildFilterChip(
    BuildContext context, {
    required SiteMemberFilterType type,
    required String label,
    required int count,
  }) {
    final isSelected = selectedFilter == type;
    return InkWell(
      onTap: () => onFilterSelected(type),
      borderRadius: BorderRadius.circular(24.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brandPrimary : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected ? AppColors.brandPrimary : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.font13Medium.copyWith(
                color: isSelected ? AppColors.white : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            vSpace(6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.white.withValues(alpha: 0.2)
                    : AppColors.softBlueBackground,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                '$count',
                style: AppTextStyles.font11Medium.copyWith(
                  color: isSelected ? AppColors.white : AppColors.brandPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
