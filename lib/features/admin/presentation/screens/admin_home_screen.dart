import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../cubit/admin_attendance_cubit.dart';
import '../cubit/admin_employees_cubit.dart';
import '../cubit/admin_leave_requests_cubit.dart';
import '../cubit/admin_tasks_cubit.dart';
import '../widgets/admin_greeting_widget.dart';
import '../widgets/admin_overview_card_widget.dart';
import '../widgets/admin_stats_grid_widget.dart';
import '../widgets/admin_top_bar_widget.dart';
import '../widgets/admin_weekly_attendance_chart_widget.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employeesState = context.watch<AdminEmployeesCubit>().state;
    final attendanceState = context.watch<AdminAttendanceCubit>().state;
    final leaveState = context.watch<AdminLeaveRequestsCubit>().state;
    final tasksState = context.watch<AdminTasksCubit>().state;

    final isStaffLoading = employeesState.maybeWhen(
      loading: () => true,
      initial: () => true,
      orElse: () => false,
    );

    final isAttendanceLoading = attendanceState.maybeWhen(
      loading: () => true,
      initial: () => true,
      orElse: () => false,
    );

    final isLeaveLoading = leaveState.maybeWhen(
      loading: () => true,
      initial: () => true,
      orElse: () => false,
    );

    final isTasksLoading = tasksState.maybeWhen(
      loading: () => true,
      initial: () => true,
      orElse: () => false,
    );

    final totalStaff = employeesState.maybeWhen(
      success: (employees, filter) => employees.length,
      orElse: () => 0,
    );

    final presentToday = attendanceState.maybeWhen(
      success: (records) => records.length,
      orElse: () => 0,
    );

    final pendingLeaves = leaveState.maybeWhen(
      success: (requests) =>
          requests.where((r) => r.status?.toLowerCase() == 'pending').length,
      orElse: () => 0,
    );

    final openTasks = tasksState.maybeWhen(
      success: (tasks) => tasks.length,
      orElse: () => 0,
    );

    final now = DateTime.now();
    final dateFormatted =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdminTopBarWidget(),
            hSpace(12),
            AdminGreetingWidget(
              userNameKey: 'admin.dashboard.user',
              dateText: dateFormatted,
            ),
            hSpace(12),
            AdminStatsGridWidget(
              totalStaff: totalStaff,
              presentToday: presentToday,
              pendingLeaves: pendingLeaves,
              openTasks: openTasks,
              isStaffLoading: isStaffLoading,
              isAttendanceLoading: isAttendanceLoading,
              isLeaveLoading: isLeaveLoading,
              isTasksLoading: isTasksLoading,
            ),
            hSpace(16),
            const AdminWeeklyAttendanceChartWidget(),
            hSpace(20),
            AdminOverviewCardWidget(
              employeesOnDuty: presentToday,
              totalStaff: totalStaff,
              lateArrivals: 0,
              absences: totalStaff > presentToday
                  ? totalStaff - presentToday
                  : 0,
              pendingLeaveRequests: pendingLeaves,
              dateText: dateFormatted,
              isLoading:
                  isStaffLoading || isAttendanceLoading || isLeaveLoading,
            ),
          ],
        ),
      ),
    );
  }
}
