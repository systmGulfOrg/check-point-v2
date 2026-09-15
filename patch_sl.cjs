const fs = require('fs');
const path = 'lib/core/di/service_locator.dart';
let code = fs.readFileSync(path, 'utf8');

if (!code.includes('AdminPendingDevicesCubit')) {
  code = code.replace(
    "import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';",
    "import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';\nimport 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';"
  );
  code = code.replace(
    "sl.registerFactory<AdminAccountRequestsCubit>(",
    "sl.registerFactory<AdminPendingDevicesCubit>(() => AdminPendingDevicesCubit(api: sl<AdminApiService>()));\n  sl.registerFactory<AdminAccountRequestsCubit>("
  );
  fs.writeFileSync(path, code);
}
