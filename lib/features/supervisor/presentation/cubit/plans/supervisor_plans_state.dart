import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';

part 'supervisor_plans_state.freezed.dart';

@freezed
class SupervisorPlansState with _$SupervisorPlansState {
  const factory SupervisorPlansState.initial() = SupervisorPlansInitial;
  const factory SupervisorPlansState.loading() = SupervisorPlansLoading;
  const factory SupervisorPlansState.success(List<AdminPlanModel> plans) =
      SupervisorPlansSuccess;
  const factory SupervisorPlansState.actionSuccess(String message) =
      SupervisorPlansActionSuccess;
  const factory SupervisorPlansState.error(String messageKey) =
      SupervisorPlansError;
}
