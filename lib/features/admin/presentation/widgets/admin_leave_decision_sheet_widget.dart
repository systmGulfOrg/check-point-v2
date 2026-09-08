import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_leave_request_data.dart';

enum AdminLeaveDecision { approve, reject }

class AdminLeaveDecisionSheetWidget extends StatefulWidget {
  const AdminLeaveDecisionSheetWidget({
    required this.request,
    required this.decision,
    super.key,
  });

  final AdminLeaveRequestData request;
  final AdminLeaveDecision decision;

  @override
  State<AdminLeaveDecisionSheetWidget> createState() =>
      _AdminLeaveDecisionSheetWidgetState();
}

class _AdminLeaveDecisionSheetWidgetState
    extends State<AdminLeaveDecisionSheetWidget> {
  final rejectionReasonController = TextEditingController();

  bool get isRejecting => widget.decision == AdminLeaveDecision.reject;

  @override
  void dispose() {
    rejectionReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actionKey = isRejecting
        ? 'supervisor.leave.reject'
        : 'supervisor.leave.approve';
    final titleKey = isRejecting
        ? 'admin.leaveManagement.rejectTitle'
        : 'admin.leaveManagement.approveTitle';
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titleKey.tr(context: context),
                    style: AppTextStyles.font18Bold,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, size: 20.r),
                  ),
                ],
              ),
              const Divider(color: AppColors.border),
              hSpace(14),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.request.nameKey.tr(context: context),
                      style: AppTextStyles.font14SemiBold,
                    ),
                    hSpace(4),
                    Text(
                      widget.request.leaveTypeKey.tr(context: context),
                      style: AppTextStyles.font12Regular,
                    ),
                    hSpace(4),
                    Text(
                      widget.request.dateRange,
                      style: AppTextStyles.font12Regular,
                    ),
                    hSpace(4),
                    Text(
                      '"${widget.request.reasonKey.tr(context: context)}"',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.placeholder,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              if (isRejecting) ...[
                hSpace(16),
                Text(
                  'admin.leaveManagement.rejectionReason'.tr(context: context),
                  style: AppTextStyles.font12Medium,
                ),
                hSpace(8),
                CustomTextFormField(
                  controller: rejectionReasonController,
                  hintText: 'admin.leaveManagement.rejectionReasonHint'.tr(
                    context: context,
                  ),
                  maxLines: 3,
                ),
              ] else ...[
                hSpace(16),
                Text(
                  'admin.leaveManagement.approveDescription'.tr(
                    context: context,
                  ),
                  style: AppTextStyles.font13Regular,
                ),
              ],
              hSpace(20),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'admin.leaveManagement.cancel'.tr(context: context),
                      onTap: () => Navigator.pop(context),
                      backgroundColor: AppColors.pageBackground,
                      textColor: AppColors.textPrimary,
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: CustomButton(
                      text: actionKey.tr(context: context),
                      onTap: () => Navigator.pop(context),
                      backgroundColor: isRejecting
                          ? AppColors.error
                          : AppColors.brandPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
