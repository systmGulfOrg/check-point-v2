import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'check_point_app.dart';
import 'core/auth/auth_session_storage.dart';
import 'core/connectivity/connectivity_cubit.dart';
import 'core/di/service_locator.dart';
import 'core/network/auth_token_interceptor.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';
import 'core/services/attendance_sync_service.dart';
import 'core/services/local_notification_service.dart';
import 'core/services/push_notification_service.dart';
import 'core/services/play_integrity_service.dart';
import 'core/widgets/custom_snack_bar.dart';
import 'features/auth/data/repos/auth_repo.dart';
import 'features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  // Sync pending attendance when connectivity is restored
  final connectivityCubit = sl<ConnectivityCubit>();
  final syncService = sl<AttendanceSyncService>();
  connectivityCubit.onOnlineRestored = () {
    unawaited(syncService.syncPending());
  };
  syncService.onSyncCompleted = (_) {
    try {
      final context = AppRouter.navigatorKey.currentContext;
      if (context != null && context.mounted) {
        context.read<EmployeeAttendanceCubit>().loadAttendanceHistory();
      }
    } catch (_) {}
  };
  unawaited(syncService.syncPending());

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

  // If a valid, unexpired session exists, restore it straight into the app
  final token = await sessionStorage.readToken();
  if (token != null && token.isNotEmpty) {
    final payload = AuthSessionStorage.decodeJwtPayload(token);
    final exp = payload?['exp'] as int?;
    final isNotExpired = exp == null ||
        DateTime.fromMillisecondsSinceEpoch(exp * 1000).isAfter(DateTime.now());
    if (isNotExpired) {
      final role = await sessionStorage.readUserRole();
      final targetRoute = switch (role?.toLowerCase()) {
        'admin' => AppRoutes.admin,
        'supervisor' => AppRoutes.supervisor,
        _ => AppRoutes.employee,
      };
      return (route: targetRoute, messageKey: null);
    }
  }

  try {
    final result = await sl<AuthRepo>()
        .verifyTenant(savedTenantSlug)
        .timeout(const Duration(seconds: 3));
    final rejectionMessageKey = result.when(
      success: (_) => null,
      failure: (f) =>
          f.messageKey.startsWith('errors.tenant') ? f.messageKey : null,
    );
    if (rejectionMessageKey != null) {
      await sessionStorage.clearTenant();
      return (route: AppRoutes.companyCode, messageKey: rejectionMessageKey);
    }
  } catch (_) {
    // If network times out or offline, proceed without clearing tenant
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
