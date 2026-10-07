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
    final hasDirectManager = rawModel?.hasDirectManager == true ||
        (rawModel?.directManagerName != null &&
            rawModel!.directManagerName!.isNotEmpty);
    final statusLower = (rawModel?.status ?? request.statusKey).toLowerCase();
    final isWaitingForManager = hasDirectManager &&
        rawModel?.managerActionAt == null &&
        (statusLower == 'pending' || statusLower == 'pendingmanager');

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
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
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          shape: const RoundedRectangleBorder(side: BorderSide.none),
          collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
          tilePadding: EdgeInsets.all(14.r),
          childrenPadding: EdgeInsets.fromLTRB(14.r, 0, 14.r, 14.r),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatarWidget(
                imageUrl: request.imageUrl,
                name: request.nameKey,
                initials: request.initials,
                subtitle: request.leaveTypeKey,
                radius: 19.r,
                enablePreview: true,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            request.nameKey,
                            style: AppTextStyles.font14Bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (onDelete != null)
                          Material(
                            color: AppColors.transparent,
                            child: InkWell(
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
                          ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            request.leaveTypeKey,
                            style: AppTextStyles.font13SemiBold.copyWith(
                              color: AppColors.brandPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
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
                              SizedBox(width: 5.w),
                              Text(
                                request.statusKey.tr(context: context),
                                style: AppTextStyles.font11Medium.copyWith(
                                  color: request.statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 13.r,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            request.dateRange,
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (request.reasonKey.isNotEmpty &&
                        request.reasonKey != '-') ...[
                      SizedBox(height: 3.h),
                      Text(
                        '"${request.reasonKey}"',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.placeholder,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 12.r,
                          color: AppColors.placeholder,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'admin.leaveManagement.applied'.tr(
                            context: context,
                            args: [request.appliedDate],
                          ),
                          style: AppTextStyles.font11Regular.copyWith(
                            color: AppColors.placeholder,
                          ),
                        ),
                        if (request.attachmentUrl != null &&
                            request.attachmentUrl!.isNotEmpty) ...[
                          const Spacer(),
                          InkWell(
                            onTap: () => AppDocumentViewerDialogWidget.show(
                              context,
                              fileName: 'مستند طلب الإجازة - ${request.nameKey}',
                              fileUrl: request.attachmentUrl,
                            ),
                            borderRadius: BorderRadius.circular(6.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.brandPrimary.withValues(
                                  alpha: 0.08,
                                ),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.attach_file_rounded,
                                    size: 12.r,
                                    color: AppColors.brandPrimary,
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'leaves.request.hasAttachment'.tr(
                                      context: context,
                                    ),
                                    style: AppTextStyles.font11Regular.copyWith(
                                      color: AppColors.brandPrimary,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
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
              if (isWaitingForManager)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softYellowBackground,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColors.warningOrange.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.hourglass_top_rounded,
                        size: 18.r,
                        color: AppColors.warningOrange,
                      ),
                      wSpace(8),
                      Expanded(
                        child: Text(
                          'leaves.approval.waitingForManagerFirst'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font12Medium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
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
