import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_date_formatter.dart';
import '../../data/models/leave_request_model.dart';
import 'leave_timeline_step_widget.dart';

class LeaveApprovalTimelineWidget extends StatelessWidget {
  const LeaveApprovalTimelineWidget({super.key, required this.request});

  final LeaveRequestModel request;

  @override
  Widget build(BuildContext context) {
    final status = request.status.toLowerCase();

    // Stage 1: Submitted
    final submittedDate = request.createdAt != null
        ? AppDateFormatter.formatDate(request.createdAt!)
        : AppDateFormatter.formatDate(request.startDate);

    // Stage 2: Direct Manager Approval
    final (managerStatus, managerActor) = switch (status) {
      'rejectedbymanager' => (
        LeaveStepStatus.rejected,
        request.managerName != null
            ? '${'leaves.rejection.managerRejected'.tr()}: ${request.managerName}'
            : 'leaves.rejection.managerRejected'.tr(),
      ),
      'pendinghr' || 'approved' || 'rejectedbyhr' => (
        LeaveStepStatus.completed,
        request.managerName != null
            ? '✓ ${request.managerName}'
            : 'leaves.approval.approved'.tr(),
      ),
      'pending' => (
        LeaveStepStatus.inProgress,
        'leaves.approval.pendingManagerReview'.tr(),
      ),
      _ => (
        LeaveStepStatus.completed,
        request.managerName,
      ),
    };

    final managerDateStr = request.managerActionAt != null
        ? AppDateFormatter.formatDate(request.managerActionAt!)
        : null;

    // Stage 3: HR / Admin Final Approval
    final (hrStatus, hrActor) = switch (status) {
      'rejectedbymanager' => (
        LeaveStepStatus.waiting,
        'leaves.approval.skippedDueToManagerRejection'.tr(),
      ),
      'rejectedbyhr' || 'rejected' => (
        LeaveStepStatus.rejected,
        request.hrName != null
            ? '${'leaves.rejection.hrRejected'.tr()}: ${request.hrName}'
            : 'leaves.rejection.hrRejected'.tr(),
      ),
      'approved' => (
        LeaveStepStatus.completed,
        request.hrName != null
            ? '✓ ${request.hrName}'
            : 'leaves.approval.approved'.tr(),
      ),
      'pendinghr' => (
        LeaveStepStatus.inProgress,
        'leaves.approval.pendingHrReview'.tr(),
      ),
      'pending' => (
        LeaveStepStatus.waiting,
        'leaves.approval.waitingForManagerFirst'.tr(),
      ),
      _ => (
        LeaveStepStatus.waiting,
        null,
      ),
    };

    final hrDateStr = request.hrActionAt != null
        ? AppDateFormatter.formatDate(request.hrActionAt!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LeaveTimelineStepWidget(
          title: 'leaves.approval.stage0'.tr(),
          actor: 'leaves.approval.submittedSuccessfully'.tr(),
          date: submittedDate,
          status: LeaveStepStatus.completed,
          isLast: false,
        ),
        LeaveTimelineStepWidget(
          title: 'leaves.approval.stage1'.tr(),
          actor: managerActor,
          date: managerDateStr,
          reason: request.managerRejectionReason,
          status: managerStatus,
          isLast: false,
        ),
        LeaveTimelineStepWidget(
          title: 'leaves.approval.stage2'.tr(),
          actor: hrActor,
          date: hrDateStr,
          reason: request.hrRejectionReason,
          status: hrStatus,
          isLast: true,
        ),
      ],
    );
  }
}
