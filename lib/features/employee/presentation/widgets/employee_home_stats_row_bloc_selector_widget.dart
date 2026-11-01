import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_state.dart';
import 'employee_home_stats_row_widget.dart';

class EmployeeHomeStatsRowBlocSelectorWidget extends StatelessWidget {
  const EmployeeHomeStatsRowBlocSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EmployeeAttendanceCubit, EmployeeAttendanceState, int?>(
      selector: (_) =>
          context.read<EmployeeAttendanceCubit>().employeeProfile?.leaveBalance,
      builder: (context, leaveBalance) =>
          EmployeeHomeStatsRowWidget(leaveBalance: leaveBalance),
    );
  }
}
