# Security context

- Tokens and auth session values use `lib/core/auth/auth_session_storage.dart` and `FlutterSecureStorage`.
- `AuthTokenInterceptor` reads the bearer token for app API requests.
- `SafeNetworkLogInterceptor` logs method/status/timing and summarizes response shapes without logging full bodies.
- External service Dio is registered separately in DI and must not receive the app bearer token.
- Environment configuration is handled through `AppConfig`/Envied and `.env.example`; secrets must not enter source control.
- Security-sensitive changes should inspect 401/403 handling, logout/session clearing, device identity, biometric data, and log redaction together.
