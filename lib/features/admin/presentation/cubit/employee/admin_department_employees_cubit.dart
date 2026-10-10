import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'admin_department_employees_state.dart';

class AdminDepartmentEmployeesCubit
    extends Cubit<AdminDepartmentEmployeesState> {
  AdminDepartmentEmployeesCubit({required this.employeeRepo})
    : super(const AdminDepartmentEmployeesState.initial());

  final AdminEmployeeRepo employeeRepo;

  Future<void> load(int departmentId) async {
    emit(const AdminDepartmentEmployeesState.loading());
    final result = await employeeRepo.getEmployeesInDepartment(
      departmentId: departmentId,
    );
    result.when(
      success: (data) => emit(AdminDepartmentEmployeesState.success(data)),
      failure: (failure) =>
          emit(AdminDepartmentEmployeesState.error(failure.messageKey)),
    );
  }
}
