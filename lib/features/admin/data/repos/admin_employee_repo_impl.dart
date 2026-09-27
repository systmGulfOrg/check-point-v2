import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/apis/admin_api_service.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/approve_account_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/add_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'admin_employee_repo.dart';

class AdminEmployeeRepoImpl implements AdminEmployeeRepo {
  AdminEmployeeRepoImpl({required this.api});
  final AdminApiService api;

  @override
  Future<ApiResult<List<EmployeeModel>>> getEmployees({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await api.getEmployees(itemCount: pageSize, index: page);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<EmployeeModel>>> searchEmployees({
    required String searchKey,
  }) async {
    try {
      final response = await api.searchEmployees(searchKey);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<EmployeeModel>>> getEmployeesInDepartment({
    required int departmentId,
  }) async {
    try {
      final response = await api.getEmployeesInDepartment(departmentId);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> addEmployee(AddEmployeeRequestBody body) async {
    try {
      await api.addEmployee(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> editEmployee({
    required String id,
    required EditEmployeeRequestBody body,
  }) async {
    try {
      await api.editEmployee(id, body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteEmployee({required String userId}) async {
    try {
      await api.deleteEmployee(userId);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<EmployeeModel>>> getDeletedEmployees() async {
    try {
      final response = await api.getDeletedEmployees();
      final rawList = (response is Map ? response['value'] : response) as List?;
      final list = (rawList ?? [])
          .map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(list);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> restoreEmployee({required String id}) async {
    try {
      await api.restoreEmployee(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> permanentDeleteEmployee({required String id}) async {
    try {
      await api.permanentDeleteEmployee(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> setAttendancePermission({
    required String supervisorId,
    required bool permission,
  }) async {
    try {
      await api.setAttendancePermission(supervisorId, permission);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> setPlanPermission({
    required String supervisorId,
    required bool permission,
  }) async {
    try {
      await api.setPlanPermission(supervisorId, permission);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<AccountRequestModel>>> getAccountRequests({
    int page = 0,
    int pageSize = 20,
  }) async {
    try {
      final response = await api.getAccountRequests(
        itemCount: pageSize,
        index: page,
      );
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> approveAccountRequest({
    required int id,
    required ApproveAccountRequestBody body,
  }) async {
    try {
      await api.updateAccountRequest(id, body.toJson());
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> rejectAccountRequest({
    required int id,
    required String reason,
  }) async {
    try {
      await api.updateAccountRequest(id, {
        'status': 'Rejected',
        'rejectReason': reason,
      });
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteAccountRequest({required int id}) async {
    try {
      await api.deleteAccountRequest(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
