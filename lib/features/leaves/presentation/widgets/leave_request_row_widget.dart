import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/leaves/data/models/leave_request_model.dart';
import 'package:check_point_v2/features/leaves/presentation/leave_request_labels.dart';

/// Compact list row for a leave request: type and dates, status on the end.
class LeaveRequestRowWidget extends StatelessWidget {
  const LeaveRequestRowWidget({required this.request, super.key});

  final LeaveRequestModel request;

  @override
  Widget build(BuildContext context) {
    final (statusKey, statusColor, statusBg) = leaveStatusStyle(request.status);
    final sameDay = DateUtils.isSameDay(request.startDate, request.endDate);
    final dates = sameDay
        ? AppDateFormatter.formatMediumDate(request.startDate)
        : '${AppDateFormatter.formatMediumDate(request.startDate)} – ${AppDateFormatter.formatMediumDate(request.endDate)}';
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leaveTypeDisplayName(request.leaveTypeName),
                  style: AppTextStyles.font14Bold,
                ),
                hSpace(2),
                Text(
                  '$dates · ${request.totalDays} ${'leaves.dashboard.days'.tr(context: context)}',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          AppStatusPillWidget(
            label: statusKey.tr(context: context),
            color: statusColor,
            backgroundColor: statusBg,
          ),
        ],
      ),
    );
  }
}
