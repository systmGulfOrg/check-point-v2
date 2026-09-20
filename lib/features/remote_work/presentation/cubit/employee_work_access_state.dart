import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_work_access_state.freezed.dart';

@freezed
abstract class EmployeeWorkAccessState with _$EmployeeWorkAccessState {
  const factory EmployeeWorkAccessState.initial() = EmployeeWorkAccessInitial;
  const factory EmployeeWorkAccessState.loading() = EmployeeWorkAccessLoading;
  const factory EmployeeWorkAccessState.allowed({required String workSystem}) =
      EmployeeWorkAccessAllowed;
  const factory EmployeeWorkAccessState.denied(String messageKey) =
      EmployeeWorkAccessDenied;
}
