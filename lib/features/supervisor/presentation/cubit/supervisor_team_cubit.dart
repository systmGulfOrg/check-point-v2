import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../admin/data/models/employee_model.dart';
import '../../data/repos/supervisor_team_repo.dart';
import 'supervisor_team_state.dart';

class SupervisorTeamCubit extends Cubit<SupervisorTeamState> {
  SupervisorTeamCubit({required this.teamRepo})
    : super(const SupervisorTeamState.initial());

  final SupervisorTeamRepo teamRepo;
  List<EmployeeModel> _allMembers = const [];

  Future<void> loadTeam({int? departmentId}) async {
    emit(const SupervisorTeamState.loading());
    final result = await teamRepo.getTeamEmployees(departmentId: departmentId);
    switch (result) {
      case Success(:final data):
        _allMembers = data;
        emit(SupervisorTeamState.success(_allMembers));
      case Failure(:final failure):
        emit(SupervisorTeamState.error(failure.messageKey));
    }
  }

  void search(String query) {
    if (query.trim().isEmpty) {
      emit(SupervisorTeamState.success(_allMembers));
      return;
    }
    final filtered = _allMembers
        .where(
          (m) =>
              (m.name ?? '').toLowerCase().contains(query.toLowerCase()) ||
              (m.position ?? '').toLowerCase().contains(query.toLowerCase()) ||
              (m.userName ?? '').toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    emit(SupervisorTeamState.success(filtered));
  }
}
