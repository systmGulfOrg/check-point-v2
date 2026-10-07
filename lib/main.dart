import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'check_point_app.dart';
import 'core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupServiceLocator();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar'), Locale('ar', 'EG')],
      path: 'assets/translations',
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      child: const CheckPointApp(),
    ),
  );
}
