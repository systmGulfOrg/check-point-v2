const fs = require('fs');
const path = 'lib/features/employee/presentation/screens/employee_leaves_screen.dart';
let code = fs.readFileSync(path, 'utf8');

if (!code.includes('LeavesDashboardScreen') && !code.includes('LeaveBalancesListWidget')) {
  code = code.replace(
    "import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';",
    "import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';\nimport 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';\nimport 'package:check_point_v2/features/leaves/presentation/cubit/leaves_state.dart';\nimport 'package:check_point_v2/features/leaves/presentation/widgets/leave_balances_list_widget.dart';"
  );
  
  // Also we need to wrap the body in a MultiBlocProvider or just inject LeavesCubit if it's already there
  // Actually we should just fetch it using the existing LeavesCubit!
  code = code.replace(
    "context.read<EmployeeLeaveRequestsCubit>().loadLeaveRequests();",
    "context.read<EmployeeLeaveRequestsCubit>().loadLeaveRequests();\n    context.read<LeavesCubit>().loadDashboardData();"
  );
  
  code = code.replace(
    "children: [",
    `children: [
                        BlocBuilder<LeavesCubit, LeavesState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              success: (balances, types) {
                                if (balances.isEmpty) return const SizedBox.shrink();
                                return Container(
                                  height: 200.h,
                                  child: LeaveBalancesListWidget(balances: balances),
                                );
                              },
                              orElse: () => const SizedBox.shrink(),
                            );
                          },
                        ),
                        hSpace(16),`
  );
  fs.writeFileSync(path, code);
}
