import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'check_point_app.dart';
import 'core/auth/auth_session_storage.dart';
import 'core/di/service_locator.dart';
import 'core/network/auth_token_interceptor.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';
import 'core/services/local_notification_service.dart';
import 'core/services/push_notification_service.dart';
import 'core/widgets/custom_snack_bar.dart';
import 'features/auth/data/repos/auth_repo.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Firebase must be ready before the background handler is registered and
  // before anything resolves FirebaseMessaging from the service locator.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

  await setupServiceLocator();
  await sl<LocalNotificationService>().initialize();
  await sl<PushNotificationService>().initialize();

  // The backend's shared tenant-access gate runs on every authenticated
  // request, not just login, so a company can go from usable to blocked
  // mid-session. The interceptor has no BuildContext of its own, so it
  // reports the error code here and this does the session reset + redirect.
  AuthTokenInterceptor.onTenantBlocked = (errorCode) {
    unawaited(sl<AuthSessionStorage>().clearTenant());
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;
    CustomSnackBar.showError(
      context,
      message: _tenantBlockedMessageKey(errorCode).tr(context: context),
      duration: const Duration(seconds: 5),
    );
    AppRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.companyCode,
      (route) => false,
    );
  };

  final resolved = await _resolveInitialRoute();
  pendingStartupMessageKey = resolved.messageKey;

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar'), Locale('ar', 'EG')],
      path: 'assets/translations',
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      child: CheckPointApp(initialRoute: resolved.route),
    ),
  );
}

/// Set when [_resolveInitialRoute] bounces the user back to the company-code
/// screen on cold start (a saved tenant turned out blocked). That screen
/// reads and clears it on its first frame — `main()` runs before any
/// Navigator/Overlay exists, so there is no BuildContext here to show a
/// snackbar with.
String? pendingStartupMessageKey;

/// A saved tenant slug only means this device signed in here before — the
/// company could have been suspended, expired, or deleted since. Re-verify
/// it before ever letting a cold start skip the company-code screen, instead
/// of trusting the cached slug blindly.
Future<({String route, String? messageKey})> _resolveInitialRoute() async {
  final sessionStorage = sl<AuthSessionStorage>();
  final savedTenantSlug = await sessionStorage.readTenantSlug();
  if (savedTenantSlug == null || savedTenantSlug.isEmpty) {
    return (route: AppRoutes.companyCode, messageKey: null);
  }

  final result = await sl<AuthRepo>().verifyTenant(savedTenantSlug);
  // A network/server hiccup is not proof the company is gone — fail open to
  // the login screen rather than force a re-entry of the company code every
  // time the device launches offline. A real rejection (suspended, expired,
  // ...) always comes back as one of the errors.tenant* keys.
  final rejectionMessageKey = result.when(
    success: (_) => null,
    failure: (f) => f.messageKey.startsWith('errors.tenant') ? f.messageKey : null,
  );
  if (rejectionMessageKey != null) {
    await sessionStorage.clearTenant();
    return (route: AppRoutes.companyCode, messageKey: rejectionMessageKey);
  }
  return (route: AppRoutes.login, messageKey: null);
}

String _tenantBlockedMessageKey(String errorCode) => switch (errorCode) {
  'TENANT_SUSPENDED' => 'errors.tenantSuspended',
  'TENANT_EXPIRED' => 'errors.tenantExpired',
  'TENANT_ARCHIVED' => 'errors.tenantArchived',
  'TENANT_PENDING_DELETION' => 'errors.tenantPendingDeletion',
  'TENANT_TRIAL_EXPIRED' => 'errors.tenantTrialExpired',
  _ => 'errors.tenantNotFound',
};
