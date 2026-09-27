import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/approve_account_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/add_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';

abstract class AdminEmployeeRepo {
  Future<ApiResult<List<EmployeeModel>>> getEmployees({
    required int page,
    required int pageSize,
  });

  Future<ApiResult<List<EmployeeModel>>> searchEmployees({
    required String searchKey,
  });

  Future<ApiResult<List<EmployeeModel>>> getEmployeesInDepartment({
    required int departmentId,
  });

  Future<ApiResult<void>> addEmployee(AddEmployeeRequestBody body);

  Future<ApiResult<void>> editEmployee({
    required String id,
    required EditEmployeeRequestBody body,
  });

  Future<ApiResult<void>> deleteEmployee({required String userId});

  Future<ApiResult<List<EmployeeModel>>> getDeletedEmployees();

  Future<ApiResult<void>> restoreEmployee({required String id});

  Future<ApiResult<void>> permanentDeleteEmployee({required String id});

  Future<ApiResult<void>> setAttendancePermission({
    required String supervisorId,
    required bool permission,
  });

  Future<ApiResult<void>> setPlanPermission({
    required String supervisorId,
    required bool permission,
  });

  Future<ApiResult<List<AccountRequestModel>>> getAccountRequests({
    int page = 0,
    int pageSize = 20,
  });

  Future<ApiResult<void>> approveAccountRequest({
    required int id,
    required ApproveAccountRequestBody body,
  });

  Future<ApiResult<void>> rejectAccountRequest({
    required int id,
    required String reason,
  });

  Future<ApiResult<void>> deleteAccountRequest({required int id});
}
