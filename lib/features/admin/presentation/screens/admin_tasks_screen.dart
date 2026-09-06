import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../data/models/admin_task_model.dart';
import '../cubit/admin_tasks_cubit.dart';
import '../cubit/admin_tasks_state.dart';
import '../widgets/admin_create_task_sheet_widget.dart';
import '../widgets/admin_tasks_filter_widget.dart';
import '../widgets/admin_tasks_skeleton_widget.dart';

class AdminTasksScreen extends StatefulWidget {
  const AdminTasksScreen({super.key});

  @override
  State<AdminTasksScreen> createState() => _AdminTasksScreenState();
}

class _AdminTasksScreenState extends State<AdminTasksScreen> {
  int selectedFilter = 0;

  void _showEditTaskDialog(
    BuildContext context,
    int taskId,
    String currentTitle,
    String currentDesc,
  ) {
    final titleController = TextEditingController(text: currentTitle);
    final descController = TextEditingController(text: currentDesc);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isNotEmpty) {
                context.read<AdminTasksCubit>().editTask(
                      taskId,
                      AddTaskRequestBody(
                        title: titleController.text.trim(),
                        description: descController.text.trim(),
                      ),
                    );
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Save'),
          ),
        ],
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
                    actionSuccess: (_) => const SizedBox.shrink(),
                    success: (tasks) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'admin.tasks.count'.tr(
                                context: context,
                                args: ['${tasks.length}'],
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
                                builder: (_) =>
                                    const AdminCreateTaskSheetWidget(),
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
                        if (tasks.isEmpty)
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
                            itemCount: tasks.length,
                            separatorBuilder: (_, _) => hSpace(10),
                            itemBuilder: (context, index) {
                              final task = tasks[index];
                              return Container(
                                decoration: AppDecorations.card,
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(14.r),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task.title ?? 'Task',
                                            style: AppTextStyles.font16Bold,
                                          ),
                                          hSpace(4),
                                          Text(
                                            task.description ?? '',
                                            style: AppTextStyles.font13Regular,
                                          ),
                                          hSpace(8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Assigned: ${task.assignedEmployeeName ?? '-'}',
                                                style:
                                                    AppTextStyles.font12Regular,
                                              ),
                                              Text(
                                                task.status ?? 'Pending',
                                                style: AppTextStyles.font12Bold
                                                    .copyWith(
                                                  color: AppColors.brandPrimary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (task.id != null) {
                                                _showEditTaskDialog(
                                                  context,
                                                  task.id!,
                                                  task.title ?? '',
                                                  task.description ?? '',
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 8.h,
                                              ),
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                    color: AppColors.border,
                                                  ),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'admin.locations.edit'.tr(
                                                  context: context,
                                                ),
                                                style: AppTextStyles
                                                    .font13SemiBold
                                                    .copyWith(
                                                  color: AppColors.textSecondary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              if (task.id != null) {
                                                context
                                                    .read<AdminTasksCubit>()
                                                    .deleteTask(task.id!);
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 8.h,
                                              ),
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                    color: AppColors.border,
                                                  ),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'admin.locations.delete'.tr(
                                                  context: context,
                                                ),
                                                style: AppTextStyles
                                                    .font13SemiBold
                                                    .copyWith(
                                                  color: AppColors.error,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
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
