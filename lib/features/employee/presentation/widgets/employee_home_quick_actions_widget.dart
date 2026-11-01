import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppQuickActionTileWidget(
          icon: Icons.beach_access_rounded,
          label: 'employee.home.quick.leave'.tr(context: context),
          onTap: onRequestLeave,
        ),
        AppQuickActionTileWidget(
          icon: Icons.timer_outlined,
          label: 'employee.home.quick.permit'.tr(context: context),
          onTap: onRequestPermission,
        ),
        AppQuickActionTileWidget(
          icon: Icons.more_time_rounded,
          label: 'employee.home.quick.overtime'.tr(context: context),
          onTap: () => Navigator.pushNamed(context, AppRoutes.overtime),
        ),
        AppQuickActionTileWidget(
          icon: Icons.swap_horiz_rounded,
          label: 'employee.home.quick.workLocation'.tr(context: context),
          onTap: () => Navigator.pushNamed(context, AppRoutes.remoteWork),
        ),
      ],
    );
  }
}
