import '../../../../core/network/api_result.dart';
import '../models/admin_plan_model.dart';

abstract class AdminPlansRepo {
  Future<ApiResult<List<AdminPlanModel>>> getPlans();
  Future<ApiResult<void>> createPlan(CreatePlanRequestBody body);
}
