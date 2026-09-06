import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../apis/admin_api_service.dart';
import '../models/branch_request_model.dart';
import '../models/branch_response_model.dart';
import '../models/customer_request_model.dart';
import '../models/customer_response_model.dart';
import '../models/department_request_model.dart';
import '../models/department_response_model.dart';
import 'admin_locations_repo.dart';

class AdminLocationsRepoImpl implements AdminLocationsRepo {
  AdminLocationsRepoImpl({required this.api});
  final AdminApiService api;

  @override
  Future<ApiResult<List<DepartmentModel>>> getDepartments({
    int page = 0,
    int pageSize = 50,
  }) async {
    try {
      final response = await api.getDepartments(itemCount: pageSize, index: page);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<DepartmentModel>>> searchDepartments(
    String searchKey,
  ) async {
    try {
      final response = await api.searchDepartments(searchKey);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> addDepartment(DepartmentRequestModel request) async {
    try {
      await api.addDepartment(request);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> editDepartment(
    int id,
    DepartmentRequestModel request,
  ) async {
    try {
      await api.editDepartment(id, request);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteDepartment(int id) async {
    try {
      await api.deleteDepartment(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<BranchModel>>> getBranches() async {
    try {
      final response = await api.getBranches();
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> addBranch(BranchRequestModel request) async {
    try {
      await api.addBranch(request);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> editBranch(int id, BranchRequestModel request) async {
    try {
      await api.editBranch(id, request);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteBranch(int id) async {
    try {
      await api.deleteBranch(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<CustomerModel>>> getCustomersByType(String type) async {
    try {
      final response = await api.getCustomersByType(type);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> addCustomer(CustomerRequestModel request) async {
    try {
      await api.addCustomer(request);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> editCustomer(
    String id,
    CustomerRequestModel request,
  ) async {
    try {
      await api.editCustomer(id, request);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteCustomer(String id) async {
    try {
      await api.deleteCustomer(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
