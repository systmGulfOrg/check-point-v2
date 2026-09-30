import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/core.dart';
import 'core/di/service_locator.dart';
import 'core/tenant/tenant_storage.dart';
import 'features/tenant/data/models/tenant_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupServiceLocator();

  final tenantStorage = sl<TenantStorage>();
  final savedTenant = await tenantStorage.readTenant();
  if (savedTenant == null) {
    await tenantStorage.saveTenant(
      const TenantModel(
        tenantId: AppConfig.tenantId,
        tenantCode: AppConfig.tenantCode,
        companyName: AppConfig.tenantCompanyName,
      ),
    );
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar'), Locale('ar', 'EG')],
      path: 'assets/translations',
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      child: const CheckPointApp(initialRoute: AppRoutes.login),
    ),
  );
}
