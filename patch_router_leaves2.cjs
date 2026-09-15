const fs = require('fs');
const path = 'lib/core/routes/app_router.dart';
let code = fs.readFileSync(path, 'utf8');

if (code.split('sl<LeavesCubit>()').length === 2) {
  code = code.replace(
    "BlocProvider<SupervisorLeaveRequestsCubit>(",
    "BlocProvider<LeavesCubit>(\n                create: (_) => sl<LeavesCubit>(),\n              ),\n              BlocProvider<SupervisorLeaveRequestsCubit>("
  );
  fs.writeFileSync(path, code);
}
