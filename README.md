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
  --dart-define=ENV=dev
```

Do not commit API keys, tokens, credentials, or environment files. Use `--dart-define` for environment-specific values.

## Implementation Status

The account request and admin creation flows currently use representative UI data and local interaction states for design validation. API integration, persistence, authentication, device registration, and notification delivery should be connected through the existing data and domain layers before production release.

## Brand

**CHECK-POINT HRM**

Powered by **SYSTM GULF**
