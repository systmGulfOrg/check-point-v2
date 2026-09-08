import 'package:dio/dio.dart';

import 'package:check_point_v2/core/app/app_config.dart';

class OdooLeaveType {
  final int id;
  final String name;
  final bool requiresAllocation;

  OdooLeaveType({
    required this.id,
    required this.name,
    required this.requiresAllocation,
  });

  factory OdooLeaveType.fromJson(Map<String, dynamic> json) {
    return OdooLeaveType(
      id: json['id'] as int,
      name: json['name'] as String,
      requiresAllocation:
          json['requires_allocation'] == 'yes' ||
          json['requires_allocation'] == true,
    );
  }
}

class OdooPublicHoliday {
  final int id;
  final String name;
  final String dateFrom;
  final String dateTo;

  OdooPublicHoliday({
    required this.id,
    required this.name,
    required this.dateFrom,
    required this.dateTo,
  });

  factory OdooPublicHoliday.fromJson(Map<String, dynamic> json) {
    return OdooPublicHoliday(
      id: json['id'] as int,
      name: json['name'] as String,
      dateFrom: json['date_from'] as String,
      dateTo: json['date_to'] as String,
    );
  }
}

class OdooAttendanceLog {
  final int id;
  final String employeeId;
  final String employeeName;
  final String location;
  final String checkIn;
  final String? checkOut;
  final double workedHours;

  OdooAttendanceLog({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.location,
    required this.checkIn,
    this.checkOut,
    required this.workedHours,
  });

