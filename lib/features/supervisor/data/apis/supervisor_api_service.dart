import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:check_point_v2/core/network/api_constants.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employees_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/single_employee_response_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/result_model.dart';
import 'package:check_point_v2/features/supervisor/data/models/attendance/supervisor_attendance_check_in_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/models/attendance/supervisor_attendance_check_out_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/models/tasks/supervisor_update_task_status_request_body.dart';

part 'supervisor_api_service.g.dart';

@RestApi()
abstract class SupervisorApiService {
  factory SupervisorApiService(Dio dio, {String? baseUrl}) =
      _SupervisorApiService;

  // Attendance
  @GET(ApiConstants.attendance)
  Future<AttendanceResponseModel> getAttendance({
    @Query('itemCount') int itemCount = 1000,
    @Query('index') int index = 0,
  });

  @GET('${ApiConstants.attendance}/departmentId/{departmentId}')
  Future<AttendanceResponseModel> getAttendanceByDepartment(
    @Path('departmentId') int departmentId, {
    @Query('attendenceDate') String? attendanceDate,
  });

  @GET('${ApiConstants.attendance}/lateComers/{day}')
  Future<AttendanceResponseModel> getLateComers(@Path('day') String day);

  @GET('${ApiConstants.attendance}/earlyLeavers/{day}')
  Future<AttendanceResponseModel> getEarlyLeavers(@Path('day') String day);

  @POST(ApiConstants.employeeCheckIn)
  Future<ResultModel> checkIn(
    @Body() SupervisorAttendanceCheckInRequestBody body,
  );

  @POST(ApiConstants.employeeCheckOut)
  Future<ResultModel> checkOut(
    @Body() SupervisorAttendanceCheckOutRequestBody body,
  );

  // Leave Requests
  @GET(ApiConstants.leaveRequests)
  Future<LeaveRequestsResponseModel> getLeaveRequests();

  @GET('${ApiConstants.leaveRequests}/departmentId/{departmentId}')
  Future<LeaveRequestsResponseModel> getLeaveRequestsByDepartment(
    @Path('departmentId') int departmentId,
  );

  @GET(
    '${ApiConstants.leaveRequests}/departmentId/{departmentId}/leaveType/{type}',
  )
  Future<LeaveRequestsResponseModel> getLeaveRequestsByDepartmentAndType(
    @Path('departmentId') int departmentId,
    @Path('type') String type,
  );

  @PUT('${ApiConstants.leaveRequests}/leaveRequestStatus')
  Future<ResultModel> approveOrRejectLeaveRequest(
    @Body() ChangeRequestLeaveStatus body,
  );

  // Tasks
  @GET(ApiConstants.tasks)
  Future<TasksResponseModel> getTasks();

  @GET('${ApiConstants.tasks}/department/{departmentId}')
  Future<TasksResponseModel> getTasksByDepartment(
    @Path('departmentId') int departmentId,
  );

  @POST(ApiConstants.tasks)
  Future<ResultModel> addTask(@Body() AddTaskRequestBody body);

  @PUT('${ApiConstants.tasks}/{id}')
  Future<ResultModel> editTask(
    @Path('id') int id,
    @Body() AddTaskRequestBody body,
  );

  @DELETE('${ApiConstants.tasks}/{id}')
  Future<ResultModel> deleteTask(@Path('id') int id);

  @POST('${ApiConstants.tasks}/assignTask')
  Future<ResultModel> assignTask(@Body() AssignTaskRequestBody body);

  @PUT('${ApiConstants.tasks}/updateStatus')
  Future<ResultModel> updateTaskStatus(
    @Body() SupervisorUpdateTaskStatusRequestBody body,
  );

  // Plans
  @GET(ApiConstants.plans)
  Future<PlansResponseModel> getPlans();

  @GET('${ApiConstants.plans}/department/{departmentId}')
  Future<PlansResponseModel> getPlansByDepartment(
    @Path('departmentId') int departmentId,
  );

  @GET('${ApiConstants.plans}/customerPlan/departmentId/{departmentId}')
  Future<PlansResponseModel> getCustomerPlansByDepartment(
    @Path('departmentId') int departmentId,
  );

  @POST(ApiConstants.plans)
  Future<ResultModel> createPlan(@Body() CreatePlanRequestBody body);

  @DELETE('${ApiConstants.plans}/{id}')
  Future<ResultModel> deletePlan(@Path('id') int id);

  // Team
  @GET(ApiConstants.employees)
  Future<EmployeesResponseModel> getEmployees({
    @Query('itemCount') int itemCount = 100,
    @Query('index') int index = 0,
  });

  @GET('${ApiConstants.employees}/departmentId/{id}')
  Future<EmployeesResponseModel> getEmployeesInDepartment(@Path('id') int id);

  @GET('${ApiConstants.employees}/search/{searchKey}')
  Future<EmployeesResponseModel> searchEmployees(
    @Path('searchKey') String searchKey,
  );

  @GET('${ApiConstants.employees}/{id}')
  Future<SingleEmployeeResponseModel> getEmployeeById(@Path('id') String id);
}
