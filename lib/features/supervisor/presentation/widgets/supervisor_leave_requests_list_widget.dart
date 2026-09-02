import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'supervisor_leave_request_card_widget.dart';
import 'supervisor_leave_request_data.dart';

class SupervisorLeaveRequestsListWidget extends StatelessWidget {
  const SupervisorLeaveRequestsListWidget({super.key});

  static const _requests = <SupervisorLeaveRequestData>[
    SupervisorLeaveRequestData(
      initials: 'FA',
      nameKey: 'supervisor.attendance.members.fatima',
      typeKey: 'supervisor.leave.annualLeave',
      dateRange: '2026-09-15 – 2026-09-17',
      reasonKey: 'supervisor.leave.plannedTravel',
      statusKey: 'supervisor.leave.rejected',
      statusColor: AppColors.error,
      statusBackgroundColor: AppColors.softBrandBackground,
    ),
    SupervisorLeaveRequestData(
      initials: 'JM',
      nameKey: 'supervisor.attendance.members.james',
      typeKey: 'supervisor.leave.annualLeave',
      dateRange: '2026-09-10 – 2026-09-12',
      reasonKey: 'supervisor.leave.familyVacation',
      statusKey: 'supervisor.leave.pending',
      statusColor: AppColors.warningOrange,
      statusBackgroundColor: AppColors.softYellowBackground,
    ),
    SupervisorLeaveRequestData(
      initials: 'PN',
      nameKey: 'supervisor.attendance.members.priya',
      typeKey: 'supervisor.leave.sickLeave',
      dateRange: '2026-09-05 – 2026-09-05',
      reasonKey: 'supervisor.leave.medicalAppointment',
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
      itemCount: _requests.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (_, index) =>
          SupervisorLeaveRequestCardWidget(request: _requests[index]),
    );
  }
}
