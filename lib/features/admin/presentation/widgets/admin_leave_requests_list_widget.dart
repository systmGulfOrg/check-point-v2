import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/animated_list_item_widget.dart';
import 'admin_leave_request_card_widget.dart';
import 'admin_leave_request_data.dart';

class AdminLeaveRequestsListWidget extends StatelessWidget {
  const AdminLeaveRequestsListWidget({
    required this.onApprove,
    required this.onReject,
    super.key,
  });

  final ValueChanged<AdminLeaveRequestData> onApprove;
  final ValueChanged<AdminLeaveRequestData> onReject;

  static const requests = <AdminLeaveRequestData>[
    AdminLeaveRequestData(
      initials: 'FA',
      nameKey: 'supervisor.attendance.members.fatima',
      leaveTypeKey: 'supervisor.leave.annualLeave',
      dateRange: '2026-09-15 - 2026-09-17 (3d)',
      reasonKey: 'supervisor.leave.plannedTravel',
      appliedDate: '2026-09-01',
      statusKey: 'supervisor.leave.pending',
      statusColor: AppColors.warningOrange,
      statusBackgroundColor: AppColors.softYellowBackground,
    ),
    AdminLeaveRequestData(
      initials: 'JM',
      nameKey: 'supervisor.attendance.members.james',
      leaveTypeKey: 'supervisor.leave.annualLeave',
      dateRange: '2026-09-10 - 2026-09-12 (3d)',
      reasonKey: 'supervisor.leave.familyVacation',
      appliedDate: '2026-09-01',
      statusKey: 'supervisor.leave.pending',
      statusColor: AppColors.warningOrange,
      statusBackgroundColor: AppColors.softYellowBackground,
    ),
    AdminLeaveRequestData(
      initials: 'PN',
      nameKey: 'supervisor.attendance.members.priya',
      leaveTypeKey: 'supervisor.leave.sickLeave',
      dateRange: '2026-09-05 - 2026-09-05 (1d)',
      reasonKey: 'supervisor.leave.medicalAppointment',
      appliedDate: '2026-08-31',
      statusKey: 'supervisor.leave.approved',
      statusColor: AppColors.success,
      statusBackgroundColor: AppColors.softGreenBackground,
    ),
    AdminLeaveRequestData(
      initials: 'DC',
      nameKey: 'supervisor.attendance.members.david',
      leaveTypeKey: 'admin.leaveManagement.emergencyLeave',
      dateRange: '2026-09-03 - 2026-09-04 (2d)',
      reasonKey: 'admin.leaveManagement.emergencyReason',
      appliedDate: '2026-08-30',
      statusKey: 'supervisor.leave.approved',
      statusColor: AppColors.success,
      statusBackgroundColor: AppColors.softGreenBackground,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (_, index) {
        final request = requests[index];
        return AnimatedListItemWidget(
          index: index,
          child: AdminLeaveRequestCardWidget(
            request: request,
            onApprove: () => onApprove(request),
            onReject: () => onReject(request),
          ),
        );
      },
    );
  }
}
