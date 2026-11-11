import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';

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

    final tiles = <Widget>[];

    if (hasLeave) {
      tiles.add(
        AppQuickActionTileWidget(
          icon: Icons.fact_check_outlined,
          label: 'supervisor.home.quick.approvals'.tr(context: context),
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
