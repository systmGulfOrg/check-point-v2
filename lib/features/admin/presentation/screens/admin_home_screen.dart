import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/attendance/admin_attendance_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_greeting_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_overview_card_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_stats_grid_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_top_bar_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_weekly_attendance_chart_widget.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({
    this.onNavigateToEmployees,
    this.onNavigateToRequests,
    super.key,
  });

  final VoidCallback? onNavigateToEmployees;
  final VoidCallback? onNavigateToRequests;

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

    final pendingLeaves = leaveState.maybeWhen(
      success: (requests, leaveTypes) =>
          requests.where((r) => r.status?.toLowerCase() == 'pending').length,
      orElse: () => 0,
    );

    final now = DateTime.now();
    final dateFormatted =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

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
              const AnimatedListItemWidget(
                index: 0,
                child: AdminTopBarWidget(),
              ),
              hSpace(12),
              AnimatedListItemWidget(
                index: 1,
                child: AdminGreetingWidget(
                  userNameKey: 'admin.dashboard.user',
                  dateText: dateFormatted,
                ),
              ),
              hSpace(12),
              AnimatedListItemWidget(
                index: 2,
                child: AdminStatsGridWidget(
                  totalStaff: totalStaff,
                  presentToday: presentToday,
                  pendingLeaves: pendingLeaves,
                  isStaffLoading: isStaffLoading,
                  isAttendanceLoading: isAttendanceLoading,
                  isLeaveLoading: isLeaveLoading,
                  onTapStaff: () {
                    if (onNavigateToEmployees != null) {
                      onNavigateToEmployees!();
                    }
                  },
                  onTapAttendance: () =>
                      Navigator.pushNamed(context, AppRoutes.adminAttendance),
                  onTapLeaves: () =>
                      Navigator.pushNamed(context, AppRoutes.adminLeaveManagement),
                  onTapLocations: () =>
                      Navigator.pushNamed(context, AppRoutes.adminLocations),
                ),
              ),
              hSpace(16),
              const AnimatedListItemWidget(
                index: 3,
                child: AdminWeeklyAttendanceChartWidget(),
              ),
              hSpace(20),
              AnimatedListItemWidget(
                index: 4,
                child: AdminOverviewCardWidget(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
