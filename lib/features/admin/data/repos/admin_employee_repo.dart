import '../../../../core/network/api_result.dart';
import '../models/account_requests_response_model.dart';
import '../models/add_employee_request_body.dart';
import '../models/edit_employee_request_body.dart';
import '../models/employee_model.dart';

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

  Future<ApiResult<void>> deleteAccountRequest({required int id});
}
