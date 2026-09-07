import '../../../../core/network/api_result.dart';
import '../../../admin/data/models/employee_model.dart';

abstract class SupervisorTeamRepo {
  Future<ApiResult<List<EmployeeModel>>> getTeamEmployees({int? departmentId});
  Future<ApiResult<List<EmployeeModel>>> searchEmployees(String query);
  Future<ApiResult<EmployeeModel>> getEmployeeProfile(String id);
}
