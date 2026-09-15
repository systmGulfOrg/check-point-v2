const fs = require('fs');
let p = 'lib/core/di/service_locator.dart';
let code = fs.readFileSync(p, 'utf8');

if (!code.includes('AdminEmployeeAuditCubit')) {
  code = "import 'package:check_point_v2/features/admin/presentation/cubit/employee_audit/admin_employee_audit_cubit.dart';\n" + code;
  code = code.replace(
    '// Admin Employee',
    "// Admin Employee\n  sl.registerFactory(() => AdminEmployeeAuditCubit(api: sl()));"
  );
  fs.writeFileSync(p, code);
}
