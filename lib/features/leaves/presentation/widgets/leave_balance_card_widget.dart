import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../data/models/leave_balance_model.dart';

class LeaveBalanceCardWidget extends StatelessWidget {
  const LeaveBalanceCardWidget({
    super.key,
    required this.balance,
  });

  final LeaveBalanceModel balance;

  @override
  Widget build(BuildContext context) {
    final usedRatio = balance.totalAllocated > 0 
        ? balance.usedBalance / balance.totalAllocated 
        : 0.0;
        
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                balance.leaveTypeName,
                style: AppTextStyles.font16Bold,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.softGreenBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${balance.remainingBalance} ${'leaves.dashboard.daysLeft'.tr()}',
                  style: AppTextStyles.font12Bold.copyWith(color: AppColors.success),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatColumn('leaves.dashboard.total'.tr(), '${balance.totalAllocated}'),
              _buildStatColumn('leaves.dashboard.used'.tr(), '${balance.usedBalance}', color: AppColors.warning),
              _buildStatColumn('leaves.dashboard.remaining'.tr(), '${balance.remainingBalance}', color: AppColors.success),
            ],
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: LinearProgressIndicator(
              value: usedRatio,
              minHeight: 8.h,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation<Color>(
                usedRatio > 0.8 ? AppColors.error : AppColors.brandPrimary,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          if (usedRatio > 0.8)
            Text(
              'leaves.dashboard.warningLowBalance'.tr(),
              style: AppTextStyles.font12Medium.copyWith(color: AppColors.error),
            )
          else if (usedRatio == 0.0)
             Text(
              'leaves.dashboard.noLeavesTaken'.tr(),
              style: AppTextStyles.font12Regular,
            ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, {Color? color}) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.font24Bold.copyWith(
            color: color ?? AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: AppTextStyles.font12Medium,
        ),
      ],
    );
  }
}
