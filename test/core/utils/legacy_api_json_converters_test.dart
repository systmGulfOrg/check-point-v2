import 'package:flutter_test/flutter_test.dart';

import 'package:check_point_v2/core/utils/legacy_api_json_converters.dart';

void main() {
  test('converts legacy .NET date and time objects to model strings', () {
    expect(
      legacyApiValueToString({'year': 2026, 'month': 9, 'day': 13}),
      '2026-09-13',
    );
    expect(
      legacyApiValueToString({'hour': 8, 'minute': 2, 'second': 47}),
      '08:02:47',
    );
  });

  test('keeps modern string response values unchanged', () {
    expect(legacyApiValueToString('08:02:47'), '08:02:47');
  });
}
