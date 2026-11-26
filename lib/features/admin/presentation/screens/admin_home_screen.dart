import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/attendance/admin_attendance_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';
import 'package:check_point_v2/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:check_point_v2/features/remote_work/presentation/cubit/remote_work_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/verification/pending_verification_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_greeting_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_overview_card_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_stats_grid_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_top_bar_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_trial_banner_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_weekly_attendance_chart_widget.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  String? _adminName;
  DateTime? _trialEndsAt;
  int? _trialSeatLimit;

  @override
  void initState() {
    super.initState();
    _loadAdminName();
    _loadTrialInfo();
  }

  Future<void> _loadAdminName() async {
    final name = await sl<AuthSessionStorage>().readUserName();
    if (mounted && name != null && name.isNotEmpty) {
      setState(() => _adminName = name);
    }
  }

  Future<void> _loadTrialInfo() async {
    final info = await sl<AuthSessionStorage>().readTrialInfo();
    if (!mounted) return;
    if (info.tenantStatus == 'Trial' && info.trialEndsAt != null) {
      setState(() {
        _trialEndsAt = info.trialEndsAt;
        _trialSeatLimit = info.seatLimit;
      });
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

    final dashboardErrorMessageKey =
        employeesState.maybeWhen(
          error: (messageKey) => messageKey,
          orElse: () => null,
        ) ??
        attendanceState.maybeWhen(
          error: (messageKey) => messageKey,
          orElse: () => null,
        ) ??
        leaveState.maybeWhen(
          error: (messageKey) => messageKey,
          orElse: () => null,
        );

    final employees = employeesState.maybeWhen(
      success: (employees, filter) => employees,
      orElse: () => const <EmployeeModel>[],
    );
    final totalStaff = employees.length;

    final presentToday = attendanceState.maybeWhen(
      success: (records) => records.length,
      orElse: () => 0,
    );

    final leaveRequests = leaveState.maybeWhen(
      success: (requests, leaveTypes) => requests,
      orElse: () => const <AdminLeaveRequestModel>[],
    );

    final pendingLeaves = leaveRequests.where((r) {
      final s = r.status?.toLowerCase();
      return s == 'pending' || s == 'pendinghr';
    }).length;

    final remoteWorkState = context.watch<RemoteWorkCubit>().state;
    final pendingRemoteWork = remoteWorkState.maybeWhen(
      success: (_, requests) =>
          requests.where((r) => r.status.toLowerCase() == 'pending').length,
      orElse: () => 0,
    );

    final verificationState = context.watch<PendingVerificationCubit>().state;
    final pendingOffline = verificationState.maybeWhen(
      loaded: (items) => items.length,
      orElse: () => 0,
    );

    final devicesState = context.watch<AdminPendingDevicesCubit>().state;
    final pendingDevices = devicesState.maybeWhen(
      success: (devices) => devices.length,
      orElse: () => 0,
    );

    final now = DateTime.now();
    final onLeaveToday = employeeIdsOnLeave(leaveRequests, now).length;
    final dateFormatted =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final absentCount = context
        .read<AdminAttendanceCubit>()
        .getAbsentEmployees(employees, leaveRequests)
        .length;

    Future<void> onDashboardRetry() => Future.wait([
      context.read<AdminEmployeesCubit>().loadEmployees(),
      context.read<AdminAttendanceCubit>().loadAttendance(),
      context.read<AdminLeaveRequestsCubit>().loadRequests(),
      context.read<AdminAccountRequestsCubit>().loadRequests(),
      context.read<RemoteWorkCubit>().load(),
      context.read<PendingVerificationCubit>().loadPendingVerifications(),
      context.read<NotificationsCubit>().load(),
    ]);

    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.brandPrimary,
        onRefresh: onDashboardRetry,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AdminTopBarWidget(),
              hSpace(12),
              if (_trialEndsAt != null) ...[
                AdminTrialBannerWidget(
                  trialEndsAt: _trialEndsAt!,
                  seatLimit: _trialSeatLimit,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.adminSubscription),
                ),
                hSpace(12),
              ],
              AdminGreetingWidget(
                userNameKey: 'admin.dashboard.user',
                userName: _adminName,
                dateText: dateFormatted,
              ),
              hSpace(12),
              if (dashboardErrorMessageKey != null)
                AppErrorStateWidget(
                  messageKey: dashboardErrorMessageKey,
                  onRetry: () => unawaited(onDashboardRetry()),
                )
              else ...[
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppQuickActionTileWidget(
                      icon: Icons.fact_check_outlined,
                      label: 'supervisor.home.quick.approvals'.tr(
                        context: context,
                      ),
                      badgeCount: pendingLeaves,
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.adminLeaveManagement,
                      ),
                    ),
                    AppQuickActionTileWidget(
                      icon: Icons.swap_horiz_rounded,
                      label: 'employee.home.quick.workLocation'.tr(
                        context: context,
                      ),
                      badgeCount: pendingRemoteWork,
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.remoteWork),
                    ),
                    AppQuickActionTileWidget(
                      icon: Icons.offline_pin_outlined,
                      label: 'supervisor.home.quick.offline'.tr(
                        context: context,
                      ),
                      badgeCount: pendingOffline,
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.pendingAttendanceVerification,
                      ),
                    ),
                    AppQuickActionTileWidget(
                      icon: Icons.devices_other_rounded,
                      label: 'admin.pendingDevices.title'.tr(
                        context: context,
                      ),
                      badgeCount: pendingDevices,
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.adminPendingDevices,
                      ),
                    ),
                  ],
                ),
                hSpace(16),
                AdminWeeklyAttendanceChartWidget(
                  weeklyData: isAttendanceLoading
                      ? const []
                      : context
                            .read<AdminAttendanceCubit>()
                            .weeklyAttendanceSummary,
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
