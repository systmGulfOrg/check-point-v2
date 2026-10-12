import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/admin/presentation/cubit/attendance/admin_attendance_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_state.dart';

class AdminAttendanceEmployeeDirectoryListenerWidget extends StatelessWidget {
  const AdminAttendanceEmployeeDirectoryListenerWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AdminEmployeesCubit, AdminEmployeesState>(
          listener: (context, state) {
            switch (state) {
              case AdminEmployeesStateSuccess(:final employees):
                context.read<AdminAttendanceCubit>().setEmployeeDirectory(
                  employees,
                );
              case AdminEmployeesStateActionSuccess(:final employees):
                context.read<AdminAttendanceCubit>().setEmployeeDirectory(
                  employees,
                );
              default:
                break;
            }
          },
        ),
        BlocListener<AdminBranchesCubit, AdminBranchesState>(
          listener: (context, state) {
            if (state is AdminBranchesSuccess) {
              final siteMap = {
                for (final b in state.branches)
                  if (b.id != null) b.id.toString(): b.name ?? '',
              };
              context.read<AdminAttendanceCubit>().setSiteNames(siteMap);
            }
          },
        ),
      ],
      child: child,
    );
  }
}
