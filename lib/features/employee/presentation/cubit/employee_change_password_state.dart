import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_change_password_state.freezed.dart';

@freezed
class EmployeeChangePasswordState with _$EmployeeChangePasswordState {
  const factory EmployeeChangePasswordState.initial() =
      EmployeeChangePasswordStateInitial;
  const factory EmployeeChangePasswordState.loading() =
      EmployeeChangePasswordStateLoading;
  const factory EmployeeChangePasswordState.success() =
      EmployeeChangePasswordStateSuccess;
  const factory EmployeeChangePasswordState.error(String messageKey) =
      EmployeeChangePasswordStateError;
}
