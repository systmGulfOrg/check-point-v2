import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/employee_model.dart';

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
