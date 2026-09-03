import '../../../../core/network/api_failure.dart';
import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../apis/admin_employee_api_service.dart';
import '../models/branch_request_model.dart';
import '../models/branch_response_model.dart';
import '../models/department_request_model.dart';
import '../models/department_response_model.dart';
import 'admin_locations_repo.dart';

class AdminLocationsRepoImpl implements AdminLocationsRepo {
  AdminLocationsRepoImpl({required this.api});
  final AdminEmployeeApiService api;

  @override
  Future<ApiResult<List<DepartmentModel>>> getDepartments() async {
    try {
      final response = await api.getDepartments();
      return response.isSuccess == true
          ? ApiResult.success(response.value?.data ?? const [])
          : ApiResult.failure(
              _failure(response.errors, 'errors.adminDepartmentsLoadFailed'),
            );
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }

  @override
  Future<ApiResult<List<DepartmentModel>>> searchDepartments(
    String query,
  ) async {
    try {
      final response = await api.searchDepartments(query);
      return response.isSuccess == true
          ? ApiResult.success(response.value?.data ?? const [])
          : ApiResult.failure(
              _failure(response.errors, 'errors.adminDepartmentsLoadFailed'),
            );
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }

  @override
  Future<ApiResult<void>> addDepartment(DepartmentRequestModel request) =>
      _runMutation(() => api.addDepartment(request));

  @override
  Future<ApiResult<void>> editDepartment({
    required int id,
    required DepartmentRequestModel request,
  }) => _runMutation(() => api.editDepartment(id, request));

  @override
  Future<ApiResult<void>> deleteDepartment({required int id}) =>
      _runMutation(() => api.deleteDepartment(id));

  @override
  Future<ApiResult<List<BranchModel>>> getBranches() async {
    try {
      final response = await api.getBranches();
      return response.isSuccess == true
          ? ApiResult.success(response.value?.data ?? const [])
          : ApiResult.failure(
              _failure(response.errors, 'errors.adminBranchesLoadFailed'),
            );
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }

  @override
  Future<ApiResult<void>> addBranch(BranchRequestModel request) =>
      _runMutation(() => api.addBranch(request));

  @override
  Future<ApiResult<void>> editBranch({
    required int id,
    required BranchRequestModel request,
  }) => _runMutation(() => api.editBranch(id, request));

  @override
  Future<ApiResult<void>> deleteBranch({required int id}) =>
      _runMutation(() => api.deleteBranch(id));

  Future<ApiResult<void>> _runMutation(
    Future<dynamic> Function() action,
  ) async {
    try {
      final response = await action();
      if (response.isSuccess == true) return const ApiResult.success(null);
      return const ApiResult.failure(
        ApiFailure(messageKey: 'errors.adminActionFailed'),
      );
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }

  ApiFailure _failure(List<String>? messages, String fallback) =>
      ApiFailureMapper.fromMessages(messages, fallbackMessageKey: fallback);
}
