const fs = require('fs');
let routerPath = 'lib/core/routes/app_router.dart';
let code = fs.readFileSync(routerPath, 'utf8');

// Insert the import if missing
if (!code.includes("import 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';")) {
  code = code.replace(
    "import 'package:check_point_v2/features/admin/presentation/screens/admin_main_screen.dart';",
    "import 'package:check_point_v2/features/admin/presentation/screens/admin_main_screen.dart';\nimport 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';"
  );
}

// Add to MultiBlocProvider of AdminMainScreen
code = code.replace(
  "create: (_) => sl<AdminTasksCubit>()..loadTasks(),\n              ),",
  "create: (_) => sl<AdminTasksCubit>()..loadTasks(),\n              ),\n              BlocProvider<AdminPendingDevicesCubit>(\n                create: (_) => sl<AdminPendingDevicesCubit>()..loadDevices(),\n              ),"
);
fs.writeFileSync(routerPath, code);
