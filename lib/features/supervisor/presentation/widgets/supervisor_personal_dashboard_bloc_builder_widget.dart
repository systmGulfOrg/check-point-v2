import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_greeting_widget.dart';
import 'supervisor_personal_summary_widget.dart';

class SupervisorPersonalDashboardBlocBuilderWidget extends StatelessWidget {
  const SupervisorPersonalDashboardBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeAttendanceCubit, EmployeeAttendanceState>(
      builder: (context, state) {
        final cubit = context.read<EmployeeAttendanceCubit>();
        final profile = cubit.employeeProfile;
        final attendance = cubit.todayAttendance;
        final workStart = profile?.todayWorkStart ?? profile?.clockInTime;
        final workEnd = profile?.todayWorkEnd ?? profile?.clockOutTime;
        final workSystem = profile?.workSystem ?? 'onsite';
        final workMode = profile?.todayWorkMode ?? 'onsite';
        final isLoading = state is EmployeeAttendanceStateLoading;

        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminGreetingWidget(
                greetingKey: 'supervisor.dashboard.greeting',
                userNameKey: 'supervisor.dashboard.user',
                userName: profile?.name,
                dateText: AppDateFormatter.formatFullDate(DateTime.now()),
              ),
              hSpace(20),
              SupervisorPersonalSummaryWidget(
                policyName:
                    profile?.shiftName ??
                    profile?.workPolicy?.name ??
                    'employee.home.defaultPolicy'.tr(context: context),
                workSystem: workSystem.tr(context: context),
                workMode: workMode.tr(context: context),
                workStart: AppDateFormatter.formatTimeString(workStart),
                workEnd: AppDateFormatter.formatTimeString(workEnd),
                checkIn: AppDateFormatter.formatTimeString(
                  attendance?.clockInTime,
                ),
                checkOut: AppDateFormatter.formatTimeString(
                  attendance?.clockOutTime,
                ),
                leaveBalance: '${profile?.leaveBalance ?? '--'}',
              ),
            ],
          ),
        );
      },
    );
  }
}
