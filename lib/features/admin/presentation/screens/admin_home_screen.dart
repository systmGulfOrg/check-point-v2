import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/attendance/admin_attendance_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_greeting_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_overview_card_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_stats_grid_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_top_bar_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_weekly_attendance_chart_widget.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  String? _adminName;

  @override
  void initState() {
    super.initState();
    _loadAdminName();
  }

  Future<void> _loadAdminName() async {
    final name = await sl<AuthSessionStorage>().readUserName();
    if (mounted && name != null && name.isNotEmpty) {
      setState(() => _adminName = name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final employeesState = context.watch<AdminEmployeesCubit>().state;
    final attendanceState = context.watch<AdminAttendanceCubit>().state;
    final leaveState = context.watch<AdminLeaveRequestsCubit>().state;

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

    final totalStaff = employeesState.maybeWhen(
      success: (employees, filter) => employees.length,
      orElse: () => 0,
    );

    final presentToday = attendanceState.maybeWhen(
      success: (records) => records.length,
      orElse: () => 0,
    );

    final leaveRequests = leaveState.maybeWhen(
      success: (requests, leaveTypes) => requests,
      orElse: () => const <AdminLeaveRequestModel>[],
    );

    final pendingLeaves = leaveRequests
        .where((r) => r.status?.toLowerCase() == 'pending')
        .length;

    final now = DateTime.now();
    final onLeaveToday = employeeIdsOnLeave(leaveRequests, now).length;
    final dateFormatted =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    // Anyone with an approved leave covering today is "on leave", not
    // "absent" — absent is strictly everyone else who hasn't clocked in.
    final absentCount = totalStaff > presentToday + onLeaveToday
        ? totalStaff - presentToday - onLeaveToday
        : 0;

    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.brandPrimary,
        onRefresh: () => Future.wait([
          context.read<AdminEmployeesCubit>().loadEmployees(),
          context.read<AdminAttendanceCubit>().loadAttendance(),
          context.read<AdminLeaveRequestsCubit>().loadRequests(),
        ]),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AdminTopBarWidget(),
              hSpace(12),
              AdminGreetingWidget(
                userNameKey: 'admin.dashboard.user',
                userName: _adminName,
                dateText: dateFormatted,
              ),
              hSpace(12),
              AdminStatsGridWidget(
                totalStaff: totalStaff,
                presentToday: presentToday,
                pendingLeaves: pendingLeaves,
                openTasks: 0,
                onLeaveToday: onLeaveToday,
                showTasks: false,
                showOnLeave: true,
                isStaffLoading: isStaffLoading,
                isAttendanceLoading: isAttendanceLoading,
                isLeaveLoading: isLeaveLoading,
                onTotalStaffTap: () =>
                    Navigator.pushNamed(context, AppRoutes.adminAttendance),
                onPresentTodayTap: () =>
                    Navigator.pushNamed(context, AppRoutes.adminAttendance),
                onPendingLeavesTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.adminLeaveManagement,
                ),
                onOnLeaveTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.adminLeaveManagement,
                ),
              ),
              hSpace(16),
              const AdminWeeklyAttendanceChartWidget(),
              hSpace(20),
              AdminOverviewCardWidget(
                employeesOnDuty: presentToday,
                totalStaff: totalStaff,
                lateArrivals: 0,
                absences: absentCount,
                pendingLeaveRequests: pendingLeaves,
                dateText: dateFormatted,
                isLoading:
                    isStaffLoading || isAttendanceLoading || isLeaveLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
