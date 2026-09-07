import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../admin/data/models/admin_leave_request_model.dart';
import 'supervisor_leave_request_action_widget.dart';

class SupervisorLeaveRequestCardWidget extends StatelessWidget {
  const SupervisorLeaveRequestCardWidget({
    required this.request,
    super.key,
    this.onApprove,
    this.onReject,
  });

  final AdminLeaveRequestModel request;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    final name = request.employeeName ?? 'Employee';
    final initials = name.isNotEmpty
        ? name
              .split(' ')
              .take(2)
              .map((e) => e.isNotEmpty ? e[0].toUpperCase() : '')
              .join()
        : 'EM';
    final status = request.status?.toLowerCase() ?? 'pending';
    final isPending = status == 'pending';
    final isApproved = status == 'approved';

    final (statusKey, statusColor, statusBgColor) = isPending
        ? (
            'supervisor.leave.pending',
            AppColors.warningOrange,
            AppColors.softYellowBackground,
          )
        : isApproved
        ? (
            'supervisor.leave.approved',
            AppColors.success,
            AppColors.softGreenBackground,
          )
        : (
            'supervisor.leave.rejected',
            AppColors.error,
            AppColors.softBrandBackground,
          );

    final start = AppDateFormatter.formatDateString(request.startDate);
    final end = AppDateFormatter.formatDateString(request.endDate);
    final dateRange = '$start – $end';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 19.r,
                  backgroundColor: AppColors.softBrandBackground,
                  child: Text(
                    initials,
                    style: AppTextStyles.font12Bold.copyWith(
                      color: AppColors.brandPrimary,
                    ),
                  ),
                ),
                wSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppTextStyles.font14SemiBold),
                      hSpace(2),
                      Text(
                        '${request.leaveType ?? 'Leave'} ($dateRange)',
                        style: AppTextStyles.font12Regular,
                      ),
                      if (request.reason != null &&
                          request.reason!.isNotEmpty) ...[
                        hSpace(2),
                        Text(
                          request.reason!,
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.placeholder,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6.r,
                        height: 6.r,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      wSpace(5),
                      Text(
                        statusKey.tr(context: context),
                        style: AppTextStyles.font12Bold.copyWith(
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isPending)
            Row(
              children: [
                Expanded(
                  child: SupervisorLeaveRequestActionWidget(
                    labelKey: 'supervisor.leave.reject',
                    color: AppColors.error,
                    onTap: onReject,
                  ),
                ),
                Expanded(
                  child: SupervisorLeaveRequestActionWidget(
                    labelKey: 'supervisor.leave.approve',
                    color: AppColors.success,
                    onTap: onApprove,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
