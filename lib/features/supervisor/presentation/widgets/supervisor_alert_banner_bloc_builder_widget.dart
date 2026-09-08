import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_state.dart';
import 'supervisor_alert_banner_widget.dart';

class SupervisorAlertBannerBlocBuilderWidget extends StatelessWidget {
  const SupervisorAlertBannerBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      SupervisorLeaveRequestsCubit,
      SupervisorLeaveRequestsState
    >(
      builder: (context, state) {
        return switch (state) {
          SupervisorLeaveRequestsSuccess(:final requests) =>
            requests.any((r) => r.status?.toLowerCase() == 'pending')
                ? SupervisorAlertBannerWidget(
                    messageKey: 'supervisor.dashboard.alertPending',
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.supervisorLeaveManagement,
                    ),
                  )
                : const SizedBox.shrink(),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
