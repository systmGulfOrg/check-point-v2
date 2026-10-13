import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_stats_grid_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_state.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_state.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_state.dart';

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

                return AdminStatsGridWidget(
                  totalStaff: totalStaff,
                  presentToday: presentToday,
                  pendingLeaves: pendingLeaves,
                  openTasks: 0,
                  showTasks: false,
                  isStaffLoading: isStaffLoading,
                  isAttendanceLoading: isAttendanceLoading,
                  isLeaveLoading: isLeaveLoading,
                  onTotalStaffTap: () =>
                      Navigator.pushNamed(context, AppRoutes.supervisorTeam),
                  onPresentTodayTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.supervisorAttendance,
                  ),
                  onPendingLeavesTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.supervisorLeaveManagement,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
