import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../admin/data/models/admin_attendance_model.dart';
import '../cubit/supervisor_attendance_cubit.dart';
import '../cubit/supervisor_attendance_state.dart';
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
          _ => SupervisorTeamTodayWidget(
            attendance: const [],
            onViewAll: onViewAll,
          ),
        };
      },
    );
  }
}
