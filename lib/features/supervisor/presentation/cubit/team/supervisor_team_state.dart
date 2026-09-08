import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';

part 'supervisor_team_state.freezed.dart';

@freezed
class SupervisorTeamState with _$SupervisorTeamState {
  const factory SupervisorTeamState.initial() = SupervisorTeamInitial;
  const factory SupervisorTeamState.loading() = SupervisorTeamLoading;
  const factory SupervisorTeamState.success(List<EmployeeModel> members) =
      SupervisorTeamSuccess;
  const factory SupervisorTeamState.error(String messageKey) =
      SupervisorTeamError;
}
