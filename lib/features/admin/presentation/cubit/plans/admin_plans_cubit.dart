import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_plans_repo.dart';
import 'admin_plans_state.dart';

class AdminPlansCubit extends Cubit<AdminPlansState> {
  AdminPlansCubit({required this.plansRepo})
    : super(const AdminPlansState.initial());

  final AdminPlansRepo plansRepo;
  List<AdminPlanModel> allPlans = const [];

  Future<void> loadPlans() async {
    emit(const AdminPlansState.loading());
    final result = await plansRepo.getPlans();
    switch (result) {
      case Success(:final data):
        allPlans = data;
        emit(AdminPlansState.success(data));
      case Failure(:final failure):
        emit(AdminPlansState.error(failure.messageKey));
    }
  }

  Future<bool> createPlan(CreatePlanRequestBody body) async {
    emit(const AdminPlansState.loading());
    final result = await plansRepo.createPlan(body);
    switch (result) {
      case Success():
        await loadPlans();
        emit(const AdminPlansState.actionSuccess('Plan created successfully'));
        return true;
      case Failure(:final failure):
        emit(AdminPlansState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }
}
