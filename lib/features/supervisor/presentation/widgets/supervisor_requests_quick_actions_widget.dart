import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/remote_work/presentation/cubit/remote_work_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_state.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/verification/pending_verification_cubit.dart';

/// Supervisor shortcuts: team approvals first, then their own requests.
class SupervisorRequestsQuickActionsWidget extends StatelessWidget {
  const SupervisorRequestsQuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = sl<AuthSessionStorage>();
    final hasLeave = storage.isFeatureEnabled('leave');
    final hasOfflineSync = storage.isFeatureEnabled('attendance.offline_sync');
    final hasOvertime = storage.isFeatureEnabled('overtime');
    final hasRemoteWork = storage.isFeatureEnabled('remote_work');

    final leaveState = context.watch<SupervisorLeaveRequestsCubit>().state;
    final pendingApprovals = switch (leaveState) {
      SupervisorLeaveRequestsSuccess(:final requests) =>
        requests.where((r) => r.status?.toLowerCase() == 'pending').length,
      _ => 0,
    };

    final verificationState = context.watch<PendingVerificationCubit>().state;
    final pendingOffline = verificationState.maybeWhen(
      loaded: (items) => items.length,
      orElse: () => 0,
    );

    final remoteWorkState = context.watch<RemoteWorkCubit>().state;
    final pendingRemoteWork = remoteWorkState.maybeWhen(
      success: (_, requests) =>
          requests.where((r) => r.status.toLowerCase() == 'pending').length,
      orElse: () => 0,
    );

    final tiles = <Widget>[];

    if (hasLeave) {
      tiles.add(
        AppQuickActionTileWidget(
          icon: Icons.fact_check_outlined,
          label: 'supervisor.home.quick.approvals'.tr(context: context),
          badgeCount: pendingApprovals,
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.supervisorLeaveManagement),
        ),
      );
    }

    if (hasOfflineSync) {
      tiles.add(
        AppQuickActionTileWidget(
          icon: Icons.offline_pin_outlined,
          label: 'supervisor.home.quick.offline'.tr(context: context),
          badgeCount: pendingOffline,
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.pendingAttendanceVerification,
          ),
        ),
      );
    }

    if (hasOvertime) {
      tiles.add(
        AppQuickActionTileWidget(
          icon: Icons.more_time_rounded,
          label: 'employee.home.quick.overtime'.tr(context: context),
          onTap: () => Navigator.pushNamed(context, AppRoutes.overtime),
        ),
      );
    }

    if (hasRemoteWork) {
      tiles.add(
        AppQuickActionTileWidget(
          icon: Icons.swap_horiz_rounded,
          label: 'employee.home.quick.workLocation'.tr(context: context),
          badgeCount: pendingRemoteWork,
          onTap: () => Navigator.pushNamed(context, AppRoutes.remoteWork),
        ),
      );
    }

    if (tiles.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tiles,
    );
  }
}
