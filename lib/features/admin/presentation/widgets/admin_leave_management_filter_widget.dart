import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_segment_option_widget.dart';

class AdminLeaveManagementFilterWidget extends StatelessWidget {
  const AdminLeaveManagementFilterWidget({
    required this.selectedIndex,
    required this.onSelected,
    this.pendingCount = 0,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final int pendingCount;

  @override
  Widget build(BuildContext context) {
    final filters = <(String, List<String>)>[
      ('admin.leaveManagement.all', []),
      ('admin.leaveManagement.pending', ['$pendingCount']),
      ('admin.leaveManagement.approved', []),
      ('admin.leaveManagement.rejected', []),
    ];

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
