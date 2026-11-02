import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/leaves/data/models/leave_balance_model.dart';
import 'package:check_point_v2/features/leaves/presentation/leave_request_labels.dart';

/// One leave type: name, days left of the allocation, and a usage bar.
class LeaveBalanceRowWidget extends StatelessWidget {
  const LeaveBalanceRowWidget({required this.balance, super.key});

  final LeaveBalanceModel balance;

  @override
  Widget build(BuildContext context) {
    final total = balance.totalAllocated + balance.carriedOver;
    final used = total == 0 ? 0.0 : (balance.usedBalance / total).clamp(0, 1);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  leaveTypeDisplayName(balance.leaveTypeName),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font14Bold,
                ),
              ),
              Text(
                '${balance.remainingBalance}',
                style: AppTextStyles.font16Bold.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
              Text(
                ' / $total ${'leaves.dashboard.days'.tr(context: context)}',
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          hSpace(8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: used.toDouble(),
              minHeight: 6.h,
              backgroundColor: AppColors.softBrandBackground,
              color: AppColors.brandPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
