import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_state.dart';
import 'employee_header_widget.dart';

class EmployeeHomeHeaderBlocBuilderWidget extends StatelessWidget {
  const EmployeeHomeHeaderBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeAttendanceCubit, EmployeeAttendanceState>(
      builder: (context, _) {
        final profile = context.read<EmployeeAttendanceCubit>().employeeProfile;
        return EmployeeHeaderWidget(
          titleKey: 'employee.home.title',
          userName: profile?.name ?? 'employee.home.defaultName'.tr(),
          dateText: AppDateFormatter.formatFullDate(DateTime.now()),
          notificationCount: 0,
        );
      },
    );
  }
}
