import '../../../../core/network/api_result.dart';
import '../models/employee_model.dart';

abstract class AdminEmployeeRepo {
  Future<ApiResult<List<EmployeeModel>>> getEmployees({
    required int page,
    required int pageSize,
  });

  Future<ApiResult<List<EmployeeModel>>> searchEmployees({
    required String searchKey,
  });
}
