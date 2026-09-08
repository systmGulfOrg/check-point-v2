import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';

abstract class SupervisorTeamRepo {
  Future<ApiResult<List<EmployeeModel>>> getTeamEmployees({int? departmentId});
  Future<ApiResult<List<EmployeeModel>>> searchEmployees(String query);
  Future<ApiResult<EmployeeModel>> getEmployeeProfile(String id);
}
