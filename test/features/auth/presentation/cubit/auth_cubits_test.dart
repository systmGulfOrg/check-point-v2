import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/network/device_identity_provider.dart';
import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/auth/biometric_auth_service.dart';
import 'package:check_point_v2/features/auth/data/models/account_request/account_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_response_model.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo.dart';
import 'package:check_point_v2/features/auth/domain/use_cases/login_use_case.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_state.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account/request_account_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account/request_account_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class _FakeDeviceIdentityProvider extends DeviceIdentityProvider {
  _FakeDeviceIdentityProvider({
    required this.fakeMobileId,
    required this.fakeDeviceToken,
  });

  final String fakeMobileId;
  final String fakeDeviceToken;

  @override
  String get mobileId => fakeMobileId;

  @override
  String get deviceToken => fakeDeviceToken;
}

class _FakeAuthRepo implements AuthRepo {
  _FakeAuthRepo({required this.loginResponse});

  final LoginResponseModel loginResponse;
  final loginRequests = <LoginRequestModel>[];
  final accountRequests = <AccountRequestModel>[];

  @override
  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request) async {
    loginRequests.add(request);
    return ApiResult.success(loginResponse);
  }

  @override
  Future<ApiResult<void>> requestAccount(AccountRequestModel request) async {
    accountRequests.add(request);
    return const ApiResult.success(null);
  }
}

class _FakeAuthSessionStorage extends AuthSessionStorage {
  _FakeAuthSessionStorage()
    : super(secureStorage: const FlutterSecureStorage());

  @override
  Future<void> disableBiometricLogin() async {}

  @override
  Future<void> saveUserSession({
    required String token,
    String? userId,
    int? departmentId,
    int? branchId,
    String? userName,
    String? role,
  }) async {}
}

class _FakeBiometricAuthService extends BiometricAuthService {
  _FakeBiometricAuthService()
    : super(localAuthentication: LocalAuthentication());

  @override
  Future<bool> isAvailable() async => false;
}

void main() {
  group('LoginCubit', () {
    test('builds the login request with device identity from DI', () async {
      final loginResponse = const LoginResponseModel(
        id: '1',
        userName: 'ahmed',
        name: 'Ahmed Mohamed',
        roles: ['Admin'],
        token: 'token-123',
      );
      final repo = _FakeAuthRepo(loginResponse: loginResponse);
      final deviceIdentityProvider = _FakeDeviceIdentityProvider(
        fakeMobileId: 'mobile-123',
        fakeDeviceToken: 'token-abc',
      );
      final sessionStorage = _FakeAuthSessionStorage();
      final biometricAuthService = _FakeBiometricAuthService();

      final loginUseCase = LoginUseCase(
        authRepo: repo,
        deviceIdentityProvider: deviceIdentityProvider,
        authSessionStorage: sessionStorage,
        biometricAuthService: biometricAuthService,
      );

      final cubit = LoginCubit(
        loginUseCase: loginUseCase,
        authSessionStorage: sessionStorage,
        biometricAuthService: biometricAuthService,
      );
      addTearDown(cubit.close);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const LoginState.loading(),
          LoginState.success(loginResponse),
        ]),
      );

      await cubit.login(
        userName: 'ahmed',
        password: 'secret',
        role: 'Admin',
        enableBiometricLogin: false,
      );

      expect(repo.loginRequests, hasLength(1));
      expect(repo.loginRequests.single.userName, 'ahmed');
      expect(repo.loginRequests.single.password, 'secret');
      expect(repo.loginRequests.single.mobileId, 'mobile-123');
    });

    test(
      'emits role mismatch when the selected role is not assigned',
      () async {
        final loginResponse = const LoginResponseModel(
          id: '1',
          userName: 'ahmed',
          roles: ['Employee'],
          token: 'token-123',
        );
        final repo = _FakeAuthRepo(loginResponse: loginResponse);
        final deviceIdentityProvider = _FakeDeviceIdentityProvider(
          fakeMobileId: 'mobile-123',
          fakeDeviceToken: 'token-abc',
        );
        final sessionStorage = _FakeAuthSessionStorage();
        final biometricAuthService = _FakeBiometricAuthService();

        final loginUseCase = LoginUseCase(
          authRepo: repo,
          deviceIdentityProvider: deviceIdentityProvider,
          authSessionStorage: sessionStorage,
          biometricAuthService: biometricAuthService,
        );

        final cubit = LoginCubit(
          loginUseCase: loginUseCase,
          authSessionStorage: sessionStorage,
          biometricAuthService: biometricAuthService,
        );
        addTearDown(cubit.close);

        expectLater(
          cubit.stream,
          emitsInOrder([
            const LoginState.loading(),
            const LoginState.error('errors.roleMismatch'),
          ]),
        );

        await cubit.login(
          userName: 'ahmed',
          password: 'secret',
          role: 'Admin',
          enableBiometricLogin: false,
        );
      },
    );
  });

  group('RequestAccountCubit', () {
    test('builds the account request with device identity from DI', () async {
      final repo = _FakeAuthRepo(
        loginResponse: const LoginResponseModel(
          id: '1',
          userName: 'ahmed',
          name: 'Ahmed Mohamed',
          token: 'token-123',
        ),
      );
      final cubit = RequestAccountCubit(
        authRepo: repo,
        deviceIdentityProvider: _FakeDeviceIdentityProvider(
          fakeMobileId: 'mobile-456',
          fakeDeviceToken: 'device-token-456',
        ),
      );
      addTearDown(cubit.close);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const RequestAccountState.loading(),
          const RequestAccountState.success(),
        ]),
      );

      await cubit.submit(name: 'Ahmed Mohamed');

      expect(repo.accountRequests, hasLength(1));
      expect(repo.accountRequests.single.name, 'Ahmed Mohamed');
      expect(repo.accountRequests.single.mobileId, 'mobile-456');
      expect(repo.accountRequests.single.deviceToken, 'device-token-456');
    });
  });
}
