import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/employee/data/apis/employee_api_service.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_in_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_out_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/plans/employee_plan_feedback_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/plans/employee_remove_plan_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/track_user_request_body.dart';
import 'package:check_point_v2/features/employee/data/services/odoo_attendance_service.dart';
import 'employee_attendance_repo.dart';

class EmployeeAttendanceRepoImpl implements EmployeeAttendanceRepo {
  EmployeeAttendanceRepoImpl({
    required this.api,
    required this.odooAttendanceService,
  });

  final EmployeeApiService api;
  final OdooAttendanceService odooAttendanceService;

  @override
  Future<ApiResult<BranchModel>> getBranchById(int branchId) async {
    try {
      final response = await api.getBranchById(branchId);
      final branch = response.value?.list.firstOrNull;
      if (branch != null) {
        return ApiResult.success(branch);
      }
      return const ApiResult.failure(
        ApiFailure(messageKey: 'Branch not found'),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<BranchModel>>> getBranches() async {
    try {
      final response = await api.getBranches();
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<AdminPlanModel>>> getCustomerPlansForEmployee(
    String employeeId,
  ) async {
    try {
      final response = await api.getCustomerPlansForEmployee(employeeId);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<CustomerModel>>> getCustomersByType(String type) async {
    try {
      final response = await api.getCustomersByType(type);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AdminAttendanceModel>> checkIn(
    EmployeeCheckInRequestBody body,
  ) async {
    try {
      await odooAttendanceService.syncCheckIn(
        employeeIdStr: body.employeeIdd,
        area: body.area ?? 'Office',
      );
      final model = await api.checkIn(body);
      return ApiResult.success(model);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AdminAttendanceModel>> checkInWithoutPlan(
    EmployeeCheckInRequestBody body,
  ) async {
    try {
      await odooAttendanceService.syncCheckIn(
        employeeIdStr: body.employeeIdd,
        area: body.area ?? 'Office',
      );
      final model = await api.checkInWithoutPlan(body);
      return ApiResult.success(model);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AdminAttendanceModel>> checkOut(
    EmployeeCheckOutRequestBody body,
  ) async {
    try {
      await odooAttendanceService.syncCheckOut(employeeIdStr: body.employeeId);
      final model = await api.checkOut(body);
      return ApiResult.success(model);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AdminAttendanceModel>> checkOutWithoutPlan(
    EmployeeCheckOutRequestBody body,
  ) async {
    try {
      await odooAttendanceService.syncCheckOut(employeeIdStr: body.employeeId);
      final model = await api.checkOutWithoutPlan(body);
      return ApiResult.success(model);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<AdminAttendanceModel>>> getAttendanceHistory({
    required String employeeId,
    int pageIndex = 0,
    int itemCount = 10,
  }) async {
    try {
      final response = await api.getAttendanceHistory(
        employeeId,
        itemCount: itemCount,
        index: pageIndex * itemCount,
      );
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AdminPlanModel>> getPlanById(int id) async {
    try {
      final response = await api.getPlanById(id);
      if (response.value != null) {
        return ApiResult.success(response.value!);
      }
      return const ApiResult.failure(ApiFailure(messageKey: 'Plan not found'));
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> addPlanFeedback(
    EmployeePlanFeedbackRequestBody body,
  ) async {
    try {
      await api.addPlanFeedback(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> trackEmployeeLocation(
    TrackUserRequestBody body,
  ) async {
    try {
      await api.trackLocation(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> removeAssignCustomerPlan(
    EmployeeRemovePlanRequestBody body,
  ) async {
    try {
      await api.removeAssignCustomerPlan(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<String>>> getFeedbackStatuses() async {
    try {
      final response = await api.getFeedbackStatuses();
      return ApiResult.success(response.value ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  double checkAccessibleAreaForCircle(LatLng center, LatLng point) {
    const double earthRadius = 6371000;
    final double lat1 = center.latitude * pi / 180;
    final double lon1 = center.longitude * pi / 180;
    final double lat2 = point.latitude * pi / 180;
    final double lon2 = point.longitude * pi / 180;

    final double dLat = lat2 - lat1;
    final double dLon = lon2 - lon1;

    final double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  @override
  bool checkAccessibleAreaForPolygon(LatLng point, List<LatLng> polygon) {
    if (polygon.isEmpty) return false;
    int intersectCount = 0;
    for (int i = 0; i < polygon.length; i++) {
      final j = (i + 1) % polygon.length;
      if ((polygon[i].longitude > point.longitude) !=
          (polygon[j].longitude > point.longitude)) {
        final double latComp =
            (polygon[j].latitude - polygon[i].latitude) *
                (point.longitude - polygon[i].longitude) /
                (polygon[j].longitude - polygon[i].longitude) +
            polygon[i].latitude;
        if (point.latitude < latComp) {
          intersectCount++;
        }
      }
    }
    return (intersectCount % 2) != 0;
  }
}
