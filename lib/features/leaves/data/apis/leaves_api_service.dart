import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../../../admin/data/models/leave_requests/admin_leave_request_model.dart';
import '../../../admin/data/models/leave_requests/leave_type_model.dart'
    show LeaveTypesResponseModel;
import '../models/leave_balance_model.dart';
import '../models/official_holiday_model.dart';
import '../models/short_leave_model.dart';

part 'leaves_api_service.g.dart';

@RestApi()
abstract class LeavesApiService {
  factory LeavesApiService(Dio dio, {String baseUrl}) = _LeavesApiService;

  @GET(ApiConstants.leaveTypes)
  Future<LeaveTypesResponseModel> getBackendLeaveTypes();

  @GET(ApiConstants.leaveRequests)
  Future<LeaveRequestsResponseModel> getBackendLeaveRequests();

  @POST(ApiConstants.leaveRequests)
  Future<dynamic> submitBackendLeaveRequest(@Body() Map<String, dynamic> body);

  @GET('/api/v1/leaves/balances')
  Future<List<LeaveBalanceModel>> getLeaveBalances();

  @GET('/api/v1/leaves/holidays')
  Future<OfficialHolidaysResponseModel> getOfficialHolidays({
    @Query('year') int? year,
  });

  @POST('/api/v1/leaves/holidays/reschedule')
  Future<OfficialHolidaysResponseModel> rescheduleHoliday(
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/api/v1/leaves/{id}/status')
  Future<dynamic> updateLeaveStatus(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/v2/leave-requests/{id}/cancel')
  Future<dynamic> cancelLeaveRequest(@Path('id') String id);

  @DELETE('${ApiConstants.leaveRequests}/{id}')
  Future<dynamic> deleteLeaveRequest(@Path('id') dynamic id);

  @GET('/api/v1/leaves/permissions/requests')
  Future<List<ShortLeaveModel>> getShortLeaves();

  @POST('/api/v1/leaves/permissions/request')
  Future<ShortLeaveModel> submitShortLeaveRequest(
    @Body() Map<String, dynamic> body,
  );
}
