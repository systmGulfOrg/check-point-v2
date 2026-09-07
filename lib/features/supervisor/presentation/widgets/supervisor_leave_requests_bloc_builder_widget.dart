import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/core.dart';
import '../../../admin/data/models/admin_leave_request_model.dart';
import '../cubit/supervisor_leave_requests_cubit.dart';
import '../cubit/supervisor_leave_requests_state.dart';
import 'supervisor_leave_requests_list_widget.dart';

class SupervisorLeaveRequestsBlocBuilderWidget extends StatelessWidget {
  const SupervisorLeaveRequestsBlocBuilderWidget({
    required this.selectedFilterIndex,
    super.key,
  });

  final int selectedFilterIndex;

  static const _dummyRequests = [
    AdminLeaveRequestModel(
      employeeName: 'Loading Employee',
      leaveType: 'Annual Leave',
      startDate: '2026-09-01',
      endDate: '2026-09-05',
      status: 'pending',
    ),
    AdminLeaveRequestModel(
      employeeName: 'Loading Employee',
      leaveType: 'Sick Leave',
      startDate: '2026-09-03',
      endDate: '2026-09-03',
      status: 'approved',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SupervisorLeaveRequestsCubit>();

    return BlocBuilder<
      SupervisorLeaveRequestsCubit,
      SupervisorLeaveRequestsState
    >(
      builder: (context, state) {
        return switch (state) {
          SupervisorLeaveRequestsLoading() => const Skeletonizer(
            enabled: true,
            child: SupervisorLeaveRequestsListWidget(requests: _dummyRequests),
          ),
          SupervisorLeaveRequestsSuccess(:final requests) =>
            SupervisorLeaveRequestsListWidget(
              requests: switch (selectedFilterIndex) {
                1 =>
                  requests
                      .where((r) => r.status?.toLowerCase() == 'pending')
                      .toList(),
                2 =>
                  requests
                      .where((r) => r.status?.toLowerCase() == 'approved')
                      .toList(),
                3 =>
                  requests
                      .where((r) => r.status?.toLowerCase() == 'rejected')
                      .toList(),
                _ => requests,
              },
              onApprove: (req) {
                if (req.id != null) {
                  cubit.approveOrRejectLeaveRequest(
                    ChangeRequestLeaveStatus(
                      leaveRequestId: req.id!,
                      status: 'Approved',
                    ),
                  );
                }
              },
              onReject: (req) {
                if (req.id != null) {
                  cubit.approveOrRejectLeaveRequest(
                    ChangeRequestLeaveStatus(
                      leaveRequestId: req.id!,
                      status: 'Rejected',
                    ),
                  );
                }
              },
            ),
          SupervisorLeaveRequestsError(:final messageKey) => Center(
            child: Text(
              messageKey.tr(context: context),
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
          _ => const SupervisorLeaveRequestsListWidget(requests: []),
        };
      },
    );
  }
}
