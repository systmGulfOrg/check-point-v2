import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'supervisor_segment_option_widget.dart';

class SupervisorAttendanceFilterWidget extends StatelessWidget {
  const SupervisorAttendanceFilterWidget({
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

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
          Expanded(
            child: SupervisorSegmentOptionWidget(
              labelKey: 'supervisor.attendance.attendanceTab',
              labelArgs: const [],
              isSelected: selectedIndex == 0,
              onTap: () => onTabSelected(0),
            ),
          ),
          Expanded(
            child: SupervisorSegmentOptionWidget(
              labelKey: 'supervisor.attendance.leavesTab',
              labelArgs: const ['1'],
              isSelected: selectedIndex == 1,
              onTap: () => onTabSelected(1),
            ),
          ),
        ],
      ),
    );
  }
}
