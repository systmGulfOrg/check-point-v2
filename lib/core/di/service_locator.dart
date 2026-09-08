import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

import 'package:check_point_v2/core/services/attendance_verification_service.dart';

import 'package:check_point_v2/features/admin/data/apis/admin_api_service.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_attendance_repo.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_attendance_repo_impl.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo_impl.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_leave_requests_repo.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_leave_requests_repo_impl.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_locations_repo.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_locations_repo_impl.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_plans_repo.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_plans_repo_impl.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_shifts_policies_repo.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_shifts_policies_repo_impl.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_tasks_repo.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_tasks_repo_impl.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/attendance/admin_attendance_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_customers_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_department_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/plans/admin_plans_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/tasks/admin_tasks_cubit.dart';
import 'package:check_point_v2/features/auth/data/apis/auth_api_service.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo_impl.dart';
import 'package:check_point_v2/features/auth/domain/use_cases/login_use_case.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/session/auth_session_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account/request_account_cubit.dart';
import 'package:check_point_v2/features/employee/data/apis/employee_api_service.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_action_repo.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_action_repo_impl.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo_impl.dart';
import 'package:check_point_v2/features/employee/data/services/odoo_attendance_service.dart';
import 'package:check_point_v2/features/employee/data/services/odoo_timeoff_service.dart';
import 'package:check_point_v2/features/employee/domain/use_cases/employee_check_in_use_case.dart';
import 'package:check_point_v2/features/employee/domain/use_cases/employee_check_out_use_case.dart';
import 'package:check_point_v2/features/employee/domain/use_cases/employee_leave_requests_use_case.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/password/employee_change_password_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/leave_requests/employee_leave_requests_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/odoo_dashboard/employee_odoo_dashboard_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/plans/employee_plans_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/tasks/employee_tasks_cubit.dart';

