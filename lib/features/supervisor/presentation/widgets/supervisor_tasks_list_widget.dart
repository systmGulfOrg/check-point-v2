import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/animated_list_item_widget.dart';
import 'supervisor_task_card_widget.dart';
import 'supervisor_task_data.dart';

class SupervisorTasksListWidget extends StatelessWidget {
  const SupervisorTasksListWidget({super.key});

  static const _tasks = <SupervisorTaskData>[
    SupervisorTaskData(
      titleKey: 'supervisor.tasks.items.onboard.title',
      descriptionKey: 'supervisor.tasks.items.onboard.description',
      priorityKey: 'supervisor.tasks.priority.critical',
      priorityColor: AppColors.error,
      priorityBackgroundColor: AppColors.softBrandBackground,
      assigneeKey: 'supervisor.attendance.members.james',
      dueDate: '2026-08-30',
      assigneeInitials: ['JM', 'FA'],
      progress: 0.2,
      statusKey: 'supervisor.taskStatus.overdue',
      statusColor: AppColors.error,
      statusBackgroundColor: AppColors.softBrandBackground,
    ),
    SupervisorTaskData(
      titleKey: 'supervisor.tasks.items.report.title',
      descriptionKey: 'supervisor.tasks.items.report.description',
      priorityKey: 'supervisor.tasks.priority.high',
      priorityColor: AppColors.warningOrange,
      priorityBackgroundColor: AppColors.softYellowBackground,
      assigneeKey: 'supervisor.attendance.members.james',
      dueDate: '2026-09-05',
      assigneeInitials: ['JM'],
      progress: 0.45,
      statusKey: 'supervisor.taskStatus.inProgress',
      statusColor: AppColors.info,
      statusBackgroundColor: AppColors.softBlueBackground,
    ),
    SupervisorTaskData(
      titleKey: 'supervisor.tasks.items.security.title',
      descriptionKey: 'supervisor.tasks.items.security.description',
      priorityKey: 'supervisor.tasks.priority.medium',
      priorityColor: AppColors.info,
      priorityBackgroundColor: AppColors.softBlueBackground,
      assigneeKey: 'supervisor.attendance.members.priya',
      dueDate: '2026-09-08',
      assigneeInitials: ['PN'],
      statusKey: 'supervisor.taskStatus.toDo',
      statusColor: AppColors.textSecondary,
      statusBackgroundColor: AppColors.pageBackground,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _tasks.length,
      separatorBuilder: (_, _) => hSpace(8),
      itemBuilder: (_, index) => AnimatedListItemWidget(
        index: index,
        child: SupervisorTaskCardWidget(task: _tasks[index]),
      ),
    );
  }
}
