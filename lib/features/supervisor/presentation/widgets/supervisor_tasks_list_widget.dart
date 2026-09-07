import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../admin/data/models/admin_task_model.dart';
import 'supervisor_task_card_widget.dart';

class SupervisorTasksListWidget extends StatelessWidget {
  const SupervisorTasksListWidget({
    required this.tasks,
    super.key,
    this.onStatusToggle,
    this.onDelete,
  });

  final List<AdminTaskModel> tasks;
  final ValueChanged<AdminTaskModel>? onStatusToggle;
  final ValueChanged<AdminTaskModel>? onDelete;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 36.h),
          child: Text(
            'supervisor.tasks.empty'.tr(context: context),
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      separatorBuilder: (_, _) => hSpace(8),
      itemBuilder: (_, index) {
        final task = tasks[index];
        return AnimatedListItemWidget(
          index: index,
          child: SupervisorTaskCardWidget(
            task: task,
            onStatusToggle: onStatusToggle != null
                ? () => onStatusToggle!(task)
                : null,
            onDelete: onDelete != null ? () => onDelete!(task) : null,
          ),
        );
      },
    );
  }
}
