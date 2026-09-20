import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:check_point_v2/core/network/api_constants.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/single_employee_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employees_response_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/result_model.dart';
import 'package:check_point_v2/features/employee/data/models/password/employee_change_password_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_in_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_out_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/leave_requests/employee_leave_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/plans/employee_plan_feedback_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/plans/employee_remove_plan_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/tasks/employee_remove_task_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/tasks/employee_update_task_status_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/plans/feedback_statuses_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/track_user_request_body.dart';

part 'employee_api_service.g.dart';

@RestApi()
abstract class EmployeeApiService {
  factory EmployeeApiService(Dio dio, {String? baseUrl}) = _EmployeeApiService;

  // Attendance
  @POST(ApiConstants.employeeCheckIn)
  Future<dynamic> checkIn(@Body() EmployeeCheckInRequestBody body);

  @POST(ApiConstants.employeeCheckInWithoutPlan)
  Future<dynamic> checkInWithoutPlan(
    @Body() EmployeeCheckInRequestBody body,
  );

  @POST(ApiConstants.employeeCheckOut)
  Future<dynamic> checkOut(
    @Body() EmployeeCheckOutRequestBody body,
  );

  @POST(ApiConstants.employeeCheckOutWithoutPlan)
  Future<AdminAttendanceModel> checkOutWithoutPlan(
    @Body() EmployeeCheckOutRequestBody body,
  );

  @GET('${ApiConstants.attendance}/employeeId/{employeeId}')
  Future<AttendanceResponseModel> getAttendanceHistory(
    @Path('employeeId') String employeeId, {
    @Query('itemCount') int itemCount = 10,
    @Query('index') int index = 0,
  });

  @POST(ApiConstants.trackEmployeeLocation)
  Future<ResultModel> trackLocation(@Body() TrackUserRequestBody body);

  @GET('${ApiConstants.branches}/{id}')
  Future<BranchResponseModel> getBranchById(@Path('id') int id);

  @GET(ApiConstants.branches)
  Future<BranchResponseModel> getBranches();

  @GET('${ApiConstants.employees}/{id}')
  Future<SingleEmployeeResponseModel> getEmployeeById(@Path('id') String id);

  @GET('${ApiConstants.employees}/departmentId/{id}')
  Future<EmployeesResponseModel> getEmployeesInDepartment(@Path('id') int id);

  @GET('${ApiConstants.customers}/customerType/{type}')
  Future<CustomerResponseModel> getCustomersByType(@Path('type') String type);

  // Plans
  @GET('${ApiConstants.plans}/employee/{employeeId}')
  Future<PlansResponseModel> getCustomerPlansForEmployee(
    @Path('employeeId') String employeeId,
  );

  @GET('${ApiConstants.plans}/{id}')
  Future<SinglePlanResponseModel> getPlanById(@Path('id') int id);

  @POST(ApiConstants.plans)
  Future<ResultModel> createPlan(@Body() CreatePlanRequestBody body);

  @POST(ApiConstants.planFeedback)
  Future<ResultModel> addPlanFeedback(
    @Body() EmployeePlanFeedbackRequestBody body,
  );

  @POST(ApiConstants.removeAssignCustomerPlan)
  Future<ResultModel> removeAssignCustomerPlan(
    @Body() EmployeeRemovePlanRequestBody body,
  );

  @GET(ApiConstants.feedBackStatus)
  Future<FeedbackStatusesResponseModel> getFeedbackStatuses();

  // Tasks
  @GET('${ApiConstants.tasks}/specificEmployee')
  Future<TasksResponseModel> getEmployeeTasks(
    @Query('employeeId') String employeeId,
  );

  @PUT('${ApiConstants.tasks}/updateStatus')
  Future<ResultModel> updateTaskStatus(
    @Body() EmployeeUpdateTaskStatusRequestBody body,
  );

  @POST(ApiConstants.tasks)
  Future<ResultModel> addTask(@Body() AddTaskRequestBody body);

  @PUT('${ApiConstants.tasks}/{id}')
  Future<ResultModel> editTask(
    @Path('id') int id,
    @Body() AddTaskRequestBody body,
  );

  @POST('${ApiConstants.tasks}/assignTask')
  Future<ResultModel> assignTask(@Body() AssignTaskRequestBody body);

  @POST('/api/v2/tasks/{id}/time-logs')
  Future<dynamic> logTaskTime(
    @Path('id') String taskId,
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/v2/tasks/{id}/time-logs')
  Future<dynamic> getTaskLogs(@Path('id') String taskId);

  @GET('/api/v2/tasks/productive-hours')
  Future<dynamic> getProductiveHours({
    @Query('from') required String from,
    @Query('to') required String to,
  });

  @POST(ApiConstants.removeTaskFromEmployee)
  Future<ResultModel> removeTask(@Body() EmployeeRemoveTaskRequestBody body);

  // Leave Requests
  @POST(ApiConstants.leaveRequests)
  Future<ResultModel> createLeaveRequest(@Body() EmployeeLeaveRequestBody body);

  @DELETE('${ApiConstants.leaveRequests}/{id}')
  Future<ResultModel> deleteLeaveRequest(@Path('id') int id);

  @GET('${ApiConstants.leaveRequests}/employeeId/{employeeId}')
  Future<LeaveRequestsResponseModel> getLeaveRequestsForEmployee(
    @Path('employeeId') String employeeId,
  );

  @GET('${ApiConstants.leaveRequests}/employeeId/{employeeId}/leaveType/{type}')
  Future<LeaveRequestsResponseModel> getLeaveRequestsByType(
    @Path('employeeId') String employeeId,
    @Path('type') String type,
  );

  @GET(ApiConstants.leaveTypes)
  Future<LeaveTypesResponseModel> getLeaveTypes();

  // Auth / Password
  @PUT(ApiConstants.employeeChangePassword)
  Future<ResultModel> changePassword(
    @Body() EmployeeChangePasswordRequestBody body,
  );
}
