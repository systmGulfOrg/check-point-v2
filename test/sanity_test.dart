import 'package:flutter_test/flutter_test.dart';

import 'package:check_point_v2/core/app/app_config.dart';
import 'package:check_point_v2/core/routes/routes.dart';

void main() {
  test('routes are defined', () {
    expect(AppRoutes.login, '/login');
    expect(AppRoutes.requestAccess, '/request-access');
  });

  test('AppConfig baseUrl is set to production server', () {
    expect(AppConfig.baseUrl, 'http://137.184.223.222');
  });
}
