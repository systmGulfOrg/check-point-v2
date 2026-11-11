import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';

class EmployeeHomeQuickActionsWidget extends StatelessWidget {
  const EmployeeHomeQuickActionsWidget({
    required this.onRequestLeave,
    required this.onRequestPermission,
    super.key,
  });

  final VoidCallback onRequestLeave;
  final VoidCallback onRequestPermission;

  @override
  Widget build(BuildContext context) {
    final storage = sl<AuthSessionStorage>();
    final hasLeave = storage.isFeatureEnabled('leave');
    final hasPermit = storage.isFeatureEnabled('permit');
    final hasOvertime = storage.isFeatureEnabled('overtime');
    final hasRemoteWork = storage.isFeatureEnabled('remote_work');

    final tiles = <Widget>[];

    if (hasLeave) {
      tiles.add(
        AppQuickActionTileWidget(
          icon: Icons.beach_access_rounded,
          label: 'employee.home.quick.leave'.tr(context: context),
          onTap: onRequestLeave,
        ),
      );
    }

    if (hasPermit) {
      tiles.add(
        AppQuickActionTileWidget(
          icon: Icons.timer_outlined,
          label: 'employee.home.quick.permit'.tr(context: context),
          onTap: onRequestPermission,
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

    tiles.add(
      AppQuickActionTileWidget(
        icon: Icons.event_note_rounded,
        label: 'record.title'.tr(context: context),
        onTap: () => Navigator.pushNamed(context, AppRoutes.employeeRecord),
      ),
    );

    tiles.add(
      AppQuickActionTileWidget(
        icon: Icons.gavel_rounded,
        label: 'سجل الجزاءات',
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.disciplinaryDeductions),
      ),
    );

    if (tiles.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tiles,
    );
  }
}
