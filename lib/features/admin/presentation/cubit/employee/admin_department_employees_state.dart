import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';

part 'admin_department_employees_state.freezed.dart';

@freezed
class AdminDepartmentEmployeesState with _$AdminDepartmentEmployeesState {
  const factory AdminDepartmentEmployeesState.initial() =
      AdminDepartmentEmployeesInitial;
  const factory AdminDepartmentEmployeesState.loading() =
      AdminDepartmentEmployeesLoading;
  const factory AdminDepartmentEmployeesState.success(
    List<EmployeeModel> employees,
  ) = AdminDepartmentEmployeesSuccess;
  const factory AdminDepartmentEmployeesState.error(String messageKey) =
      AdminDepartmentEmployeesError;
}
