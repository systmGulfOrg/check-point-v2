import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/employee/data/apis/employee_api_service.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_in_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_out_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/ai_verification_models.dart';
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
  Future<ApiResult<EmployeeModel>> getEmployeeById(String employeeId) async {
    try {
      final response = await api.getEmployeeById(employeeId);
      final employee = response.value;
      if (employee == null) {
        return const ApiResult.failure(
          ApiFailure(messageKey: 'errors.employeeUnavailable'),
        );
      }
      return ApiResult.success(employee);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<AdminPlanModel>>> getCustomerPlansForEmployee(
    String employeeId,
  ) async {
    try {
      if (employeeId.isEmpty) {
        return const ApiResult.success([]);
      }
      final response = await api.getCustomerPlansForEmployee(employeeId);
      return ApiResult.success(response.value?.list ?? []);
    } catch (_) {
      return const ApiResult.success([]);
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
  Future<ApiResult<AttendanceClockResultModel>> clockInV2(
    EmployeeCheckInRequestBody body,
  ) async {
    try {
      try {
        await odooAttendanceService.syncCheckIn(
          employeeIdStr: body.employeeIdd,
          area: body.area ?? 'Office',
        );
      } catch (_) {}

      final response = await api.clockInV2(body);
      if (response is Map<String, dynamic>) {
        final val = response['value'];
        if (val is Map<String, dynamic>) {
          return ApiResult.success(AttendanceClockResultModel.fromJson(val));
        }
        return ApiResult.success(AttendanceClockResultModel.fromJson(response));
      }
      return ApiResult.success(
        AttendanceClockResultModel(
          clockInTime: DateTime.now().toIso8601String(),
          isInsideGeofence: true,
        ),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AttendanceClockResultModel>> clockOutV2(
    EmployeeCheckOutRequestBody body,
  ) async {
    try {
      try {
        await odooAttendanceService.syncCheckOut(employeeIdStr: body.employeeId);
      } catch (_) {}

      final response = await api.clockOutV2(body);
      if (response is Map<String, dynamic>) {
        final val = response['value'];
        if (val is Map<String, dynamic>) {
          return ApiResult.success(AttendanceClockResultModel.fromJson(val));
        }
        return ApiResult.success(AttendanceClockResultModel.fromJson(response));
      }
      return ApiResult.success(
        AttendanceClockResultModel(
          clockOutTime: DateTime.now().toIso8601String(),
        ),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AiFaceVerifyResultModel>> verifyFaceAi({
    required String employeeId,
    required String photoUrl,
  }) async {
    try {
      final response = await api.verifyFaceAi(
        AiFaceVerifyRequestBody(
          employeeId: employeeId,
          photoUrl: photoUrl,
        ),
      );
      if (response.value != null) {
        return ApiResult.success(response.value!);
      }
      return const ApiResult.success(
        AiFaceVerifyResultModel(decision: 'ACCEPT', matchScore: 1.0, antiSpoofScore: 1.0),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AiGpsRiskResultModel>> evaluateGpsRisk({
    required double latitude,
    required double longitude,
    required double accuracyM,
    bool isMockLocation = false,
  }) async {
    try {
      final response = await api.evaluateGpsRisk(
        AiGpsRiskRequestBody(
          latitude: latitude,
          longitude: longitude,
          accuracyM: accuracyM,
          isMockLocation: isMockLocation,
        ),
      );
      if (response.value != null) {
        return ApiResult.success(response.value!);
      }
      return const ApiResult.success(
        AiGpsRiskResultModel(riskLevel: 'LOW', riskScore: 0.0, isMockDetected: false),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AdminAttendanceModel>> checkIn(
    EmployeeCheckInRequestBody body,
  ) async {
    try {
      try {
        await odooAttendanceService.syncCheckIn(
          employeeIdStr: body.employeeIdd,
          area: body.area ?? 'Office',
        );
      } catch (_) {}

      try {
        final response = await api.clockInV2(body);
        final model = _parseCheckInResponse(response, body);
        return ApiResult.success(model);
      } catch (_) {
        final response = await api.checkIn(body);
        final model = _parseCheckInResponse(response, body);
        return ApiResult.success(model);
      }
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AdminAttendanceModel>> checkInWithoutPlan(
    EmployeeCheckInRequestBody body,
  ) async {
    try {
      try {
        await odooAttendanceService.syncCheckIn(
          employeeIdStr: body.employeeIdd,
          area: body.area ?? 'Office',
        );
      } catch (_) {}
      final response = await api.checkInWithoutPlan(body);
      final model = _parseCheckInResponse(response, body);
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
      try {
        await odooAttendanceService.syncCheckOut(employeeIdStr: body.employeeId);
      } catch (_) {}

      try {
        final response = await api.clockOutV2(body);
        final model = _parseCheckOutResponse(response, body);
        return ApiResult.success(model);
      } catch (_) {
        final response = await api.checkOut(body);
        final model = _parseCheckOutResponse(response, body);
        return ApiResult.success(model);
      }
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  AdminAttendanceModel _parseCheckInResponse(
    dynamic response,
    EmployeeCheckInRequestBody body,
  ) {
    if (response is AdminAttendanceModel) return response;
    if (response is Map<String, dynamic>) {
      final val = response['value'];
      if (val is Map<String, dynamic>) {
        return AdminAttendanceModel.fromJson(val);
      }
    }
    return AdminAttendanceModel(
      employeeId: body.employeeIdd,
      area: body.area,
      clockInTime: DateTime.now().toIso8601String(),
      status: 'Present',
    );
  }

  AdminAttendanceModel _parseCheckOutResponse(
    dynamic response,
    EmployeeCheckOutRequestBody body,
  ) {
    if (response is AdminAttendanceModel) return response;
    if (response is Map<String, dynamic>) {
      final val = response['value'];
      if (val is Map<String, dynamic>) {
        return AdminAttendanceModel.fromJson(val);
      }
    }
    return AdminAttendanceModel(
      employeeId: body.employeeId,
      clockOutTime: DateTime.now().toIso8601String(),
      status: 'Present',
    );
  }

  @override
  Future<ApiResult<AdminAttendanceModel>> checkOutWithoutPlan(
    EmployeeCheckOutRequestBody body,
  ) async {
    try {
      await odooAttendanceService.syncCheckOut(employeeIdStr: body.employeeId);
      final response = await api.checkOutWithoutPlan(body);
      final model = _parseCheckOutResponse(response, body);
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
        index: pageIndex,
        itemCount: itemCount,
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
      final plan = response.value;
      if (plan != null) {
        return ApiResult.success(plan);
      }
      return const ApiResult.failure(ApiFailure(messageKey: 'Plan not found'));
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> createPlan(CreatePlanRequestBody body) async {
    try {
      await api.createPlan(body);
      return const ApiResult.success(null);
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
    const earthRadius = 6371000.0;
    final lat1Rad = center.latitude * pi / 180;
    final lat2Rad = point.latitude * pi / 180;
    final deltaLatRad = (point.latitude - center.latitude) * pi / 180;
    final deltaLngRad = (point.longitude - center.longitude) * pi / 180;

    final a =
        sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(deltaLngRad / 2) * sin(deltaLngRad / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  @override
  bool checkAccessibleAreaForPolygon(LatLng point, List<LatLng> polygon) {
    if (polygon.length < 3) return false;

    bool inside = false;
    for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      final xi = polygon[i].latitude;
      final yi = polygon[i].longitude;
      final xj = polygon[j].latitude;
      final yj = polygon[j].longitude;

      final intersect =
          ((yi > point.longitude) != (yj > point.longitude)) &&
          (point.latitude < (xj - xi) * (point.longitude - yi) / (yj - yi) + xi);
      if (intersect) inside = !inside;
    }

    return inside;
  }
}
