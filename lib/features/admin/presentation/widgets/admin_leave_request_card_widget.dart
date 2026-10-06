import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/leave_approval_timeline_widget.dart';
import 'admin_leave_request_action_widget.dart';
import 'admin_leave_request_data.dart';

class AdminLeaveRequestCardWidget extends StatelessWidget {
  const AdminLeaveRequestCardWidget({
    required this.request,
    required this.onApprove,
    required this.onReject,
    this.rawModel,
    this.isOwnRequest = false,
    this.onDelete,
    super.key,
  });

  final AdminLeaveRequestData request;
  final AdminLeaveRequestModel? rawModel;
  final bool isOwnRequest;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(14.r),
          childrenPadding: EdgeInsets.fromLTRB(14.r, 0, 14.r, 14.r),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatarWidget(
                imageUrl: request.imageUrl,
                name: request.nameKey.tr(context: context),
                initials: request.initials,
                subtitle: request.leaveTypeKey.tr(context: context),
                radius: 18.r,
                enablePreview: true,
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            request.nameKey.tr(context: context),
                            style: AppTextStyles.font14SemiBold,
                          ),
                        ),
                        if (onDelete != null)
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
                    ),
                    hSpace(3),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            request.leaveTypeKey.tr(context: context),
                            style: AppTextStyles.font13SemiBold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 9.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: request.statusBackgroundColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6.r,
                                height: 6.r,
                                decoration: BoxDecoration(
                                  color: request.statusColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              vSpace(5),
                              Text(
                                request.statusKey.tr(context: context),
                                style: AppTextStyles.font11Medium.copyWith(
                                  color: request.statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    hSpace(4),
                    Text(
                      request.dateRange,
                      style: AppTextStyles.font12Regular,
                    ),
                    hSpace(4),
                    Text(
                      '"${request.reasonKey.tr(context: context)}"',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.placeholder,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    hSpace(4),
                    Text(
                      'admin.leaveManagement.applied'.tr(
                        context: context,
                        args: [request.appliedDate],
                      ),
                      style: AppTextStyles.font12Regular,
                    ),
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
            if (rawModel != null) ...[
              LeaveApprovalTimelineWidget.fromAdminModel(
                request: rawModel!,
                isOwnRequest: isOwnRequest,
              ),
            ],
            if (request.isPending && !isOwnRequest) ...[
              hSpace(12),
              Row(
                children: [
                  Expanded(
                    child: AdminLeaveRequestActionWidget(
                      icon: Icons.check_rounded,
                      labelKey: 'supervisor.leave.approve',
                      color: AppColors.success,
                      onTap: onApprove,
                    ),
                  ),
                  Expanded(
                    child: AdminLeaveRequestActionWidget(
                      icon: Icons.close_rounded,
                      labelKey: 'supervisor.leave.reject',
                      color: AppColors.error,
                      onTap: onReject,
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
