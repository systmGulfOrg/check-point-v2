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
    if (lower == 'casual leave' ||
        lower == 'casual' ||
        lower == 'إجازة عارضة') {
      return 'leaves.dashboard.casualLeave'.tr();
    }
    return name;
  }

  String _formatDateRange(String? start, String? end) {
    if (start == null && end == null) return '-';
    final startFormatted = AppDateFormatter.formatDateString(start);
    final endFormatted = AppDateFormatter.formatDateString(end);
    int? days;
    if (start != null && end != null) {
      try {
        final s = DateTime.parse(start);
        final e = DateTime.parse(end);
        days = e.difference(s).inDays + 1;
      } catch (_) {}
    }
    if (days != null && days > 0) {
      return '$startFormatted - $endFormatted ($days ${'leaves.dashboard.days'.tr()})';
    }
    return '$startFormatted - $endFormatted';
  }

  (String, Color, Color) _mapStatus(String? status) {
    final s = status?.toLowerCase() ?? '';
    return switch (s) {
      'approved' || 'approvedbyhr' || 'approvedbymanager' => (
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
      'rejected' => (
        'leaves.status.rejected',
        AppColors.error,
        AppColors.softRedBackground,
      ),
      'pendinghr' => (
        'leaves.status.pendingHR',
        AppColors.warningOrange,
        AppColors.softYellowBackground,
      ),
      'pendingmanager' => (
        'leaves.status.pendingManager',
        AppColors.warningOrange,
        AppColors.softYellowBackground,
      ),
      'cancelled' => (
        'leaves.status.cancelled',
        AppColors.placeholder,
        AppColors.pageBackground,
      ),
      _ => (
        'leaves.status.pending',
        AppColors.warningOrange,
        AppColors.softYellowBackground,
      ),
    };
  }

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
      separatorBuilder: (_, _) => hSpace(12),
      itemBuilder: (context, index) {
        final item = requests[index];
        final name = item.employeeName ?? 'Employee';
        final (statusKey, statusColor, statusBgColor) = _mapStatus(item.status);

        final requestData = AdminLeaveRequestData(
          initials: name.isNotEmpty ? name[0] : 'E',
          nameKey: name,
          leaveTypeKey: _getTranslatedName(item.leaveType),
          dateRange: _formatDateRange(item.startDate, item.endDate),
          reasonKey: item.reason ?? '-',
          appliedDate: AppDateFormatter.formatDateString(item.startDate),
          statusKey: statusKey,
          statusColor: statusColor,
          statusBackgroundColor: statusBgColor,
          attachmentUrl: item.attachmentUrl,
        );

        return AdminLeaveRequestCardWidget(
          request: requestData,
          rawModel: item,
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
                title: 'admin.leaveManagement.deleteTitle'.tr(
                  context: dialogCtx,
                ),
                message: 'admin.leaveManagement.deleteMessage'.tr(
                  context: dialogCtx,
                ),
                confirmLabel: 'admin.leaveManagement.deleteConfirm'.tr(
                  context: dialogCtx,
                ),
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
