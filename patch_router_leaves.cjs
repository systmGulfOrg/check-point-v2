const fs = require('fs');
const path = 'lib/core/routes/app_router.dart';
let code = fs.readFileSync(path, 'utf8');

if (!code.includes('sl<LeavesCubit>()')) {
  code = code.replace(
    "BlocProvider<EmployeeLeaveRequestsCubit>(",
    "BlocProvider<LeavesCubit>(\n                create: (_) => sl<LeavesCubit>(),\n              ),\n              BlocProvider<EmployeeLeaveRequestsCubit>("
  );
  code = code.replace(
    "import 'package:check_point_v2/features/employee/presentation/cubit/plans/employee_plans_cubit.dart';",
    "import 'package:check_point_v2/features/employee/presentation/cubit/plans/employee_plans_cubit.dart';\nimport 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';"
  );
  fs.writeFileSync(path, code);
}
