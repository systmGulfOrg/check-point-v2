import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';

class AdminLeaveTypeCardWidget extends StatelessWidget {
  const AdminLeaveTypeCardWidget({
    required this.leaveType,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final LeaveTypeModel leaveType;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final isPaid = leaveType.isPaid ?? true;
    final requiresAttachment = leaveType.requiresAttachment ?? false;
    final maxDays = leaveType.maxDaysPerYear;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: AppColors.softBrandBackground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.beach_access_rounded,
                  color: AppColors.brandPrimary,
                  size: 20.r,
                ),
              ),
              vSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leaveType.typeName ?? '-',
                      style: AppTextStyles.font14SemiBold,
                    ),
                    hSpace(2),
                    Text(
                      maxDays != null
                          ? 'admin.leaveManagement.daysCount'.tr(
                            context: context,
                            args: ['$maxDays'],
                          )
                          : '-',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                color: AppColors.textSecondary,
                onPressed: onEdit,
                splashRadius: 20.r,
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                color: AppColors.error,
                onPressed: onDelete,
                splashRadius: 20.r,
              ),
            ],
          ),
          hSpace(8),
          Wrap(
            spacing: 6.w,
            runSpacing: 4.h,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: isPaid
                      ? AppColors.softGreenBackground
                      : AppColors.softRedBackground,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  isPaid
                      ? 'admin.leaveManagement.paid'.tr(context: context)
                      : 'admin.leaveManagement.unpaid'.tr(context: context),
                  style: AppTextStyles.font11Medium.copyWith(
                    color: isPaid ? AppColors.success : AppColors.error,
                  ),
                ),
              ),
              if (requiresAttachment)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.softBlueBackground,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'admin.leaveManagement.requiresAttachment'.tr(
                      context: context,
                    ),
                    style: AppTextStyles.font11Medium.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
