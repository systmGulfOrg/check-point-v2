import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/tasks/employee_tasks_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/tasks/employee_tasks_state.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_task_data.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_task_detail_card_widget.dart';

class EmployeeTasksScreen extends StatefulWidget {
  const EmployeeTasksScreen({super.key});

  @override
  State<EmployeeTasksScreen> createState() => _EmployeeTasksScreenState();
}

class _EmployeeTasksScreenState extends State<EmployeeTasksScreen> {
  int _selectedFilterIndex = 0;
  final _filters = ['Active', 'Done', 'All'];

  @override
  void initState() {
    super.initState();
    context.read<EmployeeTasksCubit>().loadMyTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'employee.tasks.title'.tr(context: context),
                style: AppTextStyles.font24Bold,
              ),
              hSpace(16),
              Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    for (int i = 0; i < _filters.length; i++)
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedFilterIndex = i),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            decoration: BoxDecoration(
                              color: _selectedFilterIndex == i
                                  ? AppColors.cardBackground
                                  : AppColors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: _selectedFilterIndex == i
                                  ? const [
                                      BoxShadow(
                                        color: AppColors.shadow,
                                        blurRadius: 4,
                                        offset: Offset(0, 1),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                _filters[i],
                                style: AppTextStyles.font13SemiBold.copyWith(
                                  color: _selectedFilterIndex == i
                                      ? AppColors.textPrimary
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              hSpace(14),
              BlocConsumer<EmployeeTasksCubit, EmployeeTasksState>(
                listener: (context, state) {
                  switch (state) {
                    case EmployeeTasksStateActionSuccess(:final message):
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
                    case EmployeeTasksStateError(:final messageKey):
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(messageKey)));
                    default:
                      break;
                  }
                },
                builder: (context, state) {
                  final allTasks = switch (state) {
                    EmployeeTasksStateSuccess(:final tasks) =>
                      tasks
                          .map(
                            (t) => EmployeeTaskData(
                              id: '${t.id ?? 0}',
                              title: t.title ?? '',
                              dueDate: 'Task #${t.id ?? 0}',
                              status: t.status ?? 'Active',
                              priority: 'Normal',
                              description: t.description ?? '',
                              progressPercentage: 50,
                              assignees: const ['EM'],
                            ),
                          )
                          .toList(),
                    _ => const <EmployeeTaskData>[],
                  };

                  final filteredTasks = switch (_selectedFilterIndex) {
                    0 =>
                      allTasks
                          .where(
                            (t) =>
                                t.status != 'Done' && t.status != 'Completed',
                          )
                          .toList(),
                    1 =>
                      allTasks
                          .where(
                            (t) =>
                                t.status == 'Done' || t.status == 'Completed',
                          )
                          .toList(),
                    _ => allTasks,
                  };

                  if (state is EmployeeTasksStateLoading) {
                    return Expanded(
                      child: Skeletonizer(
                        child: ListView.separated(
                          itemCount: 3,
                          separatorBuilder: (_, _) => hSpace(12),
                          itemBuilder: (_, _) => EmployeeTaskDetailCardWidget(
                            task: const EmployeeTaskData(
                              id: '000',
                              title: 'Loading task title',
                              dueDate: 'Loading date',
                              status: 'Active',
                              priority: 'Normal',
                              description: 'Loading task description',
                              progressPercentage: 50,
                              assignees: ['EM'],
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${filteredTasks.length} tasks',
                          style: AppTextStyles.font13Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        hSpace(12),
                        Expanded(
                          child: filteredTasks.isEmpty
                              ? const Center(child: Text('No tasks available'))
                              : ListView.separated(
                                  itemCount: filteredTasks.length,
                                  separatorBuilder: (_, _) => hSpace(12),
                                  itemBuilder: (context, index) =>
                                      AnimatedListItemWidget(
                                        index: index,
                                        child: EmployeeTaskDetailCardWidget(
                                          task: filteredTasks[index],
                                        ),
                                      ),
                                ),
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
