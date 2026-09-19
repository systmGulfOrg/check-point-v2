import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../data/models/leave_request_model.dart';
import '../../../../core/utils/app_date_formatter.dart';

class LeaveApprovalTimelineWidget extends StatelessWidget {
  const LeaveApprovalTimelineWidget({super.key, required this.request});

  final LeaveRequestModel request;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimelineStep(
          context,
          title: 'leaves.approval.stage1'.tr(),
          actor: request.managerName,
          date: request.managerActionAt,
          reason: request.managerRejectionReason,
          isActive: request.managerActionAt != null,
          isRejected: request.status.toLowerCase() == 'rejectedbymanager',
          isLast: false,
        ),
        _buildTimelineStep(
          context,
          title: 'leaves.approval.stage2'.tr(),
          actor: request.hrName,
          date: request.hrActionAt,
          reason: request.hrRejectionReason,
          isActive: request.hrActionAt != null,
          isRejected: request.status.toLowerCase() == 'rejectedbyhr',
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineStep(
    BuildContext context, {
    required String title,
    required String? actor,
    required DateTime? date,
    required String? reason,
    required bool isActive,
    required bool isRejected,
    required bool isLast,
  }) {
    final color = isRejected
        ? AppColors.error
        : (isActive ? AppColors.success : AppColors.placeholder);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24.w,
            child: Column(
              children: [
                Container(
                  width: 12.r,
                  height: 12.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(
                      color: isActive || isRejected ? color : AppColors.border,
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.w,
                      color: isActive ? AppColors.success : AppColors.border,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: isActive || isRejected
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                  if (actor != null && actor.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      actor,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  if (date != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      AppDateFormatter.formatDate(date),
                      style: AppTextStyles.font11Medium.copyWith(
                        color: AppColors.placeholder,
                      ),
                    ),
                  ],
                  if (reason != null && reason.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.softBrandBackground,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        reason,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
