import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/leave_request_model.dart';
import 'leave_approval_timeline_widget.dart';

class LeaveRequestCardWidget extends StatelessWidget {
  const LeaveRequestCardWidget({
    super.key,
    required this.request,
    this.onDelete,
  });

  final LeaveRequestModel request;
  final VoidCallback? onDelete;

  String _getTranslatedName(String? name) {
    if (name == null || name.isEmpty) return 'leaves.request.title'.tr();
    if (name.startsWith('leaves.dashboard.')) {
      return name.tr();
    }
    final lower = name.toLowerCase().trim();
    if (lower == 'annual leave' ||
        lower == 'annual' ||
        lower == 'إجازة اعتيادية / سنوية') {
      return 'leaves.dashboard.annualLeave'.tr();
    }
    if (lower == 'sick leave' || lower == 'sick' || lower == 'إجازة مرضية') {
      return 'leaves.dashboard.sickLeave'.tr();
    }
    if (lower == 'casual leave' || lower == 'casual' || lower == 'إجازة عارضة') {
      return 'leaves.dashboard.casualLeave'.tr();
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    final status = request.status.toLowerCase();

    final (statusKey, statusColor, statusBg) = switch (status) {
      'pending' || 'pendingmanager' => (
        'leaves.status.pending',
        AppColors.warningOrange,
        AppColors.softYellowBackground,
      ),
      'pendinghr' => (
        'leaves.status.pendingHR',
        AppColors.warningOrange,
        AppColors.softYellowBackground,
      ),
      'approved' || 'approvedbyhr' || 'approvedbymanager' => (
        'leaves.status.approved',
        AppColors.success,
        AppColors.softGreenBackground,
      ),
      'rejected' || 'rejectedbymanager' || 'rejectedbyhr' => (
        'leaves.status.rejected',
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
          tilePadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          childrenPadding: EdgeInsets.zero,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _getTranslatedName(request.leaveTypeName),
                      style: AppTextStyles.font14Bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: statusBg,
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
                        SizedBox(width: 5.w),
                        Text(
                          statusKey.tr(),
                          style: AppTextStyles.font11Medium.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onDelete != null) ...[
                    SizedBox(width: 4.w),
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
              SizedBox(height: 6.h),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 13.r,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Text(
                      '${AppDateFormatter.formatDate(request.startDate)} - ${AppDateFormatter.formatDate(request.endDate)} (${request.totalDays} ${'leaves.dashboard.days'.tr()})',
                      style: AppTextStyles.font12Medium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (request.reason != null && request.reason!.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  request.reason!,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (request.attachmentUrl != null &&
                  request.attachmentUrl!.isNotEmpty) ...[
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.brandPrimary.withValues(alpha: 0.08),
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
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          'leaves.request.hasAttachment'.tr(),
                          style: AppTextStyles.font11Regular.copyWith(
                            color: AppColors.brandPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 14.h),
              child: LeaveApprovalTimelineWidget.fromModel(request: request),
            ),
          ],
        ),
      ),
    );
  }
}
