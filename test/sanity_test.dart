import 'package:flutter_test/flutter_test.dart';

import 'package:check_point_v2/core/routes/routes.dart';

void main() {
  test('routes are defined', () {
    expect(AppRoutes.login, '/login');
    expect(AppRoutes.requestAccess, '/request-access');
  });
}
