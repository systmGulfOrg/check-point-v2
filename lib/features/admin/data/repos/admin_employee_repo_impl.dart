import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../apis/admin_employee_api_service.dart';
import '../models/employee_model.dart';
import 'admin_employee_repo.dart';

class AdminEmployeeRepoImpl implements AdminEmployeeRepo {
  AdminEmployeeRepoImpl({required this.api});

  final AdminEmployeeApiService api;

  @override
  Future<ApiResult<List<EmployeeModel>>> getEmployees({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await api.getEmployees(
        itemCount: pageSize,
        index: page * pageSize,
      );
      if (response.isSuccess != true) {
        return ApiResult.failure(
          ApiFailureMapper.fromMessages(
            response.errors,
            fallbackMessageKey: 'errors.adminEmployeesLoadFailed',
          ),
        );
      }
      return ApiResult.success(response.value?.data ?? const []);
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }

  @override
  Future<ApiResult<List<EmployeeModel>>> searchEmployees({
    required String searchKey,
  }) async {
    try {
      final response = await api.searchEmployees(searchKey);
      if (response.isSuccess != true) {
        return ApiResult.failure(
          ApiFailureMapper.fromMessages(
            response.errors,
            fallbackMessageKey: 'errors.adminEmployeesLoadFailed',
          ),
        );
      }
      return ApiResult.success(response.value?.data ?? const []);
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }
}
