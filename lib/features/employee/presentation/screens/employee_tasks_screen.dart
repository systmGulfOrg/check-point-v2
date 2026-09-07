import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/employee_task_data.dart';
import '../widgets/employee_task_detail_card_widget.dart';

class EmployeeTasksScreen extends StatefulWidget {
  const EmployeeTasksScreen({super.key});

  @override
  State<EmployeeTasksScreen> createState() => _EmployeeTasksScreenState();
}

class _EmployeeTasksScreenState extends State<EmployeeTasksScreen> {
  int _selectedFilterIndex = 0;
  final _filters = ['Active', 'Done', 'All'];

  static const _allTasks = <EmployeeTaskData>[
    EmployeeTaskData(
      id: '1',
      title: 'Onboard New Contractors',
      dueDate: 'Due 2026-08-30',
      status: 'Overdue',
      priority: 'Urgent',
      description: 'Process onboarding documents for 3 new contractors.',
      progressPercentage: 20,
      assignees: ['JM', 'FA'],
    ),
    EmployeeTaskData(
      id: '2',
      title: 'Complete Q3 Attendance Report',
      dueDate: 'Due 2026-09-05',
      status: 'In Progress',
      priority: 'High',
      description: 'Compile attendance and performance metrics for Q3 2026.',
      progressPercentage: 45,
      assignees: ['JM'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTasks = switch (_selectedFilterIndex) {
      0 =>
        _allTasks
            .where((t) => t.status != 'Done' && t.status != 'Completed')
            .toList(),
      1 =>
        _allTasks
            .where((t) => t.status == 'Done' || t.status == 'Completed')
            .toList(),
      _ => _allTasks,
    };

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
              Text(
                '${filteredTasks.length} tasks',
                style: AppTextStyles.font13Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(12),
              Expanded(
                child: ListView.separated(
                  itemCount: filteredTasks.length,
                  separatorBuilder: (_, _) => hSpace(12),
                  itemBuilder: (context, index) => AnimatedListItemWidget(
                    index: index,
                    child: EmployeeTaskDetailCardWidget(
                      task: filteredTasks[index],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
