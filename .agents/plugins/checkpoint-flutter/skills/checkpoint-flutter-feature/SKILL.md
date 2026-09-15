---
name: checkpoint-flutter-feature
description: >-
  Use this skill when the user asks to create or scaffold a new Flutter feature, screen, Cubit, or Repository in the Checkpoint project.
---

# Checkpoint Flutter Feature Generation

This skill guides you in creating a new feature in the Checkpoint project according to the strict architectural guidelines.

## Steps

1. **Identify the Layers Needed**: 
   - Simple feature: `presentation/` and `data/`.
   - Complex feature (multi-step, heavy business logic): add `domain/` (UseCases, Repo Contracts).
   - NEVER create entities (`*_entity.dart`). Use `*_model.dart` directly from the data layer.

2. **Generate Presentation Layer**:
   - `cubit/`: Create `{feature}_cubit.dart` and `{feature}_state.dart` (using `@freezed`).
   - `screens/`: Create main screen widget. Extract large widgets to `widgets/`.
   - Use `flutter_screenutil_plus` for sizing (e.g., `16.w`, `24.h`).
   - Use `AppColors`, `AppTextStyles`, `AppAssets` for styling. DO NOT hardcode colors/styles/assets.
   - Use `key.tr()` for localization (DO NOT hardcode user-facing strings).
   - In UI, use Dart 3 switch expressions for state exhaustive matching.

3. **Generate Data Layer**:
   - `models/`: Create DTOs using `@freezed` and `@JsonSerializable()`.
   - `apis/`: Create Retrofit API service (`{feature}_api_service.dart`).
   - `repos/`: Create `{feature}_repo_impl.dart` which returns `ApiResult<T>` and maps exceptions using `ApiFailureMapper`.

4. **Generate Domain Layer (If Needed)**:
   - `repos/`: Abstract interface `{feature}_repo.dart`.
   - `use_cases/`: `{feature}_use_case.dart` returning `ApiResult<T>`.

5. **Dependency Injection**:
   - Register dependencies in `lib/core/di/service_locator.dart` (GetIt).
   - Order: Dio -> ApiService -> Repo -> UseCase -> Cubit.
   - Use named parameters `({required this.dep})` and public fields for injections.

6. **Routing**:
   - Add static const route name in `lib/core/routing/app_routes.dart`.
   - Add route handling in `lib/core/routing/app_router.dart` inside the `switch` statement. Wrap with `BlocProvider` and use `sl<FeatureCubit>()`.

7. **Code Generation**:
   - Once `@freezed` or `@RestApi` models/services are created, trigger the `checkpoint-build-runner` skill.

8. **Standard Core Widgets**:
   - For all dialogs (alerts, confirmations, success, errors), **MUST USE `CustomDialogWidget`** from `lib/core/widgets/custom_dialog_widget.dart`. Do NOT use the default Flutter `AlertDialog` or raw `Dialog`.
   - Use `CustomButton` for primary/secondary buttons.
