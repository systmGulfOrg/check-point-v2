import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../admin/presentation/widgets/admin_stats_grid_widget.dart';
import '../cubit/supervisor_attendance_cubit.dart';
import '../cubit/supervisor_attendance_state.dart';
import '../cubit/supervisor_leave_requests_cubit.dart';
import '../cubit/supervisor_leave_requests_state.dart';
import '../cubit/supervisor_tasks_cubit.dart';
import '../cubit/supervisor_tasks_state.dart';
import '../cubit/supervisor_team_cubit.dart';
import '../cubit/supervisor_team_state.dart';

class SupervisorStatsGridBlocBuilderWidget extends StatelessWidget {
  const SupervisorStatsGridBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupervisorTeamCubit, SupervisorTeamState>(
      builder: (context, teamState) {
        final (totalStaff, isStaffLoading) = switch (teamState) {
          SupervisorTeamLoading() => (0, true),
          SupervisorTeamSuccess(:final members) => (members.length, false),
          _ => (0, false),
        };

        return BlocBuilder<
          SupervisorAttendanceCubit,
          SupervisorAttendanceState
        >(
          builder: (context, attState) {
            final (presentToday, isAttendanceLoading) = switch (attState) {
              SupervisorAttendanceLoading() => (0, true),
              SupervisorAttendanceSuccess(:final attendance) => (
                attendance.length,
                false,
              ),
              _ => (0, false),
            };

            return BlocBuilder<
              SupervisorLeaveRequestsCubit,
              SupervisorLeaveRequestsState
            >(
              builder: (context, leaveState) {
                final (pendingLeaves, isLeaveLoading) = switch (leaveState) {
                  SupervisorLeaveRequestsLoading() => (0, true),
                  SupervisorLeaveRequestsSuccess(:final requests) => (
                    requests
                        .where((r) => r.status?.toLowerCase() == 'pending')
                        .length,
                    false,
                  ),
                  _ => (0, false),
                };

                return BlocBuilder<SupervisorTasksCubit, SupervisorTasksState>(
                  builder: (context, taskState) {
                    final (openTasks, isTasksLoading) = switch (taskState) {
                      SupervisorTasksLoading() => (0, true),
                      SupervisorTasksSuccess(:final tasks) => (
                        tasks
                            .where(
                              (t) =>
                                  t.status?.toLowerCase() != 'completed' &&
                                  t.status?.toLowerCase() != 'done',
                            )
                            .length,
                        false,
                      ),
                      _ => (0, false),
                    };

                    return AdminStatsGridWidget(
                      totalStaff: totalStaff,
                      presentToday: presentToday,
                      pendingLeaves: pendingLeaves,
                      openTasks: openTasks,
                      isStaffLoading: isStaffLoading,
                      isAttendanceLoading: isAttendanceLoading,
                      isLeaveLoading: isLeaveLoading,
                      isTasksLoading: isTasksLoading,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
