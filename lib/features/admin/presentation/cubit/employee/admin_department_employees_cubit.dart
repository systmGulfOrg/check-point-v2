import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'admin_department_employees_state.dart';

class AdminDepartmentEmployeesCubit
    extends SafeCubit<AdminDepartmentEmployeesState> {
  AdminDepartmentEmployeesCubit({required this.employeeRepo})
    : super(const AdminDepartmentEmployeesState.initial());

  final AdminEmployeeRepo employeeRepo;

  Future<void> load(int departmentId) async {
    emit(const AdminDepartmentEmployeesState.loading());
    final result = await employeeRepo.getEmployeesInDepartment(
      departmentId: departmentId,
    );
    result.when(
      success: (data) => safeEmit(AdminDepartmentEmployeesState.success(data)),
      failure: (failure) =>
          safeEmit(AdminDepartmentEmployeesState.error(failure.messageKey)),
    );
  }
}