  factory OdooAttendanceLog.fromJson(Map<String, dynamic> json) {
    return OdooAttendanceLog(
      id: json['id'] as int,
      employeeId: json['employee_id'] as String? ?? '',
      employeeName: json['employee_name'] as String? ?? '',
      location: json['location'] as String? ?? 'site',
      checkIn: json['check_in'] as String,
      checkOut: json['check_out'] as String?,
      workedHours: (json['worked_hours'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class OdooMyAttendanceData {
  final String employeeId;
  final String employeeName;
  final String period;
  final String dateFrom;
  final String dateTo;
  final int count;
  final double totalWorkedHours;
  final List<OdooAttendanceLog> attendances;

  OdooMyAttendanceData({
    required this.employeeId,
    required this.employeeName,
    required this.period,
    required this.dateFrom,
    required this.dateTo,
    required this.count,
    required this.totalWorkedHours,
    required this.attendances,
  });

  factory OdooMyAttendanceData.fromJson(Map<String, dynamic> json) {
    final list = json['attendances'] as List? ?? [];
    return OdooMyAttendanceData(
      employeeId: json['employee_id'] as String? ?? '',
      employeeName: json['employee_name'] as String? ?? '',
      period: json['period'] as String? ?? 'month',
      dateFrom: json['date_from'] as String? ?? '',
      dateTo: json['date_to'] as String? ?? '',
      count: json['count'] as int? ?? 0,
      totalWorkedHours: (json['total_worked_hours'] as num?)?.toDouble() ?? 0.0,
      attendances: list.map((e) => OdooAttendanceLog.fromJson(e)).toList(),
    );
  }
}

class OdooLeaveRequest {
  final int id;
  final String employeeId;
  final String employeeName;
  final int leaveTypeId;
  final String leaveTypeName;
  final String dateFrom;
  final String dateTo;
  final double numberOfDays;
  final String reason;
  final String state;

  OdooLeaveRequest({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.leaveTypeId,
    required this.leaveTypeName,
    required this.dateFrom,
    required this.dateTo,
    required this.numberOfDays,
    required this.reason,
    required this.state,
  });

  factory OdooLeaveRequest.fromJson(Map<String, dynamic> json) {
    return OdooLeaveRequest(
      id: json['id'] as int,
      employeeId:
          (json['employee_id'] ?? json['mobile_employee_id'] ?? '') as String,
      employeeName: json['employee_name'] as String? ?? '',
      leaveTypeId: json['leave_type_id'] as int,
      leaveTypeName: json['leave_type_name'] as String? ?? '',
      dateFrom: json['date_from'] as String,
      dateTo: json['date_to'] as String,
      numberOfDays: (json['number_of_days'] as num?)?.toDouble() ?? 0.0,
      reason: json['reason'] as String? ?? '',
      state: json['state'] as String? ?? '',
    );
  }
}

class OdooTimeOffService {
  OdooTimeOffService({required this.dio});

  final Dio dio;

  Options get _options => Options(
        headers: {
          'Accept': 'application/json',
          if (AppConfig.odooApiKey.isNotEmpty) 'API-KEY': AppConfig.odooApiKey,
        },
      );

  String get _baseUrl => AppConfig.odooBaseUrl;

  Future<List<OdooLeaveType>> getLeaveTypes() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '$_baseUrl/api/timeoff/types',
        options: _options,
      );
      if (response.data != null && response.data!['success'] == true) {
        final list = response.data!['data']['leave_types'] as List;
        return list.map((e) => OdooLeaveType.fromJson(e)).toList();
      }
      throw Exception('Failed to get leave types');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OdooPublicHoliday>> getPublicHolidays({
    String? dateFrom,
    String? dateTo,
  }) async {
    final Map<String, dynamic> queryParams = {};
    if (dateFrom != null) queryParams['date_from'] = dateFrom;
    if (dateTo != null) queryParams['date_to'] = dateTo;
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '$_baseUrl/api/timeoff/public_holidays',
        queryParameters: queryParams,
        options: _options,
      );
      if (response.data != null && response.data!['success'] == true) {
        final list = response.data!['data']['public_holidays'] as List;
        return list.map((e) => OdooPublicHoliday.fromJson(e)).toList();
      }
      throw Exception('Failed to get public holidays');
    } catch (e) {
      rethrow;
    }
  }

  Future<OdooLeaveRequest> submitLeaveRequest({
    required String employeeId,
    required int leaveTypeId,
    required String dateFrom,
    required String dateTo,
    String? reason,
  }) async {
    final Map<String, dynamic> requestBody = {
      'mobile_employee_id': employeeId,
      'leave_type_id': leaveTypeId,
      'date_from': dateFrom,
      'date_to': dateTo,
      if (reason != null && reason.isNotEmpty) 'reason': reason,
    };
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '$_baseUrl/api/timeoff/request',
        data: requestBody,
        options: _options,
      );
      if (response.data != null && response.data!['success'] == true) {
        return OdooLeaveRequest.fromJson(response.data!['data']);
      }
      throw Exception('Failed to submit leave request');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OdooLeaveRequest>> getMyLeaveRequests({
    required String employeeId,
    String? state,
    int limit = 20,
  }) async {
    final Map<String, dynamic> queryParams = {
      'mobile_employee_id': employeeId,
      'limit': limit,
      if (state != null && state.isNotEmpty) 'state': state,
    };
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '$_baseUrl/api/timeoff/my_requests',
        queryParameters: queryParams,
        options: _options,
      );
      if (response.data != null && response.data!['success'] == true) {
        final list = response.data!['data']['requests'] as List;
        return list.map((e) => OdooLeaveRequest.fromJson(e)).toList();
      }
      throw Exception('Failed to fetch leave requests');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getAttendanceStatus({
    required String employeeId,
  }) async {
    final Map<String, dynamic> queryParams = {'employee_id': employeeId};
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '$_baseUrl/api/attendance/status',
        queryParameters: queryParams,
        options: _options,
      );
      if (response.data != null && response.data!['success'] == true) {
        return response.data!['data'] as Map<String, dynamic>;
      }
      throw Exception('Failed to get attendance status');
    } catch (e) {
      rethrow;
    }
  }

  Future<OdooMyAttendanceData> getMyAttendance({
    required String employeeId,
    required String period,
    String? year,
    String? month,
    String? week,
    String? dateFrom,
    String? dateTo,
  }) async {
    final Map<String, dynamic> queryParams = {
      'employee_id': employeeId,
      'period': period,
      'year': ?year,
      'month': ?month,
      'week': ?week,
      'date_from': ?dateFrom,
      'date_to': ?dateTo,
    };
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '$_baseUrl/api/attendance/my_attendance',
        queryParameters: queryParams,
        options: _options,
      );
      if (response.data != null && response.data!['success'] == true) {
        return OdooMyAttendanceData.fromJson(response.data!['data']);
      }
      throw Exception('Failed to get my attendance');
    } catch (e) {
      rethrow;
    }
  }
}
