import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';

part 'admin_deleted_employees_state.freezed.dart';

@freezed
abstract class AdminDeletedEmployeesState with _$AdminDeletedEmployeesState {
  const factory AdminDeletedEmployeesState.initial() =
      AdminDeletedEmployeesStateInitial;
  const factory AdminDeletedEmployeesState.loading() =
      AdminDeletedEmployeesStateLoading;
  const factory AdminDeletedEmployeesState.success({
    required List<EmployeeModel> employees,
  }) = AdminDeletedEmployeesStateSuccess;
  const factory AdminDeletedEmployeesState.actionSuccess({
    required String message,
    required List<EmployeeModel> employees,
  }) = AdminDeletedEmployeesStateActionSuccess;
  const factory AdminDeletedEmployeesState.error(String messageKey) =
      AdminDeletedEmployeesStateError;
}
