import 'dart:async';
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/database/app_database.dart';
import 'package:check_point_v2/core/database/cache_manager.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
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
import 'package:check_point_v2/features/employee/data/models/plans/employee_plan_feedback_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/plans/employee_remove_plan_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/track_user_request_body.dart';
import 'package:check_point_v2/features/employee/data/services/odoo_attendance_service.dart';
import 'employee_attendance_repo.dart';

class EmployeeAttendanceRepoImpl implements EmployeeAttendanceRepo {
  EmployeeAttendanceRepoImpl({
    required this.api,
    required this.odooAttendanceService,
    CacheManager? cacheManager,
  }) : cacheManager = cacheManager ?? CacheManager(sl<AppDatabase>());

  final EmployeeApiService api;
  final OdooAttendanceService odooAttendanceService;
  final CacheManager cacheManager;

  @override
  Future<ApiResult<BranchModel>> getBranchById(int branchId) async {
    try {
      final response = await api.getBranchById(branchId);
      final branch = response.value?.list.firstOrNull;
      if (branch != null) {
        final branchMap = {
          'id': branch.id,
          'name': branch.name,
          'location': branch.location,
          'description': branch.description,
          'coordinates': branch.coordinates?.map((c) => {
            'latitude': c.latitude,
            'longitude': c.longitude,
          }).toList(),
        };
        await cacheManager.putJson('branch_$branchId', branchMap);
        return ApiResult.success(branch);
      }
      return const ApiResult.failure(
        ApiFailure(messageKey: 'Branch not found'),
      );
    } catch (e) {
      // 1. Try single cached branch
      final cached = await cacheManager.getJson('branch_$branchId');
      if (cached is Map) {
        try {
          final branch = BranchModel.fromJson(Map<String, dynamic>.from(cached));
          return ApiResult.success(branch);
        } catch (_) {}
      }
      // 2. Try looking inside full cached branches list
      final cachedList = await cacheManager.getJson('branches');
      if (cachedList is List && cachedList.isNotEmpty) {
        try {
          final branches = cachedList
              .map((item) => BranchModel.fromJson(Map<String, dynamic>.from(item as Map)))
              .toList();
          final matching = branches.where((b) => b.id == branchId).firstOrNull;
          if (matching != null) return ApiResult.success(matching);
          if (branches.isNotEmpty) return ApiResult.success(branches.first);
        } catch (_) {}
      }
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<BranchModel>>> getBranches() async {
    try {
      final response = await api.getBranches();
      final branches = response.value?.list ?? [];
      // Cache branches for offline use
      final branchMaps = branches.map((b) => {
        'id': b.id,
        'name': b.name,
        'location': b.location,
        'description': b.description,
        'coordinates': b.coordinates?.map((c) => {
          'latitude': c.latitude,
          'longitude': c.longitude,
        }).toList(),
      }).toList();
      await cacheManager.putJson('branches', branchMaps);
      // Also cache each branch individually by ID
      for (final b in branches) {
        if (b.id != null) {
          final singleMap = {
            'id': b.id,
            'name': b.name,
            'location': b.location,
            'description': b.description,
            'coordinates': b.coordinates?.map((c) => {
              'latitude': c.latitude,
              'longitude': c.longitude,
            }).toList(),
          };
          await cacheManager.putJson('branch_${b.id}', singleMap);
        }
      }
      return ApiResult.success(branches);
    } catch (e) {
      // Fallback to cache if network fails
      final cached = await cacheManager.getJson('branches');
      if (cached is List && cached.isNotEmpty) {
        try {
          final branches = cached
              .map((item) => BranchModel.fromJson(Map<String, dynamic>.from(item as Map)))
              .toList();
          return ApiResult.success(branches);
        } catch (_) {}
      }
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
      // Cache employee profile
      await cacheManager.putJson('employee_$employeeId', employee.toJson());
      if (employee.branchId != null) {
        unawaited(getBranchById(employee.branchId!));
      }
      return ApiResult.success(employee);
    } catch (e) {
      // Fallback to cache
      final cached = await cacheManager.getJson('employee_$employeeId');
      if (cached is Map) {
        try {
          final employee = EmployeeModel.fromJson(Map<String, dynamic>.from(cached));
          return ApiResult.success(employee);
        } catch (_) {}
      }
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
      final customers = response.value?.list ?? [];
      // Cache customers
      final customerMaps = customers.map((c) => {
        'id': c.id,
        'name': c.name,
        'workesAs': c.workesAs,
        'location': c.location,
        'customerType': c.customerType,
        'coordinates': c.coordinates?.map((coord) => {
          'latitude': coord.latitude,
          'longitude': coord.longitude,
        }).toList(),
      }).toList();
      await cacheManager.putJson('customers_$type', customerMaps);
      return ApiResult.success(customers);
    } catch (e) {
      // Fallback to cache
      final cached = await cacheManager.getJson('customers_$type');
      if (cached is List && cached.isNotEmpty) {
        try {
          final customers = cached
              .map((item) => CustomerModel.fromJson(Map<String, dynamic>.from(item as Map)))
              .toList();
          return ApiResult.success(customers);
        } catch (_) {}
      }
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
      final response = await api.checkIn(body);
      final model = _parseCheckInResponse(response, body);
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
        await odooAttendanceService.syncCheckOut(
          employeeIdStr: body.employeeId,
        );
      } catch (_) {}
      final response = await api.checkOut(body);
      final model = _parseCheckOutResponse(response, body);
      return ApiResult.success(model);
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
        itemCount: itemCount,
        index: pageIndex * itemCount,
      );
      final list = response.value?.list ?? [];
      if (pageIndex == 0 && list.isNotEmpty) {
        await cacheManager.putJson(
          'attendance_history_$employeeId',
          list.map((a) => a.toJson()).toList(),
        );
      }
      return ApiResult.success(list);
    } catch (e) {
      if (pageIndex == 0) {
        final cached = await cacheManager.getJson('attendance_history_$employeeId');
        if (cached is List && cached.isNotEmpty) {
          try {
            final list = cached
                .map((item) => AdminAttendanceModel.fromJson(Map<String, dynamic>.from(item as Map)))
                .toList();
            return ApiResult.success(list);
          } catch (_) {}
        }
      }
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
