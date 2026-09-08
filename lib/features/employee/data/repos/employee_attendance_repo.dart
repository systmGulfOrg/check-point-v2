import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/network/api_result.dart';
import '../../../admin/data/models/admin_attendance_model.dart';
import '../../../admin/data/models/admin_plan_model.dart';
import '../../../admin/data/models/branch_response_model.dart';
import '../../../admin/data/models/customer_response_model.dart';
import '../models/employee_check_in_request_body.dart';
import '../models/employee_check_out_request_body.dart';
import '../models/employee_plan_feedback_request_body.dart';
import '../models/employee_remove_plan_request_body.dart';
import '../models/track_user_request_body.dart';

abstract class EmployeeAttendanceRepo {
  Future<ApiResult<BranchModel>> getBranchById(int branchId);
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
  Future<ApiResult<void>> addPlanFeedback(
    EmployeePlanFeedbackRequestBody body,
  );
  Future<ApiResult<void>> trackEmployeeLocation(TrackUserRequestBody body);
  Future<ApiResult<void>> removeAssignCustomerPlan(
    EmployeeRemovePlanRequestBody body,
  );
  Future<ApiResult<List<String>>> getFeedbackStatuses();
  double checkAccessibleAreaForCircle(LatLng center, LatLng point);
  bool checkAccessibleAreaForPolygon(LatLng point, List<LatLng> polygon);
}
