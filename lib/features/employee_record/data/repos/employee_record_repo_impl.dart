import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import '../apis/employee_record_api_service.dart';
import '../models/employee_record_model.dart';
import 'employee_record_repo.dart';

class EmployeeRecordRepoImpl implements EmployeeRecordRepo {
  EmployeeRecordRepoImpl({required this.api});

  final EmployeeRecordApiService api;

  /// Machine `YYYY-MM-DD` for the query (not user-facing, so not localized).
  static String _day(DateTime d) => DateTime.utc(d.year, d.month, d.day).toIso8601String().substring(0, 10);

  @override
  Future<ApiResult<EmployeeRecordModel>> getMonth({
    required String employeeId,
    required DateTime month,
  }) async {
    try {
      final first = DateTime(month.year, month.month);
      final last = DateTime(month.year, month.month + 1, 0);
      final response = await api.getRecord(
        employeeId,
        from: _day(first),
        to: _day(last),
      );
      final record = response.value;
      if (record == null) {
        return const ApiResult.failure(ApiFailure(messageKey: 'errors.unknown'));
      }
      return ApiResult.success(record);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
