import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:check_point_v2/core/network/api_constants.dart';
import 'package:check_point_v2/features/auth/data/models/login/result_model.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/add_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employees_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/police_model.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/shift_model.dart';
import 'package:check_point_v2/features/admin/data/models/device/pending_device_model.dart';

part 'admin_api_service.g.dart';

@RestApi()
abstract class AdminApiService {
  factory AdminApiService(Dio dio, {String? baseUrl}) = _AdminApiService;
  
  @GET('/api/v2/employees/{id}/devices')
  Future<PendingDevicesResponseModel> getEmployeeDevices(
    @Path('id') String employeeId,
  );

  @GET('/api/v2/devices/pending')
  Future<PendingDevicesResponseModel> getPendingDevices();

  @POST('/api/v2/employees/{id}/devices')
  Future<ResultModel> approveDevice(
    @Path('id') String employeeId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/employees/{employeeId}/devices/{deviceId}')
  Future<ResultModel> rejectDevice(
    @Path('employeeId') String employeeId,
    @Path('deviceId') String deviceId,
  );


  // Employee Management
  @GET(ApiConstants.employees)
  Future<EmployeesResponseModel> getEmployees({
    @Query('itemCount') int itemCount = 20,
    @Query('index') int index = 0,
  });

  @GET('${ApiConstants.employees}/search/{searchKey}')
  Future<EmployeesResponseModel> searchEmployees(
    @Path('searchKey') String searchKey,
  );

  @GET('${ApiConstants.employees}/departmentId/{id}')
  Future<EmployeesResponseModel> getEmployeesInDepartment(@Path('id') int id);

  @POST(ApiConstants.employees)
  Future<ResultModel> addEmployee(@Body() AddEmployeeRequestBody body);

  @PUT('${ApiConstants.employees}/{id}')
  Future<ResultModel> editEmployee(
    @Path('id') String id,
    @Body() EditEmployeeRequestBody body,
  );

  @DELETE('${ApiConstants.deleteEmployee}/{userId}')
  Future<ResultModel> deleteEmployee(@Path('userId') String userId);

  @POST(
    '${ApiConstants.employees}/employeeId/{supervisorId}/attendancePermission/{permission}',
  )
  Future<ResultModel> setAttendancePermission(
    @Path('supervisorId') String supervisorId,
    @Path('permission') bool permission,
  );

  @POST(
    '${ApiConstants.employees}/employeeId/{supervisorId}/planPermission/{permission}',
  )
  Future<ResultModel> setPlanPermission(
    @Path('supervisorId') String supervisorId,
    @Path('permission') bool permission,
  );

  // Account Requests
  @GET(ApiConstants.accountRequests)
  Future<AccountRequestsResponseModel> getAccountRequests({
    @Query('itemCount') int itemCount = 20,
    @Query('index') int index = 0,
  });

  @PUT('${ApiConstants.accountRequests}/{id}')
  Future<ResultModel> updateAccountRequest(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.accountRequests)
  Future<ResultModel> deleteAccountRequest(@Query('id') int id);

  // Departments
  @GET(ApiConstants.departments)
  Future<DepartmentResponseModel> getDepartments({
    @Query('itemCount') int itemCount = 50,
    @Query('index') int index = 0,
  });

  @GET('${ApiConstants.departments}/search/{searchKey}')
  Future<DepartmentResponseModel> searchDepartments(
    @Path('searchKey') String searchKey,
  );

  @POST(ApiConstants.departments)
  Future<ResultModel> addDepartment(@Body() DepartmentRequestModel request);

  @PUT('${ApiConstants.departments}/{id}')
  Future<ResultModel> editDepartment(
    @Path('id') int id,
    @Body() DepartmentRequestModel request,
  );

  @DELETE(ApiConstants.departments)
  Future<ResultModel> deleteDepartment(@Query('id') int id);

  // Branches
  @GET(ApiConstants.branches)
  Future<BranchResponseModel> getBranches();

  @POST(ApiConstants.branches)
  Future<ResultModel> addBranch(@Body() BranchRequestModel request);

  @PUT('${ApiConstants.branches}/{id}')
  Future<ResultModel> editBranch(
    @Path('id') int id,
    @Body() BranchRequestModel request,
  );

  @DELETE('${ApiConstants.branches}/{id}')
  Future<ResultModel> deleteBranch(@Path('id') int id);

  // Customers
  @GET('${ApiConstants.customers}/customerType/{type}')
  Future<CustomerResponseModel> getCustomersByType(@Path('type') String type);

  @POST(ApiConstants.customers)
  Future<ResultModel> addCustomer(@Body() CustomerRequestModel request);

  @PUT('${ApiConstants.customers}/{id}')
  Future<ResultModel> editCustomer(
    @Path('id') String id,
    @Body() CustomerRequestModel request,
  );

  @DELETE(ApiConstants.customers)
  Future<ResultModel> deleteCustomer(@Query('id') String id);

  // Shifts
  @GET(ApiConstants.shifts)
  Future<ShiftResponseModel> getShifts();

  @POST(ApiConstants.shifts)
  Future<ResultModel> addShift(@Body() AddShiftRequestBody body);

  @PUT('${ApiConstants.shifts}/{id}')
  Future<ResultModel> editShift(
    @Path('id') int id,
    @Body() AddShiftRequestBody body,
  );

  @DELETE(ApiConstants.shifts)
  Future<ResultModel> deleteShift(@Query('id') int id);

  @POST('${ApiConstants.shifts}/assignShift')
  Future<ResultModel> assignShift(@Body() AssignShiftsRequestBody body);

  // Policies
  @GET('${ApiConstants.policies}/shift/{shiftId}')
  Future<PoliceResponseModel> getPoliciesByShift(@Path('shiftId') int shiftId);

  @POST(ApiConstants.policies)
  Future<ResultModel> addPolicy(@Body() AddPoliceRequestBody body);

  @PUT('${ApiConstants.policies}/{id}')
  Future<ResultModel> editPolicy(
    @Path('id') int id,
    @Body() AddPoliceRequestBody body,
  );

  @DELETE(ApiConstants.policies)
  Future<ResultModel> deletePolicy(@Query('id') int id);

  @POST('${ApiConstants.policies}/assignPolicy')
  Future<ResultModel> assignPolicy(@Body() AssignPoliceRequestBody body);

  @POST('${ApiConstants.employees}/removeAssignPolicy')
  Future<ResultModel> removeAssignPolicy(
    @Body() RemoveAssignPolicyRequestBody body,
  );

  // Leave Requests
  @GET(ApiConstants.leaveRequests)
  Future<LeaveRequestsResponseModel> getAllLeaveRequests();

  @PUT('${ApiConstants.leaveRequests}/leaveRequestStatus')
  Future<ResultModel> approveOrRejectLeaveRequest(
    @Body() ChangeRequestLeaveStatus body,
  );

  @DELETE('${ApiConstants.leaveRequests}/{id}')
  Future<ResultModel> deleteLeaveRequest(@Path('id') int id);

  // Leave Types
  @GET(ApiConstants.leaveTypes)
  Future<LeaveTypesResponseModel> getLeaveTypes();

  @POST(ApiConstants.leaveTypes)
  Future<ResultModel> addLeaveType(@Body() AddLeaveTypeRequestBody body);

  @PUT('${ApiConstants.leaveTypes}/{id}')
  Future<ResultModel> editLeaveType(
    @Path('id') int id,
    @Body() AddLeaveTypeRequestBody body,
  );

  @DELETE(ApiConstants.leaveTypes)
  Future<ResultModel> deleteLeaveType(@Query('id') int id);

  // Attendance
  @GET(ApiConstants.attendance)
  Future<AttendanceResponseModel> getAdminAttendance({
    @Query('itemCount') int itemCount = 1000,
    @Query('index') int index = 0,
  });

  @DELETE('${ApiConstants.attendance}/{id}')
  Future<ResultModel> deleteAttendance(@Path('id') int id);

  // Tasks
  @GET(ApiConstants.tasks)
  Future<TasksResponseModel> getTasks({
    @Query('itemCount') int itemCount = 100,
    @Query('index') int index = 0,
  });

  @GET('${ApiConstants.tasks}/department/{departmentId}')
  Future<TasksResponseModel> getTasksByDepartment(
    @Path('departmentId') int departmentId,
  );

  @GET('${ApiConstants.tasks}/specificEmployee')
  Future<TasksListResponseModel> getTasksByEmployee(
    @Query('employeeId') String employeeId,
  );

  @POST(ApiConstants.tasks)
  Future<ResultModel> addTask(@Body() AddTaskRequestBody body);

  @PUT('${ApiConstants.tasks}/{id}')
  Future<ResultModel> editTask(
    @Path('id') int id,
    @Body() AddTaskRequestBody body,
  );

  @DELETE(ApiConstants.tasks)
  Future<ResultModel> deleteTask(@Query('id') int id);

  @POST('${ApiConstants.tasks}/assignTask')
  Future<ResultModel> assignTask(@Body() AssignTaskRequestBody body);

  // Plans
  @GET(ApiConstants.plans)
  Future<PlansResponseModel> getPlans();

  @POST(ApiConstants.plans)
  Future<ResultModel> createPlan(@Body() CreatePlanRequestBody body);
}
