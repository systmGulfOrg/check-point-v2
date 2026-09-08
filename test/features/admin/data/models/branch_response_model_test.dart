import 'package:flutter_test/flutter_test.dart';

import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';

void main() {
  test('parses a single branch returned directly inside value', () {
    final response = BranchResponseModel.fromJson({
      'value': {
        'id': 1,
        'name': 'Main Branch',
        'location': 'Cairo',
        'description': 'Head office',
        'coordinates': [
          {'latitude': 30.0444, 'longitude': 31.2357},
        ],
      },
      'status': 200,
      'isSuccess': true,
      'errors': <String>[],
    });

    expect(response.value?.list, hasLength(1));
    expect(response.value?.list.first.id, 1);
    expect(response.value?.list.first.coordinates, hasLength(1));
  });
}
