import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../features/admin/data/apis/admin_api_service.dart';
import '../../features/admin/data/repos/admin_attendance_repo.dart';
import '../../features/admin/data/repos/admin_attendance_repo_impl.dart';
import '../../features/admin/data/repos/admin_employee_repo.dart';
import '../../features/admin/data/repos/admin_employee_repo_impl.dart';
import '../../features/admin/data/repos/admin_leave_requests_repo.dart';
import '../../features/admin/data/repos/admin_leave_requests_repo_impl.dart';
import '../../features/admin/data/repos/admin_locations_repo.dart';
import '../../features/admin/data/repos/admin_locations_repo_impl.dart';
import '../../features/admin/data/repos/admin_plans_repo.dart';
import '../../features/admin/data/repos/admin_plans_repo_impl.dart';
import '../../features/admin/data/repos/admin_shifts_policies_repo.dart';
import '../../features/admin/data/repos/admin_shifts_policies_repo_impl.dart';
import '../../features/admin/data/repos/admin_tasks_repo.dart';
import '../../features/admin/data/repos/admin_tasks_repo_impl.dart';
import '../../features/admin/presentation/cubit/admin_account_requests_cubit.dart';
import '../../features/admin/presentation/cubit/admin_attendance_cubit.dart';
import '../../features/admin/presentation/cubit/admin_branches_cubit.dart';
import '../../features/admin/presentation/cubit/admin_customers_cubit.dart';
import '../../features/admin/presentation/cubit/admin_department_employees_cubit.dart';
import '../../features/admin/presentation/cubit/admin_departments_cubit.dart';
import '../../features/admin/presentation/cubit/admin_employees_cubit.dart';
import '../../features/admin/presentation/cubit/admin_leave_requests_cubit.dart';
import '../../features/admin/presentation/cubit/admin_plans_cubit.dart';
import '../../features/admin/presentation/cubit/admin_shifts_policies_cubit.dart';
import '../../features/admin/presentation/cubit/admin_tasks_cubit.dart';
import '../../features/auth/data/apis/auth_api_service.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/presentation/cubit/auth_session_cubit.dart';
import '../../features/auth/presentation/cubit/login_cubit.dart';
import '../../features/auth/presentation/cubit/request_account_cubit.dart';
import '../../features/employee/data/apis/employee_api_service.dart';
import '../../features/employee/data/repos/employee_action_repo.dart';
import '../../features/employee/data/repos/employee_action_repo_impl.dart';
import '../../features/employee/data/repos/employee_attendance_repo.dart';
import '../../features/employee/data/repos/employee_attendance_repo_impl.dart';
import '../../features/employee/data/services/odoo_attendance_service.dart';
import '../../features/employee/data/services/odoo_timeoff_service.dart';
import '../../features/employee/presentation/cubit/employee_attendance_cubit.dart';
import '../../features/employee/presentation/cubit/employee_change_password_cubit.dart';
import '../../features/employee/presentation/cubit/employee_leave_requests_cubit.dart';
import '../../features/employee/presentation/cubit/employee_odoo_dashboard_cubit.dart';
import '../../features/employee/presentation/cubit/employee_plans_cubit.dart';
import '../../features/employee/presentation/cubit/employee_tasks_cubit.dart';

import '../../features/supervisor/data/apis/supervisor_api_service.dart';
import '../../features/supervisor/data/repos/supervisor_attendance_repo.dart';
import '../../features/supervisor/data/repos/supervisor_attendance_repo_impl.dart';
import '../../features/supervisor/data/repos/supervisor_leave_requests_repo.dart';
import '../../features/supervisor/data/repos/supervisor_leave_requests_repo_impl.dart';
import '../../features/supervisor/data/repos/supervisor_plans_repo.dart';
import '../../features/supervisor/data/repos/supervisor_plans_repo_impl.dart';
import '../../features/supervisor/data/repos/supervisor_tasks_repo.dart';
import '../../features/supervisor/data/repos/supervisor_tasks_repo_impl.dart';
import '../../features/supervisor/data/repos/supervisor_team_repo.dart';
import '../../features/supervisor/data/repos/supervisor_team_repo_impl.dart';
import '../../features/supervisor/presentation/cubit/supervisor_attendance_cubit.dart';
import '../../features/supervisor/presentation/cubit/supervisor_leave_requests_cubit.dart';
import '../../features/supervisor/presentation/cubit/supervisor_plans_cubit.dart';
import '../../features/supervisor/presentation/cubit/supervisor_tasks_cubit.dart';
import '../../features/supervisor/presentation/cubit/supervisor_team_cubit.dart';
import '../app/app_config.dart';
import '../auth/auth_session_storage.dart';
import '../auth/biometric_auth_service.dart';
import '../network/auth_token_interceptor.dart';
import '../network/device_identity_provider.dart';
import '../services/google_places_service.dart';
import '../services/location_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new);
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
      ..interceptors.add(
        AuthTokenInterceptor(secureStorage: sl<FlutterSecureStorage>()),
      )
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
          enabled: kDebugMode,
        ),
      ),
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
  sl.registerLazySingleton<LocationService>(LocationService.new);
  sl.registerLazySingleton<GooglePlacesService>(
    () => GooglePlacesService(dio: sl<Dio>()),
  );
  sl.registerLazySingleton<OdooAttendanceService>(OdooAttendanceService.new);
  sl.registerLazySingleton<OdooTimeOffService>(OdooTimeOffService.new);

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

  // Cubits
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      authRepo: sl<AuthRepo>(),
      deviceIdentityProvider: sl<DeviceIdentityProvider>(),
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
      sessionStorage: sl<AuthSessionStorage>(),
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
