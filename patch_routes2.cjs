const fs = require('fs');

// Patch AppRoutes
let appRoutesPath = 'lib/core/routes/routes.dart';
let codeRoutes = fs.readFileSync(appRoutesPath, 'utf8');
if (!codeRoutes.includes('adminPendingDevices')) {
  codeRoutes = codeRoutes.replace(
    "static const String adminTasks = '/admin-tasks';",
    "static const String adminTasks = '/admin-tasks';\n  static const String adminPendingDevices = '/admin-pending-devices';"
  );
  fs.writeFileSync(appRoutesPath, codeRoutes);
}

// Patch AppRouter
let appRouterPath = 'lib/core/routes/app_router.dart';
let codeRouter = fs.readFileSync(appRouterPath, 'utf8');
if (!codeRouter.includes('AdminDevicesScreen')) {
  codeRouter = codeRouter.replace(
    "import 'package:check_point_v2/features/admin/presentation/screens/admin_tasks_screen.dart';",
    "import 'package:check_point_v2/features/admin/presentation/screens/admin_tasks_screen.dart';\nimport 'package:check_point_v2/features/admin/presentation/screens/admin_devices_screen.dart';\nimport 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';"
  );
  codeRouter = codeRouter.replace(
    "case AppRoutes.adminTasks:",
    `case AppRoutes.adminPendingDevices:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.adminPendingDevices),
          builder: (_) => BlocProvider<AdminPendingDevicesCubit>(
            create: (_) => sl<AdminPendingDevicesCubit>(),
            child: const AdminDevicesScreen(),
          ),
        );
      case AppRoutes.adminTasks:`
  );
  fs.writeFileSync(appRouterPath, codeRouter);
}

// Patch AdminManageScreen
let adminManagePath = 'lib/features/admin/presentation/screens/admin_manage_screen.dart';
let codeManage = fs.readFileSync(adminManagePath, 'utf8');
if (!codeManage.includes('Devices & Transfers')) {
  codeManage = codeManage.replace(
    "AdminManageCardWidget(",
    `AdminManageCardWidget(
              icon: Icons.devices_other,
              iconColor: AppColors.info,
              iconBackgroundColor: AppColors.softBlueBackground,
              titleKey: 'Devices & Transfers',
              subtitleKey: 'Approve pending device transfers',
              onTap: () => Navigator.pushNamed(context, AppRoutes.adminPendingDevices),
            ),
            hSpace(10),
            AdminManageCardWidget(`
  );
  fs.writeFileSync(adminManagePath, codeManage);
}
