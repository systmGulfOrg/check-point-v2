import '../../../../core/auth/auth_session_storage.dart';
import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../../admin/data/models/admin_plan_model.dart';
import '../apis/supervisor_api_service.dart';
import 'supervisor_plans_repo.dart';

class SupervisorPlansRepoImpl implements SupervisorPlansRepo {
  SupervisorPlansRepoImpl({required this.api, required this.sessionStorage});
  final SupervisorApiService api;
  final AuthSessionStorage sessionStorage;

  Future<int?> _resolveDepartmentId(int? departmentId) async {
    if (departmentId != null) return departmentId;
    final cached = await sessionStorage.readDepartmentId();
    if (cached != null) return cached;
    final userId = await sessionStorage.readUserId();
    if (userId != null && userId.isNotEmpty) {
      try {
        final empRes = await api.getEmployeeById(userId);
        final id = empRes.value?.departmentId;
        if (id != null) {
          await sessionStorage.saveDepartmentId(id);
          return id;
        }
      } catch (_) {}
    }
    return null;
  }

  @override
  Future<ApiResult<List<AdminPlanModel>>> getPlans({int? departmentId}) async {
    try {
      final deptId = await _resolveDepartmentId(departmentId);
      final response = deptId != null
          ? await api.getPlansByDepartment(deptId)
          : await api.getPlans();
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<AdminPlanModel>>> getCustomerPlans({
    int? departmentId,
  }) async {
    try {
      final deptId = await _resolveDepartmentId(departmentId);
      final response = deptId != null
          ? await api.getCustomerPlansByDepartment(deptId)
          : await api.getPlans();
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> createPlan(CreatePlanRequestBody body) async {
    try {
      final deptId = body.departmentId ?? await _resolveDepartmentId(null);
      final requestBody = body.departmentId == null && deptId != null
          ? CreatePlanRequestBody(
              title: body.title,
              description: body.description,
              startDate: body.startDate,
              endDate: body.endDate,
              assignedEmployeeId: body.assignedEmployeeId,
              departmentId: deptId,
            )
          : body;
      await api.createPlan(requestBody);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deletePlan(int id) async {
    try {
      await api.deletePlan(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
