import '../../../../core/network/api_result.dart';
import '../../data/models/leave_balance_model.dart';
import '../../data/models/leave_request_body.dart';
import '../../data/models/leave_request_model.dart';
import '../../data/models/leave_type_model.dart';
import '../../data/models/official_holiday_model.dart';
import '../../data/models/short_leave_model.dart';
import '../../data/models/short_leave_request_body.dart';

abstract class LeavesRepo {
  Future<ApiResult<List<LeaveBalanceModel>>> getLeaveBalances({
    List<LeaveTypeModel>? types,
    List<LeaveRequestModel>? requests,
  });

  Future<ApiResult<List<LeaveTypeModel>>> getLeaveTypes();

  Future<ApiResult<List<OfficialHolidayModel>>> getOfficialHolidays({
    int? year,
  });

  Future<ApiResult<void>> rescheduleHoliday({
    required String holidayId,
    required String holidayName,
    required DateTime newDate,
    String? note,
    bool reset = false,
    bool isCancelled = false,
    String? cancelReason,
    List<String>? excludedDepartmentIds,
    List<String>? excludedEmployeeIds,
  });

  Future<ApiResult<LeaveRequestModel>> submitLeaveRequest(
    LeaveRequestBody body,
  );

  Future<ApiResult<List<LeaveRequestModel>>> getLeaveRequests();

  Future<ApiResult<dynamic>> updateLeaveStatus(String id, String status);

  Future<ApiResult<void>> cancelLeaveRequest(String id);

  Future<ApiResult<void>> deleteLeaveRequest(dynamic id);

  Future<ApiResult<List<ShortLeaveModel>>> getShortLeaves();

  Future<ApiResult<ShortLeaveModel>> submitShortLeaveRequest(
    ShortLeaveRequestBody body,
  );
}
