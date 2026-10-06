import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/leave_approval_timeline_widget.dart';
import 'supervisor_leave_request_action_widget.dart';

class SupervisorLeaveRequestCardWidget extends StatelessWidget {
  const SupervisorLeaveRequestCardWidget({
    required this.request,
    super.key,
    this.userRole = 'Employee',
    this.isOwnRequest = false,
    this.onApprove,
    this.onReject,
  });

  final AdminLeaveRequestModel request;
  final String userRole;
  final bool isOwnRequest;
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
    final isPendingHR = status == 'pendinghr';

    final (statusKey, statusColor, statusBgColor) = switch (status) {
      'pending' => (
          'leaves.status.pending',
          AppColors.warningOrange,
          AppColors.softYellowBackground,
        ),
      'pendinghr' => (
          'leaves.status.pendingHR',
          AppColors.warningOrange,
          AppColors.softYellowBackground,
        ),
      'approved' => (
          'leaves.status.approved',
          AppColors.success,
          AppColors.softGreenBackground,
        ),
      'rejectedbymanager' => (
          'leaves.status.rejectedByManager',
          AppColors.error,
          AppColors.softBrandBackground,
        ),
      'rejectedbyhr' => (
          'leaves.status.rejectedByHR',
          AppColors.error,
          AppColors.softBrandBackground,
        ),
      'cancelled' => (
          'leaves.status.cancelled',
          AppColors.placeholder,
          AppColors.border,
        ),
      _ => (
          'leaves.status.rejected',
          AppColors.error,
          AppColors.softBrandBackground,
        ),
    };

    final bool canApprove = !isOwnRequest &&
        (isPending || isPendingHR) &&
        (userRole == 'Admin' || userRole == 'Supervisor');
    final String approveLabel = (isPendingHR || userRole == 'Admin')
        ? 'admin.requests.approve'
        : 'leaves.approval.approveAsManager';

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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
          childrenPadding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatarWidget(
                name: name,
                initials: initials,
                subtitle: request.leaveType,
                radius: 19.r,
                enablePreview: true,
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
                    hSpace(4),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(10.r),
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
                            style: AppTextStyles.font11Medium.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (request.reason != null &&
                        request.reason!.isNotEmpty) ...[
                      hSpace(4),
                      Text(
                        request.reason!,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.placeholder,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (request.attachmentUrl != null &&
                        request.attachmentUrl!.isNotEmpty) ...[
                      hSpace(4),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.brandPrimary.withValues(
                            alpha: 0.08,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.attach_file_rounded,
                              size: 12.r,
                              color: AppColors.brandPrimary,
                            ),
                            wSpace(3),
                            Text(
                              'leaves.request.hasAttachment'.tr(
                                context: context,
                              ),
                              style: AppTextStyles.font11Regular.copyWith(
                                color: AppColors.brandPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          children: [
            LeaveApprovalTimelineWidget.fromAdminModel(
              request: request,
              isOwnRequest: isOwnRequest,
            ),
            if (canApprove) ...[
              hSpace(12),
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
                      labelKey: approveLabel,
                      color: AppColors.success,
                      onTap: onApprove,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
