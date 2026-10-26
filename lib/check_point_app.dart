import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/connectivity/connectivity_cubit.dart';
import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/widgets/offline_banner_widget.dart';
import 'package:check_point_v2/core/widgets/push_tap_listener_widget.dart';
import 'package:check_point_v2/features/support/presentation/support_app_overlay_widget.dart';

class CheckPointApp extends StatelessWidget {
  const CheckPointApp({required this.initialRoute, super.key});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (_, child) {
        return PushTapListenerWidget(
          child: MaterialApp(
            navigatorKey: AppRouter.navigatorKey,
            title: 'Check-Point HRM',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialRoute: initialRoute,
            onGenerateRoute: AppRouter.onGenerateRoute,
            builder: (context, child) => BlocProvider.value(
              value: sl<ConnectivityCubit>(),
              child: SupportAppOverlayWidget(
                child: Stack(
                  children: [
                    child ?? const SizedBox.shrink(),
                    const Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: IgnorePointer(
                        child: OfflineBannerWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
