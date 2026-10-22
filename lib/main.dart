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
import 'core/services/play_integrity_service.dart';
import 'core/widgets/custom_snack_bar.dart';
import 'features/auth/data/repos/auth_repo.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

  await setupServiceLocator();
  await sl<LocalNotificationService>().initialize();
  await sl<PushNotificationService>().initialize();
  unawaited(sl<PlayIntegrityService>().prepareIntegrityToken(retries: 2));

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

String? pendingStartupMessageKey;

Future<({String route, String? messageKey})> _resolveInitialRoute() async {
  final sessionStorage = sl<AuthSessionStorage>();
  final savedTenantSlug = await sessionStorage.readTenantSlug();
  if (savedTenantSlug == null || savedTenantSlug.isEmpty) {
    return (route: AppRoutes.companyCode, messageKey: null);
  }

  final result = await sl<AuthRepo>().verifyTenant(savedTenantSlug);
  final rejectionMessageKey = result.when(
    success: (_) => null,
    failure: (f) =>
        f.messageKey.startsWith('errors.tenant') ? f.messageKey : null,
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
