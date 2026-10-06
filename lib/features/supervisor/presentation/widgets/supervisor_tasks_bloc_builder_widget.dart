import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/supervisor/data/models/tasks/supervisor_update_task_status_request_body.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/tasks/supervisor_tasks_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/tasks/supervisor_tasks_state.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'supervisor_edit_task_sheet_widget.dart';
import 'supervisor_tasks_list_widget.dart';

class SupervisorTasksBlocBuilderWidget extends StatelessWidget {
  const SupervisorTasksBlocBuilderWidget({
    required this.selectedFilterIndex,
    required this.canManageTasks,
    super.key,
  });

  final int selectedFilterIndex;
  final bool canManageTasks;

  static const _dummyTasks = [
    AdminTaskModel(
      title: 'Loading Task Title',
      description: 'Loading task description details',
      assignedEmployeeName: 'Loading Employee',
      status: 'In Progress',
    ),
    AdminTaskModel(
      title: 'Loading Another Task',
      description: 'Loading description',
      assignedEmployeeName: 'Loading Employee',
      status: 'To Do',
    ),
  ];

  void _showDeleteDialog(
    BuildContext context,
    SupervisorTasksCubit cubit,
    int taskId,
  ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDeleteConfirmationDialogWidget(
        title: 'admin.locations.delete'.tr(context: context),
        message: 'admin.tasks.deleteMessage'.tr(context: context),
        onConfirm: () {
          Navigator.pop(dialogContext);
          cubit.deleteTask(taskId);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SupervisorTasksCubit>();

    return BlocBuilder<SupervisorTasksCubit, SupervisorTasksState>(
      builder: (context, state) {
        return switch (state) {
          SupervisorTasksLoading() => const Skeletonizer(
            enabled: true,
            child: SupervisorTasksListWidget(tasks: _dummyTasks),
          ),
          SupervisorTasksSuccess(:final tasks) => SupervisorTasksListWidget(
            tasks: switch (selectedFilterIndex) {
              0 =>
                tasks
                    .where(
                      (t) =>
                          t.status?.toLowerCase() != 'completed' &&
                          t.status?.toLowerCase() != 'done',
                    )
                    .toList(),
              1 =>
                tasks
                    .where(
                      (t) =>
                          t.status?.toLowerCase() == 'completed' ||
                          t.status?.toLowerCase() == 'done',
                    )
                    .toList(),
              _ => tasks,
            },
            onEdit: canManageTasks
                ? (task) {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: AppColors.cardBackground,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: cubit),
                          BlocProvider<SupervisorTeamCubit>(
                            create: (_) =>
                                sl<SupervisorTeamCubit>()..loadTeam(),
                          ),
                        ],
                        child: SupervisorEditTaskSheetWidget(task: task),
                      ),
                    );
                  }
                : null,
            onStatusToggle: (task) {
              if (task.id != null) {
                final isDone =
                    task.status?.toLowerCase() == 'completed' ||
                    task.status?.toLowerCase() == 'done';
                cubit.updateTaskStatus(
                  SupervisorUpdateTaskStatusRequestBody(
                    id: task.id!,
                    status: isDone ? 'In Progress' : 'Completed',
                  ),
                );
              }
            },
            onDelete: canManageTasks
                ? (task) {
                    if (task.id != null) {
                      _showDeleteDialog(context, cubit, task.id!);
                    }
                  }
                : null,
          ),
          SupervisorTasksError(:final messageKey) => Center(
            child: Text(
              messageKey.tr(context: context),
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
          _ => const SupervisorTasksListWidget(tasks: []),
        };
      },
    );
  }
}
