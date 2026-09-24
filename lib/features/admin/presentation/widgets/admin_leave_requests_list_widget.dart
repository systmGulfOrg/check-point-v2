import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_cubit.dart';
import 'admin_leave_request_card_widget.dart';
import 'admin_leave_request_data.dart';

class AdminLeaveRequestsListWidget extends StatelessWidget {
  const AdminLeaveRequestsListWidget({required this.requests, super.key});

  final List<AdminLeaveRequestModel> requests;

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Center(
          child: Text(
            'admin.requests.emptyAll'.tr(context: context),
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    final cubit = context.read<AdminLeaveRequestsCubit>();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (context, index) {
        final item = requests[index];
        final name = item.employeeName ?? 'Employee';
        final isApproved = item.status?.toLowerCase() == 'approved';
        final isRejected = item.status?.toLowerCase() == 'rejected';

        final requestData = AdminLeaveRequestData(
          initials: name.isNotEmpty ? name[0] : 'E',
          nameKey: name,
          leaveTypeKey: item.leaveType ?? 'Leave',
          dateRange: '${item.startDate ?? '-'} -> ${item.endDate ?? '-'}',
          reasonKey: item.reason ?? '-',
          appliedDate: item.startDate ?? '-',
          statusKey: item.status ?? 'Pending',
          statusColor: isApproved
              ? AppColors.success
              : isRejected
              ? AppColors.error
              : AppColors.warningOrange,
          statusBackgroundColor: isApproved
              ? AppColors.softGreenBackground
              : isRejected
              ? AppColors.softRedBackground
              : AppColors.softYellowBackground,
          attachmentUrl: item.attachmentUrl,
        );

        return AdminLeaveRequestCardWidget(
          request: requestData,
          onApprove: () {
            if (item.id != null) {
              cubit.updateStatus(requestId: item.id!, status: 'Approved');
            }
          },
          onReject: () {
            if (item.id != null) {
              cubit.updateStatus(requestId: item.id!, status: 'Rejected');
            }
          },
          onDelete: () {
            final reqId = item.id ?? item.ulid;
            if (reqId == null) return;
            showDialog<bool>(
              context: context,
              builder: (dialogCtx) => AppDeleteConfirmationDialogWidget(
                title: 'admin.leaveManagement.deleteTitle'.tr(context: dialogCtx),
                message: 'admin.leaveManagement.deleteMessage'.tr(context: dialogCtx),
                confirmLabel: 'admin.leaveManagement.deleteConfirm'.tr(context: dialogCtx),
                onConfirm: () async {
                  Navigator.of(dialogCtx).pop(true);
                },
              ),
            ).then((confirmed) {
              if (confirmed == true) {
                cubit.deleteRequest(reqId);
              }
            });
          },
        );
      },
    );
  }
}
