import 'package:check_point_v2/features/admin/presentation/screens/admin_employee_audit_screen.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee_audit/admin_employee_audit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/attendance/admin_attendance_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_customers_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/plans/admin_plans_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/tasks/admin_tasks_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_attendance_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_create_employee_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_departments_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_leave_management_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_locations_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_main_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_permission_details_screen.dart';
import 'package:check_point_v2/features/admin/data/models/permissions/admin_permission_employee_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/permissions/admin_permissions_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_permissions_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_plans_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_request_details_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_shift_details_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_shifts_policies_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_tasks_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_devices_screen.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_attendance_employee_directory_listener_widget.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/session/auth_session_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account/request_account_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/screens/login_screen.dart';
import 'package:check_point_v2/features/auth/presentation/screens/request_access_screen.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/leave_requests/employee_leave_requests_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/odoo_dashboard/employee_odoo_dashboard_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/plans/employee_plans_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/permit_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/tasks/employee_tasks_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/screens/employee_main_screen.dart';
import 'package:check_point_v2/features/employee/presentation/screens/employee_settings_screen.dart';

import 'package:check_point_v2/features/leaves/presentation/screens/request_leave_screen.dart';
import 'package:check_point_v2/features/leaves/presentation/screens/request_permission_screen.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/plans/supervisor_plans_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/tasks/supervisor_tasks_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/screens/supervisor_leave_management_screen.dart';
import 'package:check_point_v2/features/supervisor/presentation/screens/supervisor_main_screen.dart';
import 'package:check_point_v2/features/supervisor/presentation/screens/supervisor_notifications_screen.dart';
import 'package:check_point_v2/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/screens/supervisor_plans_screen.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/styles/app_motion.dart';
import 'routes.dart';

class AppRouter {
  const AppRouter._();

