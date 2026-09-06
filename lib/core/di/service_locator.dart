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
import '../app/app_config.dart';
import '../auth/auth_session_storage.dart';
import '../auth/biometric_auth_service.dart';
import '../network/auth_token_interceptor.dart';
import '../network/device_identity_provider.dart';

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
          requestBody: false,
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

  // API Services
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl<Dio>()));
  sl.registerLazySingleton<AdminApiService>(() => AdminApiService(sl<Dio>()));

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
}
