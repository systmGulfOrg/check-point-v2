import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/leave_balance_model.dart';
import 'leave_balance_stat_column_widget.dart';

class LeaveBalanceCardWidget extends StatelessWidget {
  const LeaveBalanceCardWidget({super.key, required this.balance});

  final LeaveBalanceModel balance;

  IconData _getIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('annual') ||
        lower.contains('سنوية') ||
        lower.contains('اعتيادية')) {
      return Icons.beach_access_rounded;
    }
    if (lower.contains('casual') || lower.contains('عارضة')) {
      return Icons.bolt_rounded;
    }
    if (lower.contains('sick') || lower.contains('مرضية')) {
      return Icons.local_hospital_rounded;
    }
    return Icons.event_available_rounded;
  }

  Color _getColor(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('annual') ||
        lower.contains('سنوية') ||
        lower.contains('اعتيادية')) {
      return AppColors.brandPrimary;
    }
    if (lower.contains('casual') || lower.contains('عارضة')) {
      return AppColors.warning;
    }
    if (lower.contains('sick') || lower.contains('مرضية')) {
      return AppColors.error;
    }
    return AppColors.success;
  }

  String _getTranslatedName(String name) {
    if (name.startsWith('leaves.dashboard.')) {
      return name.tr();
    }
    final lower = name.toLowerCase().trim();
    if (lower == 'annual leave' ||
        lower == 'annual' ||
        lower == 'إجازة اعتيادية / سنوية') {
      return 'leaves.dashboard.annualLeave'.tr();
    }
    if (lower == 'sick leave' || lower == 'sick' || lower == 'إجازة مرضية') {
      return 'leaves.dashboard.sickLeave'.tr();
    }
    if (lower == 'casual leave' ||
        lower == 'casual' ||
        lower == 'إجازة عارضة') {
      return 'leaves.dashboard.casualLeave'.tr();
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    final usedRatio = balance.totalAllocated > 0
        ? (balance.usedBalance / balance.totalAllocated).clamp(0.0, 1.0)
        : 0.0;
    final color = _getColor(balance.leaveTypeName);
    final icon = _getIcon(balance.leaveTypeName);
    final title = _getTranslatedName(balance.leaveTypeName);

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: color, size: 20.r),
              ),
              wSpace(10),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.font14Bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.softBrandBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${balance.remainingBalance} ${'leaves.dashboard.daysLeft'.tr(context: context)}',
                  style: AppTextStyles.font12Bold.copyWith(
                    color: AppColors.brandPrimary,
                  ),
                ),
              ),
            ],
          ),
          hSpace(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LeaveBalanceStatColumnWidget(
                label: 'leaves.dashboard.total'.tr(context: context),
                value: '${balance.totalAllocated}',
                color: AppColors.textPrimary,
              ),
              Container(width: 1, height: 28.h, color: AppColors.border),
              LeaveBalanceStatColumnWidget(
                label: 'leaves.dashboard.used'.tr(context: context),
                value: '${balance.usedBalance}',
                color: AppColors.warning,
              ),
              Container(width: 1, height: 28.h, color: AppColors.border),
              LeaveBalanceStatColumnWidget(
                label: 'leaves.dashboard.remaining'.tr(context: context),
                value: '${balance.remainingBalance}',
                color: color,
              ),
            ],
          ),
          hSpace(12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: usedRatio,
              minHeight: 6.h,
              backgroundColor: AppColors.pageBackground,
              valueColor: AlwaysStoppedAnimation<Color>(
                usedRatio > 0.8 ? AppColors.error : color,
              ),
            ),
          ),
          hSpace(6),
          if (usedRatio > 0.8)
            Text(
              'leaves.dashboard.warningLowBalance'.tr(context: context),
              style: AppTextStyles.font11Medium.copyWith(
                color: AppColors.error,
              ),
            )
          else
            Text(
              usedRatio == 0.0
                  ? 'leaves.dashboard.noLeavesTaken'.tr(context: context)
                  : '${(usedRatio * 100).toInt()}% ${'leaves.dashboard.used'.tr(context: context)}',
              style: AppTextStyles.font11Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}
