import 'package:flutter_test/flutter_test.dart';

import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';

void main() {
  test('serializes the employee username using the API field name', () {
    final body = EditEmployeeRequestBody(
      name: 'Ali Hassan',
      userName: 'ali@example.com',
      password: '',
      position: 'Supervisor',
      mobileId: 'device-1',
      role: 'Supervisor',
      departmentId: 1,
      branchId: 2,
    );

    final json = body.toJson();

    expect(json['username'], 'ali@example.com');
    expect(json.containsKey('userName'), isFalse);
  });
}
