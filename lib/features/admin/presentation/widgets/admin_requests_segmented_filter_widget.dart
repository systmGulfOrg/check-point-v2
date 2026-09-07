import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminRequestsSegmentedFilterWidget extends StatelessWidget {
  const AdminRequestsSegmentedFilterWidget({
    required this.selectedFilter,
    required this.onFilterSelected,
    super.key,
  });

  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  static const _filters = <String>[
    'admin.requests.filterAll',
    'admin.requests.filterPending',
    'admin.requests.filterApproved',
    'admin.requests.filterRejected',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: _filters.map((filterKey) {
          final isSelected = selectedFilter == filterKey;
          return Expanded(
            child: InkWell(
              onTap: () => onFilterSelected(filterKey),
              borderRadius: BorderRadius.circular(12.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.cardBackground
                      : AppColors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: isSelected
                      ? const [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    filterKey.tr(context: context),
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: isSelected
                          ? AppColors.brandPrimary
                          : AppColors.textSecondary,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
