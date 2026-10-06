import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/routes/app_router.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/core/theme/app_theme.dart';

Future<void> initIntegrationTestEnvironment() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupServiceLocator();
}

/// Helper to pump app with responsive ScreenUtil, EasyLocalization, Theme and Routes
Widget createTestApp({String initialRoute = AppRoutes.login, Object? arguments}) {
  return EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar'), Locale('ar', 'EG')],
    path: 'assets/translations',
    startLocale: const Locale('ar'),
    fallbackLocale: const Locale('ar'),
    child: Builder(
      builder: (context) {
        return ScreenUtilPlusInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          builder: (_, child) {
            return MaterialApp(
              title: 'Check Point HRM Test',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              initialRoute: initialRoute,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        );
      },
    ),
  );
}

/// Pump widget wrapper
Future<void> pumpTestApp(
  WidgetTester tester, {
  String initialRoute = AppRoutes.login,
  Object? arguments,
}) async {
  FlutterSecureStorage.setMockInitialValues({});
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 2.0;
  addTearDown(() => tester.view.resetPhysicalSize());
  addTearDown(() => tester.view.resetDevicePixelRatio());

  await tester.pumpWidget(createTestApp(initialRoute: initialRoute, arguments: arguments));
  await tester.pumpAndSettle();
}
