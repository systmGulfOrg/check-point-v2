import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class CheckPointApp extends StatelessWidget {
  const CheckPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Check-Point HRM',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: AppRoutes.login,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