  static Route<void> _fadeRoute({
    required Widget child,
    required RouteSettings settings,
  }) => PageRouteBuilder<void>(
    settings: settings,
    transitionDuration: AppMotion.routeEnter,
    reverseTransitionDuration: AppMotion.routeExit,
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, pageChild) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: AppMotion.enterCurve,
        reverseCurve: AppMotion.exitCurve,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(
            begin: AppMotion.routeScaleBegin,
            end: 1,
          ).animate(curved),
          child: pageChild,
        ),
      );
    },
  );

  static Route<void> _slideRoute({
    required Widget child,
    required RouteSettings settings,
  }) => PageRouteBuilder<void>(
    settings: settings,
    transitionDuration: AppMotion.routeEnter,
    reverseTransitionDuration: AppMotion.routeExit,
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, pageChild) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: AppMotion.enterCurve,
        reverseCurve: AppMotion.exitCurve,
      );
      final isRtl = Directionality.of(context) == TextDirection.rtl;
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(
              isRtl ? -AppMotion.routeSlideBegin : AppMotion.routeSlideBegin,
              0,
            ),
            end: Offset.zero,
          ).animate(curved),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: AppMotion.routeScaleBegin,
              end: 1,
            ).animate(curved),
            child: pageChild,
          ),
        ),
      );
    },
  );

  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.adminEmployeeAudit:
        final employeeId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) =>
                sl<AdminEmployeeAuditCubit>()..loadAuditLogs(employeeId),
            child: const AdminEmployeeAuditScreen(),
          ),
        );
      case AppRoutes.login:
        return _fadeRoute(
          settings: const RouteSettings(name: AppRoutes.login),
          child: BlocProvider<LoginCubit>(
            create: (_) => sl<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case AppRoutes.requestAccess:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.requestAccess),
          child: BlocProvider<RequestAccountCubit>(
            create: (_) => sl<RequestAccountCubit>(),
            child: const RequestAccessScreen(),
          ),
        );

      case AppRoutes.adminRequestDetails:
        final request = settings.arguments;
        if (request is! AccountRequestModel) {
          return _fadeRoute(
            settings: settings,
            child: const Scaffold(
              body: Center(child: Text('Invalid request details')),
            ),
          );
        }
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminRequestDetails),
          child: BlocProvider<AdminAccountRequestsCubit>(
            create: (_) => sl<AdminAccountRequestsCubit>(),
            child: AdminRequestDetailsScreen(request: request),
          ),
        );

      case AppRoutes.adminCreateEmployee:
        final request = settings.arguments;
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminCreateEmployee),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AdminEmployeesCubit>(
                create: (_) => sl<AdminEmployeesCubit>(),
              ),
              BlocProvider<AdminAccountRequestsCubit>(
                create: (_) => sl<AdminAccountRequestsCubit>(),
              ),
              BlocProvider<AdminBranchesCubit>(
                create: (_) => sl<AdminBranchesCubit>()..load(),
              ),
              BlocProvider<AdminDepartmentsCubit>(
                create: (_) => sl<AdminDepartmentsCubit>()..load(),
              ),
              BlocProvider<AdminShiftsPoliciesCubit>(
                create: (_) => sl<AdminShiftsPoliciesCubit>()..load(),
              ),
            ],
            child: AdminCreateEmployeeScreen(
              accountRequest: request is AccountRequestModel ? request : null,
            ),
          ),
        );

      case AppRoutes.admin:
        return _fadeRoute(
          settings: const RouteSettings(name: AppRoutes.admin),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthSessionCubit>(
                create: (_) => sl<AuthSessionCubit>(),
              ),
              BlocProvider<AuthProfileCubit>(
                create: (_) => sl<AuthProfileCubit>()..loadProfile(),
              ),
              BlocProvider<AdminEmployeesCubit>(
                create: (_) => sl<AdminEmployeesCubit>()..loadEmployees(),
              ),
              BlocProvider<AdminAccountRequestsCubit>(
                create: (_) => sl<AdminAccountRequestsCubit>()..loadRequests(),
              ),
              BlocProvider<AdminAttendanceCubit>(
                create: (_) => sl<AdminAttendanceCubit>()..loadAttendance(),
              ),
              BlocProvider<AdminLeaveRequestsCubit>(
                create: (_) => sl<AdminLeaveRequestsCubit>()..loadRequests(),
              ),
              BlocProvider<AdminTasksCubit>(
                create: (_) => sl<AdminTasksCubit>()..loadTasks(),
              ),
              BlocProvider<AdminPendingDevicesCubit>(
                create: (_) => sl<AdminPendingDevicesCubit>()..loadDevices(),
              ),
            ],
            child: const AdminMainScreen(),
          ),
        );

      case AppRoutes.adminDepartments:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminDepartments),
          child: BlocProvider<AdminDepartmentsCubit>(
            create: (_) => sl<AdminDepartmentsCubit>()..load(),
            child: const AdminDepartmentsScreen(),
          ),
        );

      case AppRoutes.adminLocations:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminLocations),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AdminBranchesCubit>(
                create: (_) => sl<AdminBranchesCubit>()..load(),
              ),
              BlocProvider<AdminDepartmentsCubit>(
                create: (_) => sl<AdminDepartmentsCubit>()..load(),
              ),
              BlocProvider<AdminCustomersCubit>(
                create: (_) =>
                    sl<AdminCustomersCubit>()..load(type: 'Customer'),
              ),
            ],
            child: const AdminLocationsScreen(),
          ),
        );

      case AppRoutes.adminShiftsPolicies:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminShiftsPolicies),
          child: BlocProvider<AdminShiftsPoliciesCubit>(
            create: (_) => sl<AdminShiftsPoliciesCubit>()..load(),
            child: const AdminShiftsPoliciesScreen(),
          ),
        );

      case AppRoutes.adminPermissions:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminPermissions),
          child: BlocProvider<AdminPermissionsCubit>(
            create: (_) => sl<AdminPermissionsCubit>()..load(),
            child: const AdminPermissionsScreen(),
          ),
        );

      case AppRoutes.adminPermissionDetails:
        final supervisorKey = settings.arguments;
        if (supervisorKey is! AdminPermissionEmployeeModel) {
          return _fadeRoute(
            settings: settings,
            child: const Scaffold(
              body: Center(child: Text('Invalid supervisor')),
            ),
          );
        }
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminPermissionDetails),
          child: BlocProvider<AdminPermissionsCubit>(
            create: (_) =>
                sl<AdminPermissionsCubit>()
                  ..load(selectedUserId: supervisorKey.user.id),
            child: AdminPermissionDetailsScreen(supervisorKey: supervisorKey),
          ),
        );

      case AppRoutes.adminLeaveManagement:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminLeaveManagement),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AdminLeaveRequestsCubit>(
                create: (_) => sl<AdminLeaveRequestsCubit>()..loadAll(),
              ),
              BlocProvider<LeavesCubit>(create: (_) => sl<LeavesCubit>()),
            ],
            child: const AdminLeaveManagementScreen(),
          ),
        );

      case AppRoutes.adminPendingDevices:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.adminPendingDevices),
          builder: (_) => BlocProvider<AdminPendingDevicesCubit>(
            create: (_) => sl<AdminPendingDevicesCubit>(),
            child: const AdminDevicesScreen(),
          ),
        );
      case AppRoutes.adminTasks:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminTasks),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AdminTasksCubit>(
                create: (_) => sl<AdminTasksCubit>()..loadTasks(),
              ),
              BlocProvider<AdminEmployeesCubit>(
                create: (_) => sl<AdminEmployeesCubit>()..loadEmployees(),
              ),
              BlocProvider<AdminDepartmentsCubit>(
                create: (_) => sl<AdminDepartmentsCubit>()..load(),
              ),
            ],
            child: const AdminTasksScreen(),
          ),
        );

      case AppRoutes.adminPlans:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminPlans),
          child: BlocProvider<AdminPlansCubit>(
            create: (_) => sl<AdminPlansCubit>()..loadPlans(),
            child: const AdminPlansScreen(),
          ),
        );

      case AppRoutes.adminAttendance:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminAttendance),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AdminEmployeesCubit>(
                create: (_) => sl<AdminEmployeesCubit>()..loadEmployees(),
              ),
              BlocProvider<AdminDepartmentsCubit>(
                create: (_) => sl<AdminDepartmentsCubit>()..load(),
              ),
              BlocProvider<AdminAttendanceCubit>(
                create: (_) => sl<AdminAttendanceCubit>()..loadAttendance(),
              ),
            ],
            child: const AdminAttendanceEmployeeDirectoryListenerWidget(
              child: AdminAttendanceScreen(),
            ),
          ),
        );

      case AppRoutes.adminShiftDetails:
        final shiftKey = settings.arguments;
        final shiftId = shiftKey is String ? int.tryParse(shiftKey) : null;
        if (shiftId == null) {
          return _fadeRoute(
            settings: settings,
            child: const Scaffold(body: Center(child: Text('Invalid shift'))),
          );
        }
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminShiftDetails),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AdminShiftsPoliciesCubit>(
                create: (_) =>
                    sl<AdminShiftsPoliciesCubit>()..load(shiftId: shiftId),
              ),
              BlocProvider<AdminEmployeesCubit>(
                create: (_) => sl<AdminEmployeesCubit>()..loadEmployees(),
              ),
            ],
            child: AdminShiftDetailsScreen(shiftKey: shiftKey as String),
          ),
        );

      case AppRoutes.supervisor:
        return _fadeRoute(
          settings: const RouteSettings(name: AppRoutes.supervisor),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthSessionCubit>(
                create: (_) => sl<AuthSessionCubit>(),
              ),
              BlocProvider<AuthProfileCubit>(
                create: (_) => sl<AuthProfileCubit>()..loadProfile(),
              ),
              BlocProvider<SupervisorAttendanceCubit>(
                create: (_) =>
                    sl<SupervisorAttendanceCubit>()..loadAttendance(),
              ),
              BlocProvider<EmployeeAttendanceCubit>(
                create: (_) => sl<EmployeeAttendanceCubit>(),
              ),
              BlocProvider<LeavesCubit>(
                create: (_) => sl<LeavesCubit>()..loadLeavesData(),
              ),
              BlocProvider<SupervisorLeaveRequestsCubit>(
                create: (_) =>
                    sl<SupervisorLeaveRequestsCubit>()..loadLeaveRequests(),
              ),
              BlocProvider<SupervisorTasksCubit>(
                create: (_) => sl<SupervisorTasksCubit>()..loadTasks(),
              ),
              BlocProvider<SupervisorPlansCubit>(
                create: (_) => sl<SupervisorPlansCubit>()..loadPlans(),
              ),
              BlocProvider<SupervisorTeamCubit>(
                create: (_) => sl<SupervisorTeamCubit>()..loadTeam(),
              ),
            ],
            child: const SupervisorMainScreen(),
          ),
        );

      case AppRoutes.supervisorLeaveManagement:
        return _slideRoute(
          settings: const RouteSettings(
            name: AppRoutes.supervisorLeaveManagement,
          ),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<SupervisorLeaveRequestsCubit>(
                create: (_) =>
                    sl<SupervisorLeaveRequestsCubit>()..loadLeaveRequests(),
              ),
              BlocProvider<LeavesCubit>(create: (_) => sl<LeavesCubit>()),
            ],
            child: const SupervisorLeaveManagementScreen(),
          ),
        );

      case AppRoutes.supervisorPlans:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.supervisorPlans),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<SupervisorPlansCubit>(
                create: (_) => sl<SupervisorPlansCubit>()..loadPlans(),
              ),
              BlocProvider<SupervisorTeamCubit>(
                create: (_) => sl<SupervisorTeamCubit>()..loadTeam(),
              ),
            ],
            child: const SupervisorPlansScreen(),
          ),
        );

      case AppRoutes.supervisorNotifications:
        return _slideRoute(
          settings: const RouteSettings(
            name: AppRoutes.supervisorNotifications,
          ),
          child: BlocProvider<NotificationsCubit>(
            create: (_) => sl<NotificationsCubit>()..load(),
            child: const SupervisorNotificationsScreen(),
          ),
        );

      case AppRoutes.employee:
        return _fadeRoute(
          settings: const RouteSettings(name: AppRoutes.employee),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthSessionCubit>(
                create: (_) => sl<AuthSessionCubit>(),
              ),
              BlocProvider<AuthProfileCubit>(
                create: (_) => sl<AuthProfileCubit>()..loadProfile(),
              ),
              BlocProvider<EmployeeAttendanceCubit>(
                create: (_) =>
                    sl<EmployeeAttendanceCubit>()..loadAttendanceHistory(),
              ),
              BlocProvider<EmployeeTasksCubit>(
                create: (_) => sl<EmployeeTasksCubit>()..loadMyTasks(),
              ),
              BlocProvider<EmployeePlansCubit>(
                create: (_) => sl<EmployeePlansCubit>()..loadMyPlans(),
              ),
              BlocProvider<LeavesCubit>(
                create: (_) => sl<LeavesCubit>()..loadLeavesData(),
              ),
              BlocProvider<EmployeeLeaveRequestsCubit>(
                create: (_) =>
                    sl<EmployeeLeaveRequestsCubit>()..loadLeaveRequests(),
              ),
              BlocProvider<EmployeeOdooDashboardCubit>(
                create: (_) =>
                    sl<EmployeeOdooDashboardCubit>()..fetchDashboardData(),
              ),
            ],
            child: const EmployeeMainScreen(),
          ),
        );
      case AppRoutes.employeeSettings:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.employeeSettings),
          child: const EmployeeSettingsScreen(),
        );

      case AppRoutes.permissionsRequest:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.permissionsRequest),
          child: BlocProvider<PermitCubit>(
            create: (_) => sl<PermitCubit>(),
            child: const RequestPermissionScreen(),
          ),
        );
      case AppRoutes.leavesRequest:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.leavesRequest),
          child: BlocProvider.value(
            value: sl<LeavesCubit>(),
            child: const RequestLeaveScreen(),
          ),
        );
      default:
        return _fadeRoute(
          settings: settings,
          child: const Scaffold(body: Center(child: Text('Unknown route'))),
        );
    }
  }
}
