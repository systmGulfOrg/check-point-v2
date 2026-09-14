import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'admin_requests_empty_state_widget.dart';
import 'admin_supervisors_permission_list_widget.dart';

class AdminSupervisorsPermissionListBlocBuilderWidget extends StatelessWidget {
  const AdminSupervisorsPermissionListBlocBuilderWidget({
    required this.onSupervisorTap,
    super.key,
  });

  final ValueChanged<String> onSupervisorTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminEmployeesCubit, AdminEmployeesState>(
      builder: (context, state) => switch (state) {
        AdminEmployeesStateLoading() || AdminEmployeesStateInitial() =>
          const Center(child: CircularProgressIndicator()),
        AdminEmployeesStateError(:final messageKey) =>
          AdminRequestsEmptyStateWidget(messageKey: messageKey),
        AdminEmployeesStateSuccess(:final employees) ||
        AdminEmployeesStateActionSuccess(
          :final employees,
        ) => AdminSupervisorsPermissionListWidget(
          supervisors: employees,
          onSupervisorTap: onSupervisorTap,
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
