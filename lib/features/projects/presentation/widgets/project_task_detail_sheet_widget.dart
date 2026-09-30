import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'package:check_point_v2/features/projects/data/models/project_models.dart';
import 'package:check_point_v2/features/projects/presentation/cubit/projects_cubit.dart';
import 'assignee_multi_select_widget.dart';
import 'project_task_detail_activity_log_list_widget.dart';
import 'project_task_detail_assignees_list_widget.dart';
import 'project_task_detail_attachments_list_widget.dart';
import 'project_task_detail_chip_widget.dart';
import 'project_task_detail_section_header_widget.dart';

class ProjectTaskDetailSheetWidget extends StatefulWidget {
  const ProjectTaskDetailSheetWidget({
    required this.task,
    required this.project,
    required this.canManage,
    required this.onEdit,
    super.key,
  });

  final ProjectTaskModel task;
  final ProjectModel project;
  final bool canManage;
  final VoidCallback onEdit;

  @override
  State<ProjectTaskDetailSheetWidget> createState() =>
      _ProjectTaskDetailSheetWidgetState();
}

class _ProjectTaskDetailSheetWidgetState
    extends State<ProjectTaskDetailSheetWidget> {
  List<EmployeeModel> _employees = [];
  late List<String> _currentAssigneeIds;

  @override
  void initState() {
    super.initState();
    _currentAssigneeIds = List<String>.from(widget.task.assigneeIds);
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    try {
      final repo = sl<AdminEmployeeRepo>();
      final result = await repo.getEmployees(page: 0, pageSize: 100);
      result.when(
        success: (list) {
          if (mounted) {
            setState(() {
              _employees = list;
            });
          }
        },
        failure: (_) {},
      );
    } catch (_) {}
  }

  Color _priorityColor(String? priority) {
    return switch (priority?.toUpperCase()) {
      'URGENT' || 'CRITICAL' => AppColors.error,
      'HIGH' => AppColors.warning,
      'NORMAL' => AppColors.brandPrimary,
      'LOW' => AppColors.textSecondary,
      _ => AppColors.info,
    };
  }

  Color _priorityBackground(String? priority) {
    return switch (priority?.toUpperCase()) {
      'URGENT' || 'CRITICAL' => AppColors.softBrandBackground,
      'HIGH' => AppColors.infoBackground,
      'NORMAL' => AppColors.softBlueBackground,
      'LOW' => AppColors.pageBackground,
      _ => AppColors.softBlueBackground,
    };
  }

  Future<void> _manageAssignees() async {
    final cubit = context.read<ProjectsCubit>();
    var localIds = List<String>.from(_currentAssigneeIds);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => BlocProvider.value(
        value: cubit,
        child: StatefulBuilder(
          builder: (innerCtx, setInnerState) => Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'projects.assignees'.tr(context: innerCtx),
                  style: AppTextStyles.font18Bold,
                ),
                SizedBox(height: 16.h),
                AssigneeMultiSelectWidget(
                  selectedIds: localIds,
                  fallbackOptions: widget.task.assigneeIds,
                  onChanged: (updated) =>
                      setInnerState(() => localIds = updated),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandPrimary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pop(ctx);
                      if (mounted) {
                        setState(() => _currentAssigneeIds = localIds);
                      }
                      await cubit.assignTask(widget.task.id, localIds);
                    },
                    child: Text(
                      'common.save'.tr(context: innerCtx),
                      style: AppTextStyles.font14Bold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusName = widget.project.statuses
        .firstWhere(
          (item) => item.id == widget.task.statusId,
          orElse: () => widget.project.statuses.isNotEmpty
              ? widget.project.statuses.first
              : const ProjectStatusModel(id: '', name: 'To Do'),
        )
        .name;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.90,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.task.title,
                      style: AppTextStyles.font20Bold,
                    ),
                  ),
                  if (widget.canManage)
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onEdit();
                      },
                      icon: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                          size: 20.r,
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        ProjectTaskDetailChipWidget(
                          icon: Icons.flag_rounded,
                          label: statusName,
                          bg: AppColors.pageBackground,
                          textColor: AppColors.textPrimary,
                        ),
                        ProjectTaskDetailChipWidget(
                          icon: Icons.bolt_rounded,
                          label: widget.task.priority ?? 'NORMAL',
                          bg: _priorityBackground(widget.task.priority),
                          textColor: _priorityColor(widget.task.priority),
                        ),
                        if ((widget.task.estimatedMinutes ?? 0) > 0)
                          ProjectTaskDetailChipWidget(
                            icon: Icons.timer_outlined,
                            label: '${widget.task.estimatedMinutes} min',
                            bg: AppColors.pageBackground,
                            textColor: AppColors.textSecondary,
                          ),
                        if (widget.task.startDate?.isNotEmpty == true)
                          ProjectTaskDetailChipWidget(
                            icon: Icons.calendar_today_rounded,
                            label: AppDateFormatter.formatDateString(
                              widget.task.startDate,
                            ),
                            bg: AppColors.pageBackground,
                            textColor: AppColors.textSecondary,
                          ),
                        if (widget.task.dueDate?.isNotEmpty == true)
                          ProjectTaskDetailChipWidget(
                            icon: Icons.event_rounded,
                            label: AppDateFormatter.formatDateString(
                              widget.task.dueDate,
                            ),
                            bg: AppColors.softBrandBackground,
                            textColor: AppColors.brandPrimary,
                          ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    ProjectTaskDetailSectionHeaderWidget(
                      title: 'projects.description'.tr(context: context),
                      icon: Icons.subject_rounded,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: AppColors.pageBackground,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border(
                          left: BorderSide(
                            color: AppColors.brandPrimary,
                            width: 4.w,
                          ),
                        ),
                      ),
                      child: Text(
                        widget.task.description?.isNotEmpty == true
                            ? widget.task.description!
                            : 'projects.noDescription'.tr(context: context),
                        style: AppTextStyles.font14Regular.copyWith(
                          color: widget.task.description?.isNotEmpty == true
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ProjectTaskDetailSectionHeaderWidget(
                      title: 'projects.assignees'.tr(context: context),
                      icon: Icons.people_alt_rounded,
                      action: widget.canManage
                          ? TextButton.icon(
                              onPressed: _manageAssignees,
                              icon: Icon(Icons.group_add_rounded, size: 18.r),
                              label: Text('common.edit'.tr(context: context)),
                            )
                          : null,
                    ),
                    SizedBox(height: 8.h),
                    ProjectTaskDetailAssigneesListWidget(
                      assigneeIds: _currentAssigneeIds,
                      employees: _employees,
                    ),
                    SizedBox(height: 20.h),
                    ProjectTaskDetailSectionHeaderWidget(
                      title: 'projects.attachments'.tr(context: context),
                      icon: Icons.attach_file_rounded,
                    ),
                    SizedBox(height: 8.h),
                    ProjectTaskDetailAttachmentsListWidget(
                      attachments: widget.task.attachments,
                    ),
                    SizedBox(height: 20.h),
                    ProjectTaskDetailSectionHeaderWidget(
                      title: 'projects.activity'.tr(context: context),
                      icon: Icons.history_rounded,
                    ),
                    SizedBox(height: 8.h),
                    const ProjectTaskDetailActivityLogListWidget(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
