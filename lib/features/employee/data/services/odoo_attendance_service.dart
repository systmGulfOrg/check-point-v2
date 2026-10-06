import 'package:dio/dio.dart';

import 'package:check_point_v2/core/app/app_config.dart';

class OdooAttendanceService {
  OdooAttendanceService({required this.dio});

  final Dio dio;

  String _getOdooLocation(String area) {
    switch (area.trim().toLowerCase()) {
      case 'office':
        return 'office';
      case 'customer':
        return 'customer';
      case 'site':
        return 'site';
      default:
        return 'site';
    }
  }

  Options get _options => Options(
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (AppConfig.odooApiKey.isNotEmpty) 'API-KEY': AppConfig.odooApiKey,
    },
  );

  String get _baseUrl => AppConfig.odooBaseUrl;

  Future<bool> syncCheckIn({
    required String employeeIdStr,
    required String area,
  }) async {
    if (employeeIdStr.isEmpty) return false;
    final String location = _getOdooLocation(area);
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '$_baseUrl/api/attendance/check_in',
        data: {'mobile_employee_id': employeeIdStr, 'location': location},
        options: _options,
      );
      return response.data?['success'] ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> syncCheckOut({required String employeeIdStr}) async {
    if (employeeIdStr.isEmpty) return false;
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '$_baseUrl/api/attendance/check_out',
        data: {'mobile_employee_id': employeeIdStr},
        options: _options,
      );
      return response.data?['success'] ?? false;
    } catch (_) {
      return false;
    }
  }
}
