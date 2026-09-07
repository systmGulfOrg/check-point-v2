import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../supervisor/presentation/widgets/supervisor_task_card_widget.dart';
import '../../data/models/admin_task_model.dart';

class AdminTasksListWidget extends StatelessWidget {
  const AdminTasksListWidget({super.key});

  static const tasks = <AdminTaskModel>[
    AdminTaskModel(
      title: 'supervisor.tasks.items.onboard.title',
      description: 'supervisor.tasks.items.onboard.description',
      assignedEmployeeName: 'James Martinez',
      status: 'supervisor.taskStatus.overdue',
    ),
    AdminTaskModel(
      title: 'supervisor.tasks.items.report.title',
      description: 'supervisor.tasks.items.report.description',
      assignedEmployeeName: 'James Martinez',
      status: 'supervisor.taskStatus.inProgress',
    ),
    AdminTaskModel(
      title: 'admin.tasks.items.database.title',
      description: 'admin.tasks.items.database.description',
      assignedEmployeeName: 'David Chen',
      status: 'supervisor.taskStatus.toDo',
    ),
    AdminTaskModel(
      title: 'supervisor.tasks.items.security.title',
      description: 'supervisor.tasks.items.security.description',
      assignedEmployeeName: 'Priya Nair',
      status: 'supervisor.taskStatus.toDo',
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
