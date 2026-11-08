import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/features/employee_record/data/models/employee_record_model.dart';
import 'employee_record_day_tile_widget.dart';

/// Loading shape that matches the day list.
class EmployeeRecordSkeletonWidget extends StatelessWidget {
  const EmployeeRecordSkeletonWidget({super.key});

  static final List<RecordDayModel> _days = List.generate(
    7,
    (i) => RecordDayModel(date: DateTime.utc(2026, 1, 1 + i), status: 'present', lateMinutes: 5),
  );

  @override
  Widget build(BuildContext context) => Skeletonizer(
    child: Column(
      children: [for (final day in _days) EmployeeRecordDayTileWidget(day: day)],
    ),
  );
}
