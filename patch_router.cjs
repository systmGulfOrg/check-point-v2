const fs = require('fs');
let p = 'lib/core/routes/app_router.dart';
let code = fs.readFileSync(p, 'utf8');

if (!code.includes('AdminEmployeeAuditScreen')) {
  code = "import 'package:check_point_v2/features/admin/presentation/screens/admin_employee_audit_screen.dart';\n" + 
         "import 'package:check_point_v2/features/admin/presentation/cubit/employee_audit/admin_employee_audit_cubit.dart';\n" + code;
         
  const insertCase = `
      case AppRoutes.adminEmployeeAudit:
        final employeeId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => sl<AdminEmployeeAuditCubit>()..loadAuditLogs(employeeId),
            child: const AdminEmployeeAuditScreen(),
          ),
        );`;
  
  code = code.replace(
    'switch (settings.name) {',
    'switch (settings.name) {' + insertCase
  );
  fs.writeFileSync(p, code);
}
