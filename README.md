# CHECK-POINT HRM

CHECK-POINT HRM is a modern Flutter human resources, attendance, and employee management application by **SYSTM GULF**.

The current build focuses on the employee account-request journey and the administrator workflow for reviewing requests and creating employee accounts. The interface is Arabic RTL-first, with English localization and responsive layouts for mobile, tablet, and desktop.

## Current Features

- Employee account request screen with full-name validation.
- Loading, success, and error states for account requests.
- Administrator registration request list with search, status filters, and date sorting.
- Registration request details with device information.
- Four-step employee creation wizard:
  - Personal information
  - Employment information
  - Organization and attendance settings
  - Review and confirmation
- Attendance permissions for office, site, and customer locations.
- Registered device lock and reset action.
- Employee account creation success state with activation notification copy.
- Responsive admin navigation with a desktop sidebar and mobile bottom navigation.
- Shared white card decoration, orange brand buttons, and CHECK-POINT branding.

## API Integration

Authentication is implemented against the supplied `check_point_api.json` OpenAPI specification:

- `POST /api/Auth/Login` sends `userName`, `password`, and the automatic `mobileId`.
- `POST /api/AccountRequest` sends the employee `name`, automatic `mobileId`, and automatic `deviceToken`.

The implementation follows the project layering rules:

- Retrofit service in `features/auth/data/apis/`
- `json_serializable` request and response models in `features/auth/data/models/`
- Repository contract and implementation in `data/repos/` for this simple flow
- Domain UseCases are introduced only when the feature needs business orchestration
- Freezed Cubits and states in `presentation/cubit/`
- Access tokens stored with `flutter_secure_storage`

## Screens and Routes

| Screen | Route |
| --- | --- |
| Login | `/login` |
| Employee account request | `/request-access` |
| Admin dashboard | `/admin` |
| Registration request details | `/admin/requests/details` |
| Create employee account | `/admin/employees/create` |

Additional admin, supervisor, and employee routes are defined in `lib/core/routes/routes.dart`.

## Tech Stack

- Flutter and Dart 3.10+
- `flutter_bloc` for state management
- `easy_localization` for Arabic, Arabic (Egypt), and English
- `flutter_screenutil_plus` for responsive sizing
- `get_it` for dependency injection
- Freezed annotations for typed immutable state models
- Material 3 with centralized colors, typography, decorations, and theme tokens

## Getting Started

### Requirements

- Flutter SDK compatible with Dart `^3.10.4`
- Android Studio or Xcode for mobile development
- A configured Flutter desktop target if running on desktop

### Install dependencies

```bash
flutter pub get
```

### Run the application

```bash
flutter run
```

To run on a specific device:

```bash
flutter devices
flutter run -d <device-id>
```

### Run quality checks

```bash
flutter analyze
flutter test
```

## Localization

Translations are stored in:

- `assets/translations/ar.json`
- `assets/translations/ar-EG.json`
- `assets/translations/en.json`

The application uses Arabic RTL layouts when an Arabic locale is selected and falls back to English for missing keys.

## Project Structure

```text
lib/
  app/                 Application configuration
  core/                Theme, routes, shared widgets, styles, and DI
  features/
    auth/              Login and employee account request screens
    admin/             Admin dashboard and employee management flows
    supervisor/        Supervisor experience
    employee/          Employee experience
assets/
  images/              CHECK-POINT brand assets
  translations/        Localization files
test/                  Automated tests
```

## Configuration

Build-time configuration is read from Dart defines:

```bash
flutter run \
  --dart-define=BASE_URL=https://api.example.com \
  --dart-define=ENV=dev \
  --dart-define=MOBILE_ID=desktop-device \
  --dart-define=DEVICE_TOKEN=desktop-device-token
```

Do not commit API keys, tokens, credentials, or environment files. Use `--dart-define` for environment-specific values.

## Implementation Status

The login and employee account-request flows are API-connected. The admin registration and employee-creation screens still use representative UI data until their corresponding management endpoints are integrated. Device identifiers on desktop default to safe development values and should be provided through Dart defines or a platform device provider for production.

## Brand

**CHECK-POINT HRM**

Powered by **SYSTM GULF**
