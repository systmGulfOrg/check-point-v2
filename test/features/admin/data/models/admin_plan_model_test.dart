import 'package:flutter_test/flutter_test.dart';

import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';

void main() {
  test('maps the Plan API response fields used by the plans UI', () {
    final plan = AdminPlanModel.fromJson({
      'id': 7,
      'planDate': '2026-09-15T09:00:00Z',
      'note': 'Morning site inspection',
      'departmentId': 3,
      'departmentName': 'Operations',
    });

    expect(plan.id, 7);
    expect(plan.planDate, '2026-09-15T09:00:00Z');
    expect(plan.notes, 'Morning site inspection');
    expect(plan.departmentId, 3);
    expect(plan.departmentName, 'Operations');
  });
}