import 'package:check_point_v2/features/supervisor/data/apis/supervisor_api_service.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_attendance_repo.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_attendance_repo_impl.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_leave_requests_repo.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_leave_requests_repo_impl.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_plans_repo.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_plans_repo_impl.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_tasks_repo.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_tasks_repo_impl.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_team_repo.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_team_repo_impl.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/plans/supervisor_plans_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/tasks/supervisor_tasks_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/core/app/app_config.dart';
import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/auth/biometric_auth_service.dart';
import 'package:check_point_v2/core/network/auth_token_interceptor.dart';
import 'package:check_point_v2/core/network/device_identity_provider.dart';
import 'package:check_point_v2/core/network/safe_network_log_interceptor.dart';
import 'package:check_point_v2/core/services/google_places_service.dart';
import 'package:check_point_v2/core/services/location_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new);
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
      ..interceptors.add(
        AuthTokenInterceptor(secureStorage: sl<FlutterSecureStorage>()),
      )
      ..interceptors.add(SafeNetworkLogInterceptor()),
  );
  sl.registerLazySingleton<AuthSessionStorage>(
    () => AuthSessionStorage(secureStorage: sl<FlutterSecureStorage>()),
  );
  sl.registerLazySingleton<BiometricAuthService>(
    () => BiometricAuthService(localAuthentication: LocalAuthentication()),
  );
  sl.registerLazySingleton<DeviceIdentityProvider>(
    () => DeviceIdentityProvider(secureStorage: sl<FlutterSecureStorage>()),
  );
  await sl<DeviceIdentityProvider>().initialize();

  // Services
  // External services must never receive the app's bearer token or log keys.
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    ),
    instanceName: 'external',
  );
  sl.registerLazySingleton<LocationService>(LocationService.new);
  sl.registerLazySingleton<AttendanceVerificationService>(
    () => AttendanceVerificationService(
      locationService: sl<LocationService>(),
      biometricAuthService: sl<BiometricAuthService>(),
    ),
  );
  sl.registerLazySingleton<GooglePlacesService>(
    () => GooglePlacesService(dio: sl<Dio>(instanceName: 'external')),
  );
  sl.registerLazySingleton<OdooAttendanceService>(
    () => OdooAttendanceService(dio: sl<Dio>(instanceName: 'external')),
  );
  sl.registerLazySingleton<OdooTimeOffService>(
    () => OdooTimeOffService(dio: sl<Dio>(instanceName: 'external')),
  );

  // API Services
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl<Dio>()));
  sl.registerLazySingleton<AdminApiService>(() => AdminApiService(sl<Dio>()));
  sl.registerLazySingleton<SupervisorApiService>(
    () => SupervisorApiService(sl<Dio>()),
  );
  sl.registerLazySingleton<EmployeeApiService>(
    () => EmployeeApiService(sl<Dio>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      api: sl<AuthApiService>(),
      secureStorage: sl<FlutterSecureStorage>(),
    ),
  );
  sl.registerLazySingleton<AdminEmployeeRepo>(
    () => AdminEmployeeRepoImpl(api: sl<AdminApiService>()),
  );
  sl.registerLazySingleton<AdminLocationsRepo>(
    () => AdminLocationsRepoImpl(api: sl<AdminApiService>()),
  );
  sl.registerLazySingleton<AdminShiftsPoliciesRepo>(
    () => AdminShiftsPoliciesRepoImpl(api: sl<AdminApiService>()),
  );
  sl.registerLazySingleton<AdminLeaveRequestsRepo>(
    () => AdminLeaveRequestsRepoImpl(api: sl<AdminApiService>()),
  );
  sl.registerLazySingleton<AdminAttendanceRepo>(
    () => AdminAttendanceRepoImpl(api: sl<AdminApiService>()),
  );
  sl.registerLazySingleton<AdminTasksRepo>(
    () => AdminTasksRepoImpl(api: sl<AdminApiService>()),
  );
  sl.registerLazySingleton<AdminPlansRepo>(
    () => AdminPlansRepoImpl(api: sl<AdminApiService>()),
  );
  sl.registerLazySingleton<SupervisorAttendanceRepo>(
    () => SupervisorAttendanceRepoImpl(
      api: sl<SupervisorApiService>(),
      sessionStorage: sl<AuthSessionStorage>(),
    ),
  );
  sl.registerLazySingleton<SupervisorLeaveRequestsRepo>(
    () => SupervisorLeaveRequestsRepoImpl(
      api: sl<SupervisorApiService>(),
      sessionStorage: sl<AuthSessionStorage>(),
    ),
  );
  sl.registerLazySingleton<SupervisorTasksRepo>(
    () => SupervisorTasksRepoImpl(
      api: sl<SupervisorApiService>(),
      sessionStorage: sl<AuthSessionStorage>(),
    ),
  );
  sl.registerLazySingleton<SupervisorPlansRepo>(
    () => SupervisorPlansRepoImpl(
      api: sl<SupervisorApiService>(),
      sessionStorage: sl<AuthSessionStorage>(),
    ),
  );
  sl.registerLazySingleton<SupervisorTeamRepo>(
    () => SupervisorTeamRepoImpl(
      api: sl<SupervisorApiService>(),
      sessionStorage: sl<AuthSessionStorage>(),
    ),
  );
  sl.registerLazySingleton<EmployeeAttendanceRepo>(
    () => EmployeeAttendanceRepoImpl(
      api: sl<EmployeeApiService>(),
      odooAttendanceService: sl<OdooAttendanceService>(),
    ),
  );
  sl.registerLazySingleton<EmployeeActionRepo>(
    () => EmployeeActionRepoImpl(api: sl<EmployeeApiService>()),
  );

  // UseCases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      authRepo: sl<AuthRepo>(),
      deviceIdentityProvider: sl<DeviceIdentityProvider>(),
      authSessionStorage: sl<AuthSessionStorage>(),
      biometricAuthService: sl<BiometricAuthService>(),
    ),
  );
  sl.registerLazySingleton<EmployeeCheckInUseCase>(
    () => EmployeeCheckInUseCase(
      attendanceRepo: sl<EmployeeAttendanceRepo>(),
      sessionStorage: sl<AuthSessionStorage>(),
    ),
  );
  sl.registerLazySingleton<EmployeeCheckOutUseCase>(
    () => EmployeeCheckOutUseCase(
      attendanceRepo: sl<EmployeeAttendanceRepo>(),
      sessionStorage: sl<AuthSessionStorage>(),
    ),
  );
  sl.registerLazySingleton<EmployeeLeaveRequestsUseCase>(
    () => EmployeeLeaveRequestsUseCase(
      actionRepo: sl<EmployeeActionRepo>(),
      odooTimeOffService: sl<OdooTimeOffService>(),
      sessionStorage: sl<AuthSessionStorage>(),
    ),
  );

  // Cubits
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      loginUseCase: sl<LoginUseCase>(),
      authSessionStorage: sl<AuthSessionStorage>(),
      biometricAuthService: sl<BiometricAuthService>(),
    ),
  );
  sl.registerFactory<AuthSessionCubit>(
    () => AuthSessionCubit(authSessionStorage: sl<AuthSessionStorage>()),
  );
  sl.registerFactory<RequestAccountCubit>(
    () => RequestAccountCubit(
      authRepo: sl<AuthRepo>(),
      deviceIdentityProvider: sl<DeviceIdentityProvider>(),
    ),
  );
  sl.registerFactory<AdminEmployeesCubit>(
    () => AdminEmployeesCubit(employeeRepo: sl<AdminEmployeeRepo>()),
  );
  sl.registerFactory<AdminAccountRequestsCubit>(
    () => AdminAccountRequestsCubit(employeeRepo: sl<AdminEmployeeRepo>()),
  );
  sl.registerFactory<AdminBranchesCubit>(
    () => AdminBranchesCubit(locationsRepo: sl<AdminLocationsRepo>()),
  );
  sl.registerFactory<AdminDepartmentsCubit>(
    () => AdminDepartmentsCubit(locationsRepo: sl<AdminLocationsRepo>()),
  );
  sl.registerFactory<AdminDepartmentEmployeesCubit>(
    () => AdminDepartmentEmployeesCubit(employeeRepo: sl<AdminEmployeeRepo>()),
  );
  sl.registerFactory<AdminCustomersCubit>(
    () => AdminCustomersCubit(locationsRepo: sl<AdminLocationsRepo>()),
  );
  sl.registerFactory<AdminShiftsPoliciesCubit>(
    () => AdminShiftsPoliciesCubit(
      shiftsPoliciesRepo: sl<AdminShiftsPoliciesRepo>(),
    ),
  );
  sl.registerFactory<AdminLeaveRequestsCubit>(
    () => AdminLeaveRequestsCubit(
      leaveRequestsRepo: sl<AdminLeaveRequestsRepo>(),
    ),
  );
  sl.registerFactory<AdminAttendanceCubit>(
    () => AdminAttendanceCubit(attendanceRepo: sl<AdminAttendanceRepo>()),
  );
  sl.registerFactory<AdminTasksCubit>(
    () => AdminTasksCubit(tasksRepo: sl<AdminTasksRepo>()),
  );
  sl.registerFactory<AdminPlansCubit>(
    () => AdminPlansCubit(plansRepo: sl<AdminPlansRepo>()),
  );
  sl.registerFactory<SupervisorAttendanceCubit>(
    () => SupervisorAttendanceCubit(
      attendanceRepo: sl<SupervisorAttendanceRepo>(),
      attendanceVerificationService: sl<AttendanceVerificationService>(),
    ),
  );
  sl.registerFactory<SupervisorLeaveRequestsCubit>(
    () => SupervisorLeaveRequestsCubit(
      leaveRequestsRepo: sl<SupervisorLeaveRequestsRepo>(),
    ),
  );
  sl.registerFactory<SupervisorTasksCubit>(
    () => SupervisorTasksCubit(tasksRepo: sl<SupervisorTasksRepo>()),
  );
  sl.registerFactory<SupervisorPlansCubit>(
    () => SupervisorPlansCubit(plansRepo: sl<SupervisorPlansRepo>()),
  );
  sl.registerFactory<SupervisorTeamCubit>(
    () => SupervisorTeamCubit(teamRepo: sl<SupervisorTeamRepo>()),
  );
  sl.registerFactory<EmployeeAttendanceCubit>(
    () => EmployeeAttendanceCubit(
      attendanceRepo: sl<EmployeeAttendanceRepo>(),
      sessionStorage: sl<AuthSessionStorage>(),
      checkInUseCase: sl<EmployeeCheckInUseCase>(),
      checkOutUseCase: sl<EmployeeCheckOutUseCase>(),
      attendanceVerificationService: sl<AttendanceVerificationService>(),
    ),
  );
  sl.registerFactory<EmployeeTasksCubit>(
    () => EmployeeTasksCubit(
      actionRepo: sl<EmployeeActionRepo>(),
      sessionStorage: sl<AuthSessionStorage>(),
    ),
  );
  sl.registerFactory<EmployeePlansCubit>(
    () => EmployeePlansCubit(
      attendanceRepo: sl<EmployeeAttendanceRepo>(),
      sessionStorage: sl<AuthSessionStorage>(),
    ),
  );
  sl.registerFactory<EmployeeLeaveRequestsCubit>(
    () => EmployeeLeaveRequestsCubit(
      actionRepo: sl<EmployeeActionRepo>(),
      odooTimeOffService: sl<OdooTimeOffService>(),
      leaveRequestsUseCase: sl<EmployeeLeaveRequestsUseCase>(),
    ),
  );
  sl.registerFactory<EmployeeChangePasswordCubit>(
    () => EmployeeChangePasswordCubit(
      actionRepo: sl<EmployeeActionRepo>(),
      sessionStorage: sl<AuthSessionStorage>(),
    ),
  );
  sl.registerFactory<EmployeeOdooDashboardCubit>(
    () => EmployeeOdooDashboardCubit(
      odooTimeOffService: sl<OdooTimeOffService>(),
      sessionStorage: sl<AuthSessionStorage>(),
    ),
  );
}
