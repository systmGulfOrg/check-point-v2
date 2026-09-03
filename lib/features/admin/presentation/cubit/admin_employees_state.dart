import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/employee_model.dart';

part 'admin_employees_state.freezed.dart';

@freezed
abstract class AdminEmployeesState with _$AdminEmployeesState {
  const factory AdminEmployeesState.initial() = AdminEmployeesStateInitial;
  const factory AdminEmployeesState.loading() = AdminEmployeesStateLoading;
  const factory AdminEmployeesState.success({
    required List<EmployeeModel> employees,
    required String? roleFilter,
  }) = AdminEmployeesStateSuccess;
  const factory AdminEmployeesState.error(String messageKey) =
      AdminEmployeesStateError;
}
