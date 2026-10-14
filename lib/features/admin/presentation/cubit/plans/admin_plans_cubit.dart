import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_plans_repo.dart';
import 'admin_plans_state.dart';

class AdminPlansCubit extends SafeCubit<AdminPlansState> {
  AdminPlansCubit({required this.plansRepo})
    : super(const AdminPlansState.initial());

  final AdminPlansRepo plansRepo;

  Future<void> loadPlans() async {
    emit(const AdminPlansState.loading());
    final result = await plansRepo.getPlans();
    result.when(
      success: (data) => safeEmit(AdminPlansState.success(data)),
      failure: (failure) => safeEmit(AdminPlansState.error(failure.messageKey)),
    );
  }

  Future<bool> createPlan(CreatePlanRequestBody body) async {
    emit(const AdminPlansState.loading());
    final result = await plansRepo.createPlan(body);
    return result.when(
      success: (_) async {
        await loadPlans();
        safeEmit(
          const AdminPlansState.actionSuccess('Plan created successfully'),
        );
        return true;
      },
      failure: (failure) {
        safeEmit(AdminPlansState.error(failure.messageKey));
        return false;
      },
    );
  }
}
