import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../data/models/leave_request_model.dart';
import 'leave_approval_timeline_widget.dart';

class LeaveRequestCardWidget extends StatelessWidget {
  const LeaveRequestCardWidget({super.key, required this.request});

  final LeaveRequestModel request;

  @override
  Widget build(BuildContext context) {
    final status = request.status.toLowerCase();

    final (statusKey, statusColor, statusBg) = switch (status) {
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
        AppColors.softRedBackground,
      ),
      'rejectedbyhr' => (
        'leaves.status.rejectedByHR',
        AppColors.error,
        AppColors.softRedBackground,
      ),
      'cancelled' => (
        'leaves.status.cancelled',
        AppColors.placeholder,
        AppColors.border,
      ),
      _ => (
        'leaves.status.pending',
        AppColors.warningOrange,
        AppColors.softYellowBackground,
      ),
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
                    Text(
                      request.leaveTypeName ?? 'Leave Request',
                      style: AppTextStyles.font16Bold,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${request.startDate} - ${request.endDate}',
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (request.reason != null &&
                        request.reason!.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        request.reason!,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
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
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      statusKey.tr(),
                      style: AppTextStyles.font12Medium.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
              child: LeaveApprovalTimelineWidget(request: request),
            ),
          ],
        ),
      ),
    );
  }
}
