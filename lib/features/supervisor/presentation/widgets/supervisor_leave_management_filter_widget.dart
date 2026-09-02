import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'supervisor_segment_option_widget.dart';

class SupervisorLeaveManagementFilterWidget extends StatelessWidget {
  const SupervisorLeaveManagementFilterWidget({
    required this.selectedIndex,
    required this.onFilterSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onFilterSelected;

  static const _filters = <(String, List<String>)>[
    ('supervisor.leaveManagement.all', []),
    ('supervisor.leaveManagement.pending', ['1']),
    ('supervisor.leaveManagement.approved', []),
    ('supervisor.leaveManagement.rejected', []),
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
                labelKey: _filters[i].$1,
                labelArgs: _filters[i].$2,
                isSelected: selectedIndex == i,
                onTap: () => onFilterSelected(i),
              ),
            ),
        ],
      ),
    );
  }
}
