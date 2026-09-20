import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../data/models/leave_balance_model.dart';
import 'leave_balance_value_widget.dart';

class LeaveBalanceSummaryWidget extends StatelessWidget {
  const LeaveBalanceSummaryWidget({required this.balances, super.key});

  final List<LeaveBalanceModel> balances;

  @override
  Widget build(BuildContext context) {
    if (balances.isEmpty) {
      return Text(
        'leaves.profile.noBalance'.tr(context: context),
        style: AppTextStyles.font14Regular,
      );
    }

    return Column(
      children: [
        for (final balance in balances)
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: AppColors.softBrandBackground,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.selectedBackground),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.event_available_outlined,
                      color: AppColors.brandPrimary,
                      size: 22.r,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        balance.leaveTypeName,
                        style: AppTextStyles.font14Bold,
                      ),
                    ),
                    Text(
                      '${balance.remainingBalance} ${'leaves.dashboard.daysLeft'.tr(context: context)}',
                      style: AppTextStyles.font12Bold.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LeaveBalanceValueWidget(
                      label: 'leaves.dashboard.total',
                      value: balance.totalAllocated,
                    ),
                    LeaveBalanceValueWidget(
                      label: 'leaves.dashboard.used',
                      value: balance.usedBalance,
                      color: AppColors.warning,
                    ),
                    LeaveBalanceValueWidget(
                      label: 'leaves.dashboard.remaining',
                      value: balance.remainingBalance,
                      color: AppColors.success,
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
