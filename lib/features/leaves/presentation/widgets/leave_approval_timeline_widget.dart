import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../../admin/data/models/leave_requests/admin_leave_request_model.dart';
import '../../data/models/leave_request_model.dart';
import 'leave_timeline_step_widget.dart';

class LeaveApprovalTimelineWidget extends StatelessWidget {
  const LeaveApprovalTimelineWidget({
    super.key,
    required this.status,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.directManagerName,
    this.hasDirectManager,
    this.managerName,
    this.managerActionAt,
    this.managerRejectionReason,
    this.hrName,
    this.hrActionAt,
    this.hrRejectionReason,
    this.attachmentUrl,
    this.rejectionReason,
    this.isOwnRequest = false,
  });

  factory LeaveApprovalTimelineWidget.fromModel({
    Key? key,
    required LeaveRequestModel request,
    bool isOwnRequest = false,
  }) {
    return LeaveApprovalTimelineWidget(
      key: key,
      status: request.status,
      startDate: AppDateFormatter.formatDate(request.startDate),
      endDate: AppDateFormatter.formatDate(request.endDate),
      createdAt: request.createdAt != null
          ? AppDateFormatter.formatDate(request.createdAt!)
          : null,
      directManagerName: request.directManagerName ?? request.managerName,
      hasDirectManager: request.hasDirectManager,
      managerName: request.managerName,
      managerActionAt: request.managerActionAt != null
          ? AppDateFormatter.formatDate(request.managerActionAt!)
          : null,
      managerRejectionReason: request.managerRejectionReason,
      hrName: request.hrName,
      hrActionAt: request.hrActionAt != null
          ? AppDateFormatter.formatDate(request.hrActionAt!)
          : null,
      hrRejectionReason: request.hrRejectionReason,
      attachmentUrl: request.attachmentUrl,
      rejectionReason: request.rejectionReason,
      isOwnRequest: isOwnRequest,
    );
  }

  factory LeaveApprovalTimelineWidget.fromAdminModel({
    Key? key,
    required AdminLeaveRequestModel request,
    bool isOwnRequest = false,
  }) {
    return LeaveApprovalTimelineWidget(
      key: key,
      status: request.status ?? 'pending',
      startDate: AppDateFormatter.formatDateString(request.startDate),
      endDate: AppDateFormatter.formatDateString(request.endDate),
      createdAt: null,
      directManagerName: request.directManagerName ?? request.managerName,
      hasDirectManager: request.hasDirectManager,
      managerName: request.managerName,
      managerActionAt: AppDateFormatter.formatDateString(request.managerActionAt),
      managerRejectionReason: request.managerRejectionReason,
      hrName: request.hrName,
      hrActionAt: AppDateFormatter.formatDateString(request.hrActionAt),
      hrRejectionReason: request.hrRejectionReason,
      attachmentUrl: request.attachmentUrl,
      rejectionReason: request.rejectionReason,
      isOwnRequest: isOwnRequest,
    );
  }

  final String status;
  final String? startDate;
  final String? endDate;
  final String? createdAt;
  final String? directManagerName;
  final bool? hasDirectManager;
  final String? managerName;
  final String? managerActionAt;
  final String? managerRejectionReason;
  final String? hrName;
  final String? hrActionAt;
  final String? hrRejectionReason;
  final String? attachmentUrl;
  final String? rejectionReason;
  final bool isOwnRequest;

