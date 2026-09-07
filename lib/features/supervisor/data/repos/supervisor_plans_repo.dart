import '../../../../core/network/api_result.dart';
import '../../../admin/data/models/admin_plan_model.dart';

abstract class SupervisorPlansRepo {
  Future<ApiResult<List<AdminPlanModel>>> getPlans({int? departmentId});
  Future<ApiResult<List<AdminPlanModel>>> getCustomerPlans({int? departmentId});
  Future<ApiResult<void>> createPlan(CreatePlanRequestBody body);
  Future<ApiResult<void>> deletePlan(int id);
}
