import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../apis/admin_api_service.dart';
import '../models/admin_plan_model.dart';
import 'admin_plans_repo.dart';

class AdminPlansRepoImpl implements AdminPlansRepo {
  AdminPlansRepoImpl({required this.api});
  final AdminApiService api;

  @override
  Future<ApiResult<List<AdminPlanModel>>> getPlans() async {
    try {
      final response = await api.getPlans();
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> createPlan(CreatePlanRequestBody body) async {
    try {
      await api.createPlan(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
