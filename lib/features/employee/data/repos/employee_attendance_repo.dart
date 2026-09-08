import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_in_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_out_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/plans/employee_plan_feedback_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/plans/employee_remove_plan_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/track_user_request_body.dart';

abstract class EmployeeAttendanceRepo {
  Future<ApiResult<BranchModel>> getBranchById(int branchId);
  Future<ApiResult<List<BranchModel>>> getBranches();
  Future<ApiResult<EmployeeModel>> getEmployeeById(String employeeId);
  Future<ApiResult<List<AdminPlanModel>>> getCustomerPlansForEmployee(
    String employeeId,
  );
  Future<ApiResult<List<CustomerModel>>> getCustomersByType(String type);
  Future<ApiResult<AdminAttendanceModel>> checkIn(
    EmployeeCheckInRequestBody body,
  );
  Future<ApiResult<AdminAttendanceModel>> checkInWithoutPlan(
    EmployeeCheckInRequestBody body,
  );
  Future<ApiResult<AdminAttendanceModel>> checkOut(
    EmployeeCheckOutRequestBody body,
  );
  Future<ApiResult<AdminAttendanceModel>> checkOutWithoutPlan(
    EmployeeCheckOutRequestBody body,
  );
  Future<ApiResult<List<AdminAttendanceModel>>> getAttendanceHistory({
    required String employeeId,
    int pageIndex = 0,
    int itemCount = 10,
  });
  Future<ApiResult<AdminPlanModel>> getPlanById(int id);
  Future<ApiResult<void>> addPlanFeedback(EmployeePlanFeedbackRequestBody body);
  Future<ApiResult<void>> trackEmployeeLocation(TrackUserRequestBody body);
  Future<ApiResult<void>> removeAssignCustomerPlan(
    EmployeeRemovePlanRequestBody body,
  );
  Future<ApiResult<List<String>>> getFeedbackStatuses();
  double checkAccessibleAreaForCircle(LatLng center, LatLng point);
  bool checkAccessibleAreaForPolygon(LatLng point, List<LatLng> polygon);
}
