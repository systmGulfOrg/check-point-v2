# Check Point project context

- Flutter/Dart app: package `check_point_v2`, Dart SDK `^3.10.4`.
- Features: `auth`, `admin`, `employee`, and `supervisor`, organized feature-first under `lib/features/`.
- Core concerns live under `lib/core/`: DI, auth/session, networking, routes, styles, theme, services, utilities, and widgets.
- Main packages include `flutter_bloc`, Freezed, Retrofit/Dio, GetIt, Easy Localization, ScreenUtil Plus, secure storage, biometrics, maps, geolocation, and Envied.
- Routes are centralized in `lib/core/routes/`; dependencies are registered in `lib/core/di/service_locator.dart`.
- Translations are in `assets/translations/`; current files include Arabic and English variants.
- Existing worktree changes must be preserved. `AGENTS.md` overrides this summary if they differ.