  void _showAttachmentDialog(BuildContext context, String url) {
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'leaves.workflow.viewAttachment'.tr(context: ctx),
                    style: AppTextStyles.font16Bold,
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    icon: const Icon(Icons.close_rounded),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: _buildAttachmentContent(ctx, url),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentContent(BuildContext ctx, String url) {
    // 1. Base64 Image or data URI
    if (url.startsWith('data:image/') ||
        (!url.startsWith('http') &&
            !url.startsWith('data:application/pdf') &&
            !url.toLowerCase().contains('.pdf'))) {
      try {
        final cleanBase64 = url.contains(',') ? url.split(',').last : url;
        final bytes = base64Decode(cleanBase64.trim());
        return InteractiveViewer(
          maxScale: 4.0,
          child: Image.memory(
            bytes,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => _buildFallback(ctx),
          ),
        );
      } catch (_) {
        // Fallback
      }
    }

    // 2. PDF Document
    if (url.startsWith('data:application/pdf') ||
        url.toLowerCase().contains('.pdf') ||
        url.toLowerCase().contains('.doc')) {
      return Container(
        height: 180.h,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.pageBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.picture_as_pdf_rounded,
              size: 54.r,
              color: AppColors.error,
            ),
            hSpace(10),
            Text(
              'leaves.request.hasAttachment'.tr(context: ctx),
              style: AppTextStyles.font14Bold,
            ),
            hSpace(4),
            Text(
              'PDF Document / المستند المرفق',
              style: AppTextStyles.font12Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    // 3. HTTP URL
    if (url.startsWith('http')) {
      return InteractiveViewer(
        maxScale: 4.0,
        child: Image.network(
          url,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => _buildFallback(ctx),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 200.h,
              alignment: Alignment.center,
              child: const CircularProgressIndicator.adaptive(),
            );
          },
        ),
      );
    }

    return _buildFallback(ctx);
  }

  Widget _buildFallback(BuildContext ctx) {
    return Container(
      height: 200.h,
      color: AppColors.softBrandBackground,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_rounded,
            size: 48.r,
            color: AppColors.placeholder,
          ),
          hSpace(8),
          Text(
            'leaves.workflow.noAttachment'.tr(context: ctx),
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusLower = status.toLowerCase();
    final submittedDate = createdAt ?? startDate ?? '-';

    // Direct manager check
    final noManager = hasDirectManager == false ||
        (directManagerName == null && managerName == null && hasDirectManager == null);

    // Stage 1: Direct Manager Approval
    final (managerStatus, managerActor) = switch (statusLower) {
      'rejectedbymanager' => (
          LeaveStepStatus.rejected,
          managerName != null
              ? '${'leaves.rejection.managerRejected'.tr(context: context)}: $managerName'
              : 'leaves.rejection.managerRejected'.tr(context: context),
        ),
      'pendinghr' || 'approved' || 'rejectedbyhr' => (
          LeaveStepStatus.completed,
          managerName != null
              ? '✓ $managerName'
              : (noManager
                  ? 'leaves.workflow.noDirectManager'.tr(context: context)
                  : 'leaves.approval.approved'.tr(context: context)),
        ),
      'pending' => noManager
          ? (
              LeaveStepStatus.completed,
              'leaves.workflow.noDirectManager'.tr(context: context),
            )
          : (
              LeaveStepStatus.inProgress,
              'leaves.approval.pendingManagerReview'.tr(context: context),
            ),
      _ => (
          LeaveStepStatus.completed,
          managerName ?? directManagerName,
        ),
    };

    // Stage 2: HR / Admin Final Approval
    final (hrStatus, hrActor) = switch (statusLower) {
      'rejectedbymanager' => (
          LeaveStepStatus.waiting,
          'leaves.approval.skippedDueToManagerRejection'.tr(context: context),
        ),
      'rejectedbyhr' || 'rejected' => (
          LeaveStepStatus.rejected,
          hrName != null
              ? '${'leaves.rejection.hrRejected'.tr(context: context)}: $hrName'
              : 'leaves.rejection.hrRejected'.tr(context: context),
        ),
      'approved' => (
          LeaveStepStatus.completed,
          hrName != null
              ? '✓ $hrName'
              : 'leaves.approval.approved'.tr(context: context),
        ),
      'pendinghr' => (
          LeaveStepStatus.inProgress,
          'leaves.approval.pendingHrReview'.tr(context: context),
        ),
      'pending' => noManager
          ? (
              LeaveStepStatus.inProgress,
              'leaves.approval.pendingHrReview'.tr(context: context),
            )
          : (
              LeaveStepStatus.waiting,
              'leaves.approval.waitingForManagerFirst'.tr(context: context),
            ),
      _ => (LeaveStepStatus.waiting, null),
    };

    final effectiveRejectionReason = rejectionReason ??
        managerRejectionReason ??
        hrRejectionReason;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Self-Approval Warning Banner
        if (isOwnRequest) ...[
          Container(
            padding: EdgeInsets.all(10.r),
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: AppColors.softYellowBackground,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.warningOrange.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 18.r,
                  color: AppColors.warningOrange,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'leaves.workflow.selfApprovalDenied'.tr(context: context),
                    style: AppTextStyles.font12Medium.copyWith(
                      color: AppColors.brandInk,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        // Direct Manager Info Banner
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            color: AppColors.softBrandBackground,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.supervisor_account_rounded,
                size: 16.r,
                color: AppColors.brandPrimary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  directManagerName != null && directManagerName!.isNotEmpty
                      ? '${'leaves.workflow.directManager'.tr(context: context)}: $directManagerName'
                      : 'leaves.workflow.noDirectManager'.tr(context: context),
                  style: AppTextStyles.font12SemiBold.copyWith(
                    color: AppColors.brandPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Timeline Stepper
        LeaveTimelineStepWidget(
          title: 'leaves.approval.stage0'.tr(context: context),
          actor: 'leaves.approval.submittedSuccessfully'.tr(context: context),
          date: submittedDate,
          status: LeaveStepStatus.completed,
          isLast: false,
        ),
        LeaveTimelineStepWidget(
          title: 'leaves.approval.stage1'.tr(context: context),
          actor: managerActor,
          date: managerActionAt,
          reason: managerRejectionReason,
          status: managerStatus,
          isLast: false,
        ),
        LeaveTimelineStepWidget(
          title: 'leaves.approval.stage2'.tr(context: context),
          actor: hrActor,
          date: hrActionAt,
          reason: hrRejectionReason,
          status: hrStatus,
          isLast: true,
        ),

        // Rejection Reason Banner
        if (effectiveRejectionReason != null &&
            effectiveRejectionReason.isNotEmpty) ...[
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.softRedBackground,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.error.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.cancel_outlined,
                  size: 16.r,
                  color: AppColors.error,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'leaves.rejection.reason'.tr(context: context),
                        style: AppTextStyles.font12Bold.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        effectiveRejectionReason,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.brandInk,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],

        // Attachment Button
        if (attachmentUrl != null && attachmentUrl!.isNotEmpty) ...[
          SizedBox(height: 10.h),
          InkWell(
            onTap: () => _showAttachmentDialog(context, attachmentUrl!),
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_file_rounded,
                    size: 16.r,
                    color: AppColors.brandPrimary,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'leaves.workflow.viewAttachment'.tr(context: context),
                      style: AppTextStyles.font12SemiBold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.visibility_outlined,
                    size: 16.r,
                    color: AppColors.brandPrimary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
