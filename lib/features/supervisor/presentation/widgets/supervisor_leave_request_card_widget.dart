import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'supervisor_leave_request_action_widget.dart';
import 'supervisor_leave_request_data.dart';

class SupervisorLeaveRequestCardWidget extends StatelessWidget {
  const SupervisorLeaveRequestCardWidget({required this.request, super.key});

  final SupervisorLeaveRequestData request;

  @override
  Widget build(BuildContext context) {
    final isPending = request.statusKey == 'supervisor.leave.pending';
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 19.r,
                  backgroundColor: AppColors.softBrandBackground,
                  child: Text(
                    request.initials,
                    style: AppTextStyles.font12Bold.copyWith(
                      color: AppColors.brandPrimary,
                    ),
                  ),
                ),
                vSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.nameKey.tr(context: context),
                        style: AppTextStyles.font14SemiBold,
                      ),
                      hSpace(2),
                      Text(
                        request.typeKey.tr(
                          context: context,
                          args: [request.dateRange],
                        ),
                        style: AppTextStyles.font12Regular,
                      ),
                      hSpace(2),
                      Text(
                        request.reasonKey.tr(context: context),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.placeholder,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
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
                        style: AppTextStyles.font12Bold.copyWith(
                          color: request.statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isPending)
            Row(
              children: [
                Expanded(
                  child: SupervisorLeaveRequestActionWidget(
                    labelKey: 'supervisor.leave.reject',
                    color: AppColors.error,
                  ),
                ),
                Expanded(
                  child: SupervisorLeaveRequestActionWidget(
                    labelKey: 'supervisor.leave.approve',
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
