import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class LeaveStatusFilterWidget extends StatelessWidget {
  const LeaveStatusFilterWidget({
    required this.selectedIndex,
    required this.onSelected,
    required this.pendingCount,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final int pendingCount;

  @override
  Widget build(BuildContext context) {
    final filters = [
      'employee.leaves.all',
      'employee.leaves.pending',
      'employee.leaves.approved',
      'employee.leaves.rejected',
    ];

    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.selectedBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          for (var index = 0; index < filters.length; index++)
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(index),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? AppColors.cardBackground
                        : AppColors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        filters[index].tr(context: context),
                        style: AppTextStyles.font13SemiBold.copyWith(
                          color: selectedIndex == index
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                      if (index == 1 && pendingCount > 0) ...[
                        SizedBox(width: 4.w),
                        Container(
                          padding: EdgeInsets.all(4.r),
                          constraints: BoxConstraints(
                            minWidth: 14.r,
                            minHeight: 14.r,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$pendingCount',
                              style: AppTextStyles.font11Medium.copyWith(
                                color: AppColors.white,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
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
