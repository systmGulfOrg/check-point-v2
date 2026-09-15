const fs = require('fs');
const path = 'lib/features/supervisor/presentation/screens/supervisor_leave_management_screen.dart';
let code = fs.readFileSync(path, 'utf8');

if (!code.includes('LeavesCubit')) {
  code = code.replace(
    "import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_leave_management_filter_widget.dart';",
    "import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';\nimport 'package:check_point_v2/features/leaves/presentation/cubit/leaves_state.dart';\nimport 'package:check_point_v2/features/leaves/presentation/widgets/leave_balances_list_widget.dart';\nimport 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_leave_management_filter_widget.dart';"
  );
  
  code = code.replace(
    "context.read<SupervisorLeaveRequestsCubit>().loadLeaveTypes();",
    "context.read<SupervisorLeaveRequestsCubit>().loadLeaveTypes();\n    context.read<LeavesCubit>().loadDashboardData();"
  );
  
  code = code.replace(
    "SupervisorLeaveManagementFilterWidget(",
    `BlocBuilder<LeavesCubit, LeavesState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      success: (balances, types) {
                        if (balances.isEmpty) return const SizedBox.shrink();
                        return Container(
                          height: 200.h,
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: LeaveBalancesListWidget(balances: balances),
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
                SupervisorLeaveManagementFilterWidget(`
  );
  fs.writeFileSync(path, code);
}
