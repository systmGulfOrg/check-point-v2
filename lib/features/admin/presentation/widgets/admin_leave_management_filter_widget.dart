import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_segment_option_widget.dart';

class AdminLeaveManagementFilterWidget extends StatelessWidget {
  const AdminLeaveManagementFilterWidget({
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const filters = <(String, List<String>)>[
    ('admin.leaveManagement.all', []),
    ('admin.leaveManagement.pending', ['2']),
    ('admin.leaveManagement.approved', []),
    ('admin.leaveManagement.rejected', []),
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
          for (var index = 0; index < filters.length; index++)
            Expanded(
              child: SupervisorSegmentOptionWidget(
                labelKey: filters[index].$1,
                labelArgs: filters[index].$2,
                isSelected: selectedIndex == index,
                onTap: () => onSelected(index),
              ),
            ),
        ],
      ),
    );
  }
}
