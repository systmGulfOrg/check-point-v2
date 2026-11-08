import 'package:check_point_v2/core/network/api_result.dart';
import '../models/employee_record_model.dart';

abstract class EmployeeRecordRepo {
  /// The record of [employeeId] (`me` for yourself) for one calendar month.
  Future<ApiResult<EmployeeRecordModel>> getMonth({
    required String employeeId,
    required DateTime month,
  });
}
