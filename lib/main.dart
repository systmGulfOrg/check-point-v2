import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'check_point_app.dart';
import 'core/auth/auth_session_storage.dart';
import 'core/di/service_locator.dart';
import 'core/routes/routes.dart';
import 'core/services/local_notification_service.dart';
import 'core/services/push_notification_service.dart';
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

  final savedTenantSlug = await sl<AuthSessionStorage>().readTenantSlug();
  final initialRoute = (savedTenantSlug != null && savedTenantSlug.isNotEmpty)
      ? AppRoutes.login
      : AppRoutes.companyCode;

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar'), Locale('ar', 'EG')],
      path: 'assets/translations',
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      child: CheckPointApp(initialRoute: initialRoute),
    ),
  );
}
