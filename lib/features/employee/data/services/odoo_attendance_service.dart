import 'package:dio/dio.dart';

class OdooAttendanceService {
  final Dio _dio;

  OdooAttendanceService()
      : _dio = Dio(
          BaseOptions(
            baseUrl:
                'https://masteameg-newenlighten-test-36387693.dev.odoo.com',
            headers: {
              'Accept': 'application/json',
              'API-KEY': 'jkashda_891273yubk_hjsda92',
            },
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );

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

  Future<bool> syncCheckIn({
    required String employeeIdStr,
    required String area,
  }) async {
    if (employeeIdStr.isEmpty) return false;
    final String location = _getOdooLocation(area);
    try {
      final response = await _dio.post(
        '/api/attendance/check_in',
        data: {
          'mobile_employee_id': employeeIdStr,
          'location': location,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
          contentType: Headers.jsonContentType,
        ),
      );
      return response.data?['success'] ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> syncCheckOut({
    required String employeeIdStr,
  }) async {
    if (employeeIdStr.isEmpty) return false;
    try {
      final response = await _dio.post(
        '/api/attendance/check_out',
        data: {'mobile_employee_id': employeeIdStr},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          contentType: Headers.jsonContentType,
        ),
      );
      return response.data?['success'] ?? false;
    } catch (_) {
      return false;
    }
  }
}
