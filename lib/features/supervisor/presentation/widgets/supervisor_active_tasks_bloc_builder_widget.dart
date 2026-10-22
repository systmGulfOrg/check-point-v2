import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/tasks/supervisor_tasks_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/tasks/supervisor_tasks_state.dart';
import 'supervisor_active_tasks_widget.dart';

class SupervisorActiveTasksBlocBuilderWidget extends StatelessWidget {
  const SupervisorActiveTasksBlocBuilderWidget({super.key, this.onViewAll});

  final VoidCallback? onViewAll;

  static const _dummyTasks = [
    AdminTaskModel(
      title: 'Loading task title description',
      assignedEmployeeName: 'Loading Employee',
      status: 'In Progress',
    ),
    AdminTaskModel(
      title: 'Loading another task title',
      assignedEmployeeName: 'Loading Employee',
      status: 'To Do',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupervisorTasksCubit, SupervisorTasksState>(
      builder: (context, state) {
        return switch (state) {
          SupervisorTasksLoading() => Skeletonizer(
            enabled: true,
            child: SupervisorActiveTasksWidget(
              tasks: _dummyTasks,
              onViewAll: onViewAll,
            ),
          ),
          SupervisorTasksSuccess(:final tasks) => SupervisorActiveTasksWidget(
            tasks: tasks,
            onViewAll: onViewAll,
          ),
          SupervisorTasksError(:final messageKey) => AppErrorStateWidget(
            messageKey: messageKey,
            onRetry: () => context.read<SupervisorTasksCubit>().loadTasks(),
          ),
          _ => SupervisorActiveTasksWidget(
            tasks: const [],
            onViewAll: onViewAll,
          ),
        };
      },
    );
  }
}
