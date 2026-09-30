import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_plans_repo.dart';
import 'supervisor_plans_state.dart';

class SupervisorPlansCubit extends Cubit<SupervisorPlansState> {
  SupervisorPlansCubit({required this.plansRepo})
    : super(const SupervisorPlansState.initial());

  final SupervisorPlansRepo plansRepo;
  List<AdminPlanModel> allPlans = const [];

  Future<void> loadPlans({int? departmentId}) async {
    emit(const SupervisorPlansState.loading());
    final result = await plansRepo.getPlans(departmentId: departmentId);
    result.when(
      success: (data) {
        allPlans = data;
        emit(SupervisorPlansState.success(data));
      },
      failure: (failure) =>
          emit(SupervisorPlansState.error(failure.messageKey)),
    );
  }

  Future<bool> createPlan(CreatePlanRequestBody body) async {
    final result = await plansRepo.createPlan(body);
    return result.when(
      success: (_) async {
        await loadPlans();
        return true;
      },
      failure: (failure) {
        emit(SupervisorPlansState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> deletePlan(int id) async {
    final result = await plansRepo.deletePlan(id);
    return result.when(
      success: (_) async {
        await loadPlans();
        return true;
      },
      failure: (failure) {
        emit(SupervisorPlansState.error(failure.messageKey));
        return false;
      },
    );
  }
}
