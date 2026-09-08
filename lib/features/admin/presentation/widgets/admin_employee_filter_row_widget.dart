import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_employee_filter_pill_widget.dart';

class AdminEmployeeFilterRowWidget extends StatelessWidget {
  const AdminEmployeeFilterRowWidget({
    required this.selectedFilter,
    required this.onFilterSelected,
    super.key,
  });

  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  static const _filters = <String>[
    'admin.employees.filterAll',
    'admin.employees.filterEmployee',
    'admin.employees.filterSupervisor',
    'admin.employees.filterAdmin',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < _filters.length; i++) ...[
            if (i > 0) vSpace(8),
            AdminEmployeeFilterPillWidget(
              labelKey: _filters[i],
              isSelected: selectedFilter == _filters[i],
              onTap: () => onFilterSelected(_filters[i]),
            ),
          ],
        ],
      ),
    );
  }
}
