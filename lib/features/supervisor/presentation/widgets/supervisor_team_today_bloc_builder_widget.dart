import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_state.dart';
import 'supervisor_team_today_widget.dart';

class SupervisorTeamTodayBlocBuilderWidget extends StatelessWidget {
  const SupervisorTeamTodayBlocBuilderWidget({super.key, this.onViewAll});

  final VoidCallback? onViewAll;

  static const _dummyAttendance = [
    AdminAttendanceModel(
      employeeName: 'Loading Employee Name',
      clockInTime: '08:30',
      isLate: false,
    ),
    AdminAttendanceModel(
      employeeName: 'Loading Employee Name',
      clockInTime: '09:15',
      isLate: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupervisorAttendanceCubit, SupervisorAttendanceState>(
      builder: (context, state) {
        return switch (state) {
          SupervisorAttendanceLoading() => Skeletonizer(
            enabled: true,
            child: SupervisorTeamTodayWidget(
              attendance: _dummyAttendance,
              onViewAll: onViewAll,
            ),
          ),
          SupervisorAttendanceSuccess(:final attendance) =>
            SupervisorTeamTodayWidget(
              attendance: attendance,
              onViewAll: onViewAll,
            ),
          SupervisorAttendanceError(:final messageKey) => AppErrorStateWidget(
            messageKey: messageKey,
            onRetry: () =>
                context.read<SupervisorAttendanceCubit>().loadAttendance(),
          ),
          _ => SupervisorTeamTodayWidget(
            attendance: const [],
            onViewAll: onViewAll,
          ),
        };
      },
    );
  }
}
