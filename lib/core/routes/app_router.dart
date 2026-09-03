import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/admin/presentation/screens/admin_main_screen.dart';
import '../../features/admin/presentation/screens/admin_request_details_screen.dart';
import '../../features/admin/presentation/screens/admin_create_employee_screen.dart';
import '../../features/admin/presentation/screens/admin_locations_screen.dart';
import '../../features/admin/presentation/screens/admin_shifts_policies_screen.dart';
import '../../features/admin/presentation/screens/admin_permissions_screen.dart';
import '../../features/admin/presentation/screens/admin_permission_details_screen.dart';
import '../../features/admin/presentation/screens/admin_leave_management_screen.dart';
import '../../features/admin/presentation/screens/admin_tasks_screen.dart';
import '../../features/admin/presentation/screens/admin_plans_screen.dart';
import '../../features/admin/presentation/screens/admin_attendance_screen.dart';
import '../../features/admin/presentation/screens/admin_shift_details_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/request_access_screen.dart';
import '../di/service_locator.dart';
import '../../features/auth/presentation/cubit/login_cubit.dart';
import '../../features/auth/presentation/cubit/auth_session_cubit.dart';
import '../../features/auth/presentation/cubit/request_account_cubit.dart';
import '../../features/admin/presentation/cubit/admin_employees_cubit.dart';
import '../../features/admin/presentation/cubit/admin_account_requests_cubit.dart';
import '../../features/admin/presentation/cubit/admin_branches_cubit.dart';
import '../../features/admin/presentation/cubit/admin_departments_cubit.dart';
import '../../features/employee/presentation/screens/employee_main_screen.dart';
import '../../features/employee/presentation/screens/employee_settings_screen.dart';
import '../../features/supervisor/presentation/screens/supervisor_main_screen.dart';
import '../../features/supervisor/presentation/screens/supervisor_leave_management_screen.dart';
import '../../features/supervisor/presentation/screens/supervisor_plans_screen.dart';
import '../../features/supervisor/presentation/screens/supervisor_notifications_screen.dart';
import 'routes.dart';

class AppRouter {
  const AppRouter._();

  static Route<void> _fadeRoute({
    required Widget child,
    required RouteSettings settings,
  }) => PageRouteBuilder<void>(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, pageChild) =>
        FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: pageChild,
        ),
  );

  static Route<void> _slideRoute({
    required Widget child,
    required RouteSettings settings,
  }) => PageRouteBuilder<void>(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 320),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, pageChild) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.05, 0),
            end: Offset.zero,
          ).animate(curved),
          child: pageChild,
        ),
      );
    },
  );

  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
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
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminRequestDetails),
          child: const AdminRequestDetailsScreen(),
        );

      case AppRoutes.adminCreateEmployee:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminCreateEmployee),
          child: const AdminCreateEmployeeScreen(),
        );

      case AppRoutes.admin:
        return _fadeRoute(
          settings: const RouteSettings(name: AppRoutes.admin),
          child: BlocProvider<AuthSessionCubit>(
            create: (_) => sl<AuthSessionCubit>(),
            child: BlocProvider<AdminEmployeesCubit>(
              create: (_) => sl<AdminEmployeesCubit>()..loadEmployees(),
              child: BlocProvider<AdminAccountRequestsCubit>(
                create: (_) => sl<AdminAccountRequestsCubit>()..loadRequests(),
                child: const AdminMainScreen(),
              ),
            ),
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
            ],
            child: const AdminLocationsScreen(),
          ),
        );

      case AppRoutes.adminShiftsPolicies:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminShiftsPolicies),
          child: const AdminShiftsPoliciesScreen(),
        );

      case AppRoutes.adminPermissions:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminPermissions),
          child: const AdminPermissionsScreen(),
        );

      case AppRoutes.adminPermissionDetails:
        final supervisorKey = settings.arguments;
        if (supervisorKey is! String) {
          return _fadeRoute(
            settings: settings,
            child: const Scaffold(
              body: Center(child: Text('Invalid supervisor')),
            ),
          );
        }
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminPermissionDetails),
          child: AdminPermissionDetailsScreen(supervisorKey: supervisorKey),
        );

      case AppRoutes.adminLeaveManagement:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminLeaveManagement),
          child: const AdminLeaveManagementScreen(),
        );

      case AppRoutes.adminTasks:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminTasks),
          child: const AdminTasksScreen(),
        );

      case AppRoutes.adminPlans:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminPlans),
          child: const AdminPlansScreen(),
        );

      case AppRoutes.adminAttendance:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminAttendance),
          child: const AdminAttendanceScreen(),
        );

      case AppRoutes.adminShiftDetails:
        final shiftKey = settings.arguments;
        if (shiftKey is! String) {
          return _fadeRoute(
            settings: settings,
            child: const Scaffold(body: Center(child: Text('Invalid shift'))),
          );
        }
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.adminShiftDetails),
          child: AdminShiftDetailsScreen(shiftKey: shiftKey),
        );

      case AppRoutes.supervisor:
        return _fadeRoute(
          settings: const RouteSettings(name: AppRoutes.supervisor),
          child: BlocProvider<AuthSessionCubit>(
            create: (_) => sl<AuthSessionCubit>(),
            child: const SupervisorMainScreen(),
          ),
        );

      case AppRoutes.supervisorLeaveManagement:
        return _slideRoute(
          settings: const RouteSettings(
            name: AppRoutes.supervisorLeaveManagement,
          ),
          child: const SupervisorLeaveManagementScreen(),
        );

      case AppRoutes.supervisorPlans:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.supervisorPlans),
          child: const SupervisorPlansScreen(),
        );

      case AppRoutes.supervisorNotifications:
        return _slideRoute(
          settings: const RouteSettings(
            name: AppRoutes.supervisorNotifications,
          ),
          child: const SupervisorNotificationsScreen(),
        );

      case AppRoutes.employee:
        return _fadeRoute(
          settings: const RouteSettings(name: AppRoutes.employee),
          child: BlocProvider<AuthSessionCubit>(
            create: (_) => sl<AuthSessionCubit>(),
            child: const EmployeeMainScreen(),
          ),
        );

      case AppRoutes.employeeSettings:
        return _slideRoute(
          settings: const RouteSettings(name: AppRoutes.employeeSettings),
          child: const EmployeeSettingsScreen(),
        );

      default:
        return _fadeRoute(
          settings: settings,
          child: const Scaffold(body: Center(child: Text('Unknown route'))),
        );
    }
  }
}
