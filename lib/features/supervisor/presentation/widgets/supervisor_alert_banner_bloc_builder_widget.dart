import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_cubit.dart';
import 'supervisor_alert_banner_widget.dart';

class SupervisorAlertBannerBlocBuilderWidget extends StatelessWidget {
  const SupervisorAlertBannerBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SupervisorLeaveRequestsCubit>();
    final hasActionable = cubit.allRequests.any(cubit.isActionableForMe);

    if (!hasActionable) {
      return const SizedBox.shrink();
    }

    return SupervisorAlertBannerWidget(
      messageKey: 'supervisor.dashboard.alertPending',
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.supervisorLeaveManagement,
      ),
    );
  }
}
