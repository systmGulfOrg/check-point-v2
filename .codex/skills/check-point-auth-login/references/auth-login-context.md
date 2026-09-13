# Auth and login context

- Auth API: `lib/features/auth/data/apis/auth_api_service.dart`.
- Auth models include login request/response models under `data/models/login/`.
- Auth repository contract and implementation currently live in `lib/features/auth/data/repos/` (legacy project convention).
- Login orchestration is in `lib/features/auth/domain/use_cases/login_use_case.dart`.
- Login state/Cubit live under `presentation/cubit/login/`.
- `AuthSessionStorage` uses `FlutterSecureStorage`; `DeviceIdentityProvider` supplies the mobile identity; `BiometricAuthService` handles local authentication.
- Login validates the selected role, persists session data, and optionally stores biometric login data.
- Existing auth tests are in `test/features/auth/presentation/cubit/auth_cubits_test.dart`.
