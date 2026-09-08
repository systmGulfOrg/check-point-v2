import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/tasks/admin_tasks_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/tasks/admin_tasks_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_create_task_sheet_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_edit_task_sheet_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_tasks_filter_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_tasks_skeleton_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_task_card_widget.dart';

class AdminTasksScreen extends StatefulWidget {
  const AdminTasksScreen({super.key});

  @override
  State<AdminTasksScreen> createState() => _AdminTasksScreenState();
}

class _AdminTasksScreenState extends State<AdminTasksScreen> {
  int selectedFilter = 0;

  void _showDeleteTaskDialog(BuildContext context, int taskId) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDeleteConfirmationDialogWidget(
        title: 'admin.locations.delete'.tr(context: context),
        message: 'admin.tasks.deleteMessage'.tr(context: context),
        onConfirm: () {
          Navigator.pop(dialogContext);
          context.read<AdminTasksCubit>().deleteTask(taskId);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.tasks.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminTasksFilterWidget(
                selectedIndex: selectedFilter,
                onSelected: (index) => setState(() => selectedFilter = index),
              ),
              hSpace(14),
              BlocBuilder<AdminTasksCubit, AdminTasksState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const AdminTasksSkeletonWidget(),
                    actionSuccess: (message) => const SizedBox.shrink(),
                    error: (messageKey) => Padding(
                      padding: EdgeInsets.all(24.r),
                      child: Center(
                        child: Text(
                          messageKey.tr(context: context),
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ),
                    success: (tasks) {
                      final filteredTasks = switch (selectedFilter) {
                        0 => tasks
                            .where(
                              (t) =>
                                  t.status?.toLowerCase() != 'completed' &&
                                  t.status?.toLowerCase() != 'done',
                            )
                            .toList(),
                        1 => tasks
                            .where(
                              (t) =>
                                  t.status?.toLowerCase() == 'completed' ||
                                  t.status?.toLowerCase() == 'done',
                            )
                            .toList(),
                        _ => tasks,
                      };
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'admin.tasks.count'.tr(
                                  context: context,
                                  args: ['${filteredTasks.length}'],
                                ),
                                style: AppTextStyles.font12Regular,
                              ),
                              InkWell(
                                onTap: () => showModalBottomSheet<void>(
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
                                      BlocProvider.value(
                                        value: context.read<AdminTasksCubit>(),
                                      ),
                                      BlocProvider<AdminEmployeesCubit>(
                                        create: (_) =>
                                            sl<AdminEmployeesCubit>()..loadEmployees(),
                                      ),
                                    ],
                                    child: const AdminCreateTaskSheetWidget(),
                                  ),
                                ),
                                child: Text(
                                  'admin.tasks.newTask'.tr(context: context),
                                  style: AppTextStyles.font13SemiBold.copyWith(
                                    color: AppColors.brandPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          hSpace(10),
                          if (filteredTasks.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: Center(
                                child: Text(
                                  'admin.requests.emptyAll'.tr(context: context),
                                  style: AppTextStyles.font14Regular,
                                ),
                              ),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredTasks.length,
                              separatorBuilder: (_, _) => hSpace(10),
                              itemBuilder: (context, index) {
                                final task = filteredTasks[index];
                                return SupervisorTaskCardWidget(
                                  task: task,
                                  onEdit: () {
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
                                          BlocProvider.value(
                                            value: context.read<AdminTasksCubit>(),
                                          ),
                                          BlocProvider<AdminEmployeesCubit>(
                                            create: (_) =>
                                                sl<AdminEmployeesCubit>()..loadEmployees(),
                                          ),
                                        ],
                                        child: AdminEditTaskSheetWidget(task: task),
                                      ),
                                    );
                                  },
                                  onDelete: () {
                                    if (task.id != null) {
                                      _showDeleteTaskDialog(
                                        context,
                                        task.id!,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                      ],
                    );
                  },
                );
              },
            ),
            ],
          ),
        ),
      ),
    );
  }
}
