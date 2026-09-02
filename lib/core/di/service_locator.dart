import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/apis/auth_api_service.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/auth/domain/use_cases/login_use_case.dart';
import '../../features/auth/domain/use_cases/request_account_use_case.dart';
import '../../features/auth/presentation/cubit/login_cubit.dart';
import '../../features/auth/presentation/cubit/request_account_cubit.dart';
import '../app/app_config.dart';
import '../network/device_identity_provider.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: AppConfig.baseUrl)),
  );
  sl.registerLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new);
  sl.registerLazySingleton<DeviceIdentityProvider>(DeviceIdentityProvider.new);
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl<Dio>()));
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      api: sl<AuthApiService>(),
      secureStorage: sl<FlutterSecureStorage>(),
    ),
  );
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(authRepo: sl<AuthRepo>()),
  );
  sl.registerLazySingleton<RequestAccountUseCase>(
    () => RequestAccountUseCase(authRepo: sl<AuthRepo>()),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(loginUseCase: sl<LoginUseCase>()),
  );
  sl.registerFactory<RequestAccountCubit>(
    () =>
        RequestAccountCubit(requestAccountUseCase: sl<RequestAccountUseCase>()),
  );
}
