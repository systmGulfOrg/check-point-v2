import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';

abstract class AdminPlansRepo {
  Future<ApiResult<List<AdminPlanModel>>> getPlans();
  Future<ApiResult<void>> createPlan(CreatePlanRequestBody body);
}
