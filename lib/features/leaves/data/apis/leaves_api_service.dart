import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/leave_balance_model.dart';
import '../models/leave_request_body.dart';
import '../models/leave_request_model.dart';
import '../models/leave_type_model.dart';
import '../models/official_holiday_model.dart';
import '../models/short_leave_model.dart';
import '../models/short_leave_request_body.dart';

part 'leaves_api_service.g.dart';

@RestApi()
abstract class LeavesApiService {
  factory LeavesApiService(Dio dio, {String baseUrl}) = _LeavesApiService;

  @GET('/api/v1/leaves/types')
  Future<List<LeaveTypeModel>> getLeaveTypes();

  @GET('/api/v1/leaves/balances')
  Future<List<LeaveBalanceModel>> getLeaveBalances();

  @GET('/api/v1/leaves/holidays')
  Future<List<OfficialHolidayModel>> getOfficialHolidays({
    @Query('year') int? year,
  });

  @GET('/api/v1/leaves/requests')
  Future<List<LeaveRequestModel>> getLeaveRequests();

  @POST('/api/v1/leaves/request')
  Future<LeaveRequestModel> submitLeaveRequest(@Body() LeaveRequestBody body);

  @PATCH('/api/v1/leaves/{id}/status')
  Future<LeaveRequestModel> updateLeaveStatus(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/v2/leave-requests/{id}/cancel')
  Future<dynamic> cancelLeaveRequest(@Path('id') String id);

  @GET('/api/v1/leaves/permissions/requests')
  Future<List<ShortLeaveModel>> getShortLeaves();

  @POST('/api/v1/leaves/permissions/request')
  Future<ShortLeaveModel> submitShortLeaveRequest(
    @Body() ShortLeaveRequestBody body,
  );
}
