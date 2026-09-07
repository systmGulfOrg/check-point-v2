import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'employee_status_badge_widget.dart';
import 'employee_task_data.dart';

class EmployeeTaskCardWidget extends StatelessWidget {
  const EmployeeTaskCardWidget({required this.task, super.key});

  final EmployeeTaskData task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title, style: AppTextStyles.font14SemiBold),
                hSpace(4),
                Text(task.dueDate, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
          wSpace(12),
          EmployeeStatusBadgeWidget(status: task.status),
        ],
      ),
    );
  }
}
