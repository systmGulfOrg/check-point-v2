import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/leave_timeline_step_widget.dart';
import 'employee_leave_data.dart';

class EmployeeLeaveCardWidget extends StatelessWidget {
  const EmployeeLeaveCardWidget({
    required this.leave,
    this.onDelete,
    super.key,
  });

  final EmployeeLeaveData leave;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final status = leave.status.toLowerCase();

    final (statusKey, statusBg, statusText) = switch (status) {
      'approved' => (
        'leaves.status.approved',
        AppColors.softGreenBackground,
        AppColors.success,
      ),
      'pendinghr' => (
        'leaves.status.pendingHR',
        AppColors.softYellowBackground,
        AppColors.warningOrange,
      ),
      'pending' || 'pendingmanager' => (
        'leaves.status.pending',
        AppColors.softYellowBackground,
        AppColors.warningOrange,
      ),
      'rejectedbymanager' => (
        'leaves.status.rejectedByManager',
        AppColors.softRedBackground,
        AppColors.error,
      ),
      'rejectedbyhr' || 'rejected' => (
        'leaves.status.rejectedByHR',
        AppColors.softRedBackground,
        AppColors.error,
      ),
      'cancelled' => (
        'leaves.status.cancelled',
        AppColors.border,
        AppColors.placeholder,
      ),
      _ => (
        leave.status,
        AppColors.softYellowBackground,
        AppColors.warningOrange,
      ),
    };

    final (managerStatus, managerActor) = switch (status) {
      'rejectedbymanager' => (
        LeaveStepStatus.rejected,
        leave.managerName != null
            ? '${'leaves.rejection.managerRejected'.tr()}: ${leave.managerName}'
            : 'leaves.rejection.managerRejected'.tr(),
      ),
      'pendinghr' || 'approved' || 'rejectedbyhr' => (
        LeaveStepStatus.completed,
        leave.managerName != null
            ? '✓ ${leave.managerName}'
            : 'leaves.approval.approved'.tr(),
      ),
      'pending' || 'pendingmanager' => (
        LeaveStepStatus.inProgress,
        'leaves.approval.pendingManagerReview'.tr(),
      ),
      _ => (LeaveStepStatus.completed, leave.managerName),
    };

    final (hrStatus, hrActor) = switch (status) {
      'rejectedbymanager' => (
        LeaveStepStatus.waiting,
        'leaves.approval.skippedDueToManagerRejection'.tr(),
      ),
      'rejectedbyhr' || 'rejected' => (
        LeaveStepStatus.rejected,
        leave.hrName != null
            ? '${'leaves.rejection.hrRejected'.tr()}: ${leave.hrName}'
            : 'leaves.rejection.hrRejected'.tr(),
      ),
      'approved' => (
        LeaveStepStatus.completed,
        leave.hrName != null
            ? '✓ ${leave.hrName}'
            : 'leaves.approval.approved'.tr(),
      ),
      'pendinghr' => (
        LeaveStepStatus.inProgress,
        'leaves.approval.pendingHrReview'.tr(),
      ),
      'pending' || 'pendingmanager' => (
        LeaveStepStatus.waiting,
        'leaves.approval.waitingForManagerFirst'.tr(),
      ),
      _ => (LeaveStepStatus.waiting, null),
    };

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(16.w),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(leave.leaveType, style: AppTextStyles.font16Bold),
                    hSpace(4),
                    Text(
                      leave.dateRange,
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (leave.reason != null && leave.reason!.isNotEmpty) ...[
                      hSpace(4),
                      Text(
                        leave.reason!,
                        style: AppTextStyles.font13Regular.copyWith(
                          color: AppColors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6.r,
                          height: 6.r,
                          decoration: BoxDecoration(
                            color: statusText,
                            shape: BoxShape.circle,
                          ),
                        ),
                        wSpace(6),
                        Text(
                          statusKey.tr(context: context),
                          style: AppTextStyles.font12Medium.copyWith(
                            color: statusText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onDelete != null) ...[
                    wSpace(8),
                    InkWell(
                      onTap: onDelete,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Padding(
                        padding: EdgeInsets.all(4.r),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          size: 18.r,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(color: AppColors.border, height: 1),
                  hSpace(14),
                  LeaveTimelineStepWidget(
                    title: 'leaves.approval.stage0'.tr(),
                    actor: 'leaves.approval.submittedSuccessfully'.tr(),
                    date: leave.appliedDate,
                    status: LeaveStepStatus.completed,
                    isLast: false,
                  ),
                  LeaveTimelineStepWidget(
                    title: 'leaves.approval.stage1'.tr(),
                    actor: managerActor,
                    date: leave.managerActionAt,
                    reason: leave.managerRejectionReason,
                    status: managerStatus,
                    isLast: false,
                  ),
                  LeaveTimelineStepWidget(
                    title: 'leaves.approval.stage2'.tr(),
                    actor: hrActor,
                    date: leave.hrActionAt,
                    reason: leave.hrRejectionReason,
                    status: hrStatus,
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
