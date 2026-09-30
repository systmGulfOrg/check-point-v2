import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_state.dart';
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

  Widget _buildRequestsList(
    BuildContext context,
    SupervisorLeaveRequestsCubit cubit,
    List<AdminLeaveRequestModel> requests,
  ) {
    return SupervisorLeaveRequestsListWidget(
      requests: switch (selectedFilterIndex) {
        1 =>
          requests
              .where(
                (r) =>
                    r.status?.toLowerCase() == 'pending' ||
                    r.status?.toLowerCase() == 'pendinghr',
              )
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
      userRole: cubit.userRole,
      onApprove: (req) {
        if (req.ulid != null) {
          cubit.approveRequest(
            req.ulid!,
            cubit.userRole,
            currentStatus: req.status,
          );
        }
      },
      onReject: (req) {
        if (req.ulid != null) {
          _showRejectReasonDialog(
            context,
            cubit,
            req.ulid!,
            currentStatus: req.status,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SupervisorLeaveRequestsCubit>();

    return BlocListener<
      SupervisorLeaveRequestsCubit,
      SupervisorLeaveRequestsState
    >(
      listener: (context, state) {
        if (state is SupervisorLeaveRequestsError &&
            cubit.allRequests.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.messageKey.tr(context: context)),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: BlocBuilder<
        SupervisorLeaveRequestsCubit,
        SupervisorLeaveRequestsState
      >(
        builder: (context, state) {
          return switch (state) {
            SupervisorLeaveRequestsLoading() => cubit.allRequests.isNotEmpty
                ? _buildRequestsList(context, cubit, cubit.allRequests)
                : const Skeletonizer(
                    enabled: true,
                    child: SupervisorLeaveRequestsListWidget(
                      requests: _dummyRequests,
                    ),
                  ),
            SupervisorLeaveRequestsSuccess(:final requests) =>
              _buildRequestsList(context, cubit, requests),
            SupervisorLeaveRequestsError(:final messageKey) =>
              cubit.allRequests.isNotEmpty
                  ? _buildRequestsList(context, cubit, cubit.allRequests)
                  : Center(
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
      ),
    );
  }

  void _showRejectReasonDialog(
    BuildContext context,
    SupervisorLeaveRequestsCubit cubit,
    String ulid, {
    String? currentStatus,
  }) async {
    final reason = await AppRejectReasonDialogWidget.show(
      context,
      title: 'leaves.rejection.reason'.tr(context: context),
      hintText: 'leaves.rejection.reasonHint'.tr(context: context),
      confirmLabel: 'supervisor.leave.reject'.tr(context: context),
      validator: (value) {
        if (value == null || value.trim().length < 10) {
          return 'leaves.rejection.reasonRequired'.tr(context: context);
        }
        return null;
      },
    );

    if (reason != null && reason.trim().isNotEmpty) {
      cubit.rejectRequest(
        ulid,
        cubit.userRole,
        reason.trim(),
        currentStatus: currentStatus,
      );
    }
  }
}
