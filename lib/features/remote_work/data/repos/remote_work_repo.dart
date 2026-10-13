import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import '../models/remote_work_policy_model.dart';
import '../models/remote_work_request_model.dart';

abstract class RemoteWorkRepo {
  Future<ApiResult<List<RemoteWorkPolicyModel>>> getPolicies();
  Future<ApiResult<List<RemoteWorkRequestModel>>> getRequests({String? status});
  Future<ApiResult<void>> createPolicy({
    required String name,
    required List<String> allowedDays,
    required String policyType,
    List<String> onsiteDays = const [],
    String? workingHoursStart,
    String? workingHoursEnd,
    int? allowedDelayTime,
    int? maxDaysPerWeek,
  });
  Future<ApiResult<void>> deactivatePolicy(String id);
  Future<ApiResult<void>> updatePolicy({
    required String id,
    required String name,
    required List<String> allowedDays,
    required String policyType,
    List<String> onsiteDays = const [],
    String? workingHoursStart,
    String? workingHoursEnd,
    int? allowedDelayTime,
    int? maxDaysPerWeek,
  });
  Future<ApiResult<List<EmployeeModel>>> getPolicyEmployees(String policyId);
  Future<ApiResult<void>> createRequest({
    required String requestDate,
    required String targetWorkSystem,
    String? policyId,
    String? reason,
  });
  Future<ApiResult<void>> updateRequestStatus({
    required String id,
    required String status,
    String? reviewNote,
  });
}
