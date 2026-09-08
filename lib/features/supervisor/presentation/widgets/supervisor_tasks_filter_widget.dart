import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'supervisor_segment_option_widget.dart';

class SupervisorTasksFilterWidget extends StatelessWidget {
  const SupervisorTasksFilterWidget({
    required this.selectedIndex,
    required this.onFilterSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onFilterSelected;

  static const _filters = <String>[
    'supervisor.tasks.filter.active',
    'supervisor.tasks.filter.done',
    'supervisor.tasks.filter.all',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.selectedBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          for (int i = 0; i < _filters.length; i++)
            Expanded(
              child: SupervisorSegmentOptionWidget(
                labelKey: _filters[i],
                labelArgs: const [],
                isSelected: selectedIndex == i,
                onTap: () => onFilterSelected(i),
              ),
            ),
        ],
      ),
    );
  }
}
