import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';

abstract class SupervisorPlansRepo {
  Future<ApiResult<List<AdminPlanModel>>> getPlans({int? departmentId});
  Future<ApiResult<List<AdminPlanModel>>> getCustomerPlans({int? departmentId});
  Future<ApiResult<void>> createPlan(CreatePlanRequestBody body);
  Future<ApiResult<void>> deletePlan(int id);
}
