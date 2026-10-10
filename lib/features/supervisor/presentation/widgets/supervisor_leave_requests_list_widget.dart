import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'supervisor_leave_request_card_widget.dart';

class SupervisorLeaveRequestsListWidget extends StatelessWidget {
  const SupervisorLeaveRequestsListWidget({
    required this.requests,
    super.key,
    this.userRole = 'Employee',
    this.currentUserId = '',
    this.currentEmployeeId = '',
    this.currentUserName = '',
    this.onApprove,
    this.onReject,
  });

  final List<AdminLeaveRequestModel> requests;
  final String userRole;
  final String currentUserId;
  final String currentEmployeeId;
  final String currentUserName;
  final ValueChanged<AdminLeaveRequestModel>? onApprove;
  final ValueChanged<AdminLeaveRequestModel>? onReject;

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 36.h),
          child: Text(
            'employee.leaves.noLeaves'.tr(context: context),
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (context, index) {
        final request = requests[index];
        final isOwnRequest =
            (currentUserId.isNotEmpty && request.employeeId == currentUserId) ||
            (currentEmployeeId.isNotEmpty &&
                request.employeeId == currentEmployeeId) ||
            (currentUserName.isNotEmpty &&
                request.employeeName?.trim().toLowerCase() ==
                    currentUserName.trim().toLowerCase());

        return AnimatedListItemWidget(
          index: index,
          child: SupervisorLeaveRequestCardWidget(
            request: request,
            userRole: userRole,
            isOwnRequest: isOwnRequest,
            currentUserId: currentUserId,
            currentEmployeeId: currentEmployeeId,
            currentUserName: currentUserName,
            onApprove: onApprove != null ? () => onApprove!(request) : null,
            onReject: onReject != null ? () => onReject!(request) : null,
          ),
        );
      },
    );
  }
}
