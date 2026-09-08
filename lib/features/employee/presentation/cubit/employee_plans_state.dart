import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../admin/data/models/admin_plan_model.dart';

part 'employee_plans_state.freezed.dart';

@freezed
class EmployeePlansState with _$EmployeePlansState {
  const factory EmployeePlansState.initial() = EmployeePlansStateInitial;
  const factory EmployeePlansState.loading() = EmployeePlansStateLoading;
  const factory EmployeePlansState.success(List<AdminPlanModel> plans) =
      EmployeePlansStateSuccess;
  const factory EmployeePlansState.statusesLoaded(List<String> statuses) =
      EmployeePlansStateStatusesLoaded;
  const factory EmployeePlansState.actionSuccess(String message) =
      EmployeePlansStateActionSuccess;
  const factory EmployeePlansState.error(String messageKey) =
      EmployeePlansStateError;
}
