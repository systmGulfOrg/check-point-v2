import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../supervisor/presentation/widgets/supervisor_task_card_widget.dart';
import '../../../supervisor/presentation/widgets/supervisor_task_data.dart';

class AdminTasksListWidget extends StatelessWidget {
  const AdminTasksListWidget({super.key});

  static const tasks = <SupervisorTaskData>[
    SupervisorTaskData(
      titleKey: 'supervisor.tasks.items.onboard.title',
      descriptionKey: 'supervisor.tasks.items.onboard.description',
      priorityKey: 'admin.tasks.priority.urgent',
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
      titleKey: 'admin.tasks.items.site.title',
      descriptionKey: 'admin.tasks.items.site.description',
      priorityKey: 'supervisor.tasks.priority.high',
      priorityColor: AppColors.warningOrange,
      priorityBackgroundColor: AppColors.softYellowBackground,
      assigneeKey: 'supervisor.attendance.members.david',
      dueDate: '2026-09-10',
      assigneeInitials: ['DC'],
      statusKey: 'admin.tasks.status.new',
      statusColor: AppColors.textSecondary,
      statusBackgroundColor: AppColors.pageBackground,
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
      itemCount: tasks.length,
      separatorBuilder: (_, _) => hSpace(8),
      itemBuilder: (_, index) => SupervisorTaskCardWidget(task: tasks[index]),
    );
  }
}
