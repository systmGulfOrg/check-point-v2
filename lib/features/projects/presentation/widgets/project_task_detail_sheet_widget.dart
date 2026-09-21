import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/utils/app_date_formatter.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'package:check_point_v2/features/projects/data/models/project_models.dart';
import 'package:check_point_v2/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:check_point_v2/features/projects/presentation/cubit/projects_state.dart';
import 'package:check_point_v2/features/projects/presentation/widgets/assignee_multi_select_widget.dart';

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
  bool _isLoadingEmployees = false;
  late List<String> _currentAssigneeIds;

  @override
  void initState() {
    super.initState();
    _currentAssigneeIds = List<String>.from(widget.task.assigneeIds);
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    setState(() => _isLoadingEmployees = true);
    try {
      final repo = sl<AdminEmployeeRepo>();
      final result = await repo.getEmployees(page: 0, pageSize: 100);
      result.when(
        success: (list) {
          if (mounted) {
            setState(() {
              _employees = list;
              _isLoadingEmployees = false;
            });
          }
        },
        failure: (_) {
          if (mounted) setState(() => _isLoadingEmployees = false);
        },
      );
    } catch (_) {
      if (mounted) setState(() => _isLoadingEmployees = false);
    }
  }

  EmployeeModel? _findEmployee(String id) {
    return _employees.firstWhere(
      (e) => e.id == id || e.userName == id || e.name == id,
      orElse: () => EmployeeModel(id: id, name: id),
    );
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

  String _formatAuditAction(String? action) {
    if (action == null || action.isEmpty) return 'projects.activity'.tr();
    return switch (action) {
      'task.status_updated' => 'projects.statusUpdated'.tr(context: context),
      'task.assignees_updated' => 'projects.assigneesUpdated'.tr(context: context),
      'task.tags_updated' => 'projects.tagsUpdated'.tr(context: context),
      'task.created' => 'projects.taskCreated'.tr(context: context),
      'task.updated' => 'projects.taskUpdated'.tr(context: context),
      _ => action.replaceAll('task.', '').replaceAll('_', ' ').toUpperCase(),
    };
  }

  Future<void> _manageAssignees() async {
    final cubit = context.read<ProjectsCubit>();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'projects.assignees'.tr(context: context),
              style: AppTextStyles.font18Bold,
            ),
            SizedBox(height: 16.h),
            AssigneeMultiSelectWidget(
              selectedIds: _currentAssigneeIds,
              fallbackOptions: widget.task.assigneeIds,
              onChanged: (updated) => setState(() => _currentAssigneeIds = updated),
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
                  await cubit.assignTask(widget.task.id, _currentAssigneeIds);
                },
                child: Text(
                  'common.save'.tr(context: context),
                  style: AppTextStyles.font14Bold.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
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
                        _buildChip(
                          icon: Icons.flag_rounded,
                          label: statusName,
                          bg: AppColors.pageBackground,
                          textColor: AppColors.textPrimary,
                        ),
                        _buildChip(
                          icon: Icons.bolt_rounded,
                          label: widget.task.priority ?? 'NORMAL',
                          bg: _priorityBackground(widget.task.priority),
                          textColor: _priorityColor(widget.task.priority),
                        ),
                        if ((widget.task.estimatedMinutes ?? 0) > 0)
                          _buildChip(
                            icon: Icons.timer_outlined,
                            label: '${widget.task.estimatedMinutes} min',
                            bg: AppColors.pageBackground,
                            textColor: AppColors.textSecondary,
                          ),
                        if (widget.task.startDate?.isNotEmpty == true)
                          _buildChip(
                            icon: Icons.calendar_today_rounded,
                            label: AppDateFormatter.formatDateString(widget.task.startDate),
                            bg: AppColors.pageBackground,
                            textColor: AppColors.textSecondary,
                          ),
                        if (widget.task.dueDate?.isNotEmpty == true)
                          _buildChip(
                            icon: Icons.event_rounded,
                            label: AppDateFormatter.formatDateString(widget.task.dueDate),
                            bg: AppColors.softBrandBackground,
                            textColor: AppColors.brandPrimary,
                          ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    _buildSectionHeader(
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
                    _buildSectionHeader(
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
                    _buildAssigneesList(),
                    SizedBox(height: 20.h),
                    _buildSectionHeader(
                      title: 'projects.attachments'.tr(context: context),
                      icon: Icons.attach_file_rounded,
                    ),
                    SizedBox(height: 8.h),
                    _buildAttachmentsList(),
                    SizedBox(height: 20.h),
                    _buildSectionHeader(
                      title: 'projects.activity'.tr(context: context),
                      icon: Icons.history_rounded,
                    ),
                    SizedBox(height: 8.h),
                    _buildActivityLogList(),
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

  Widget _buildChip({
    required IconData icon,
    required String label,
    required Color bg,
    required Color textColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.r, color: textColor),
          SizedBox(width: 5.w),
          Text(
            label,
            style: AppTextStyles.font12Bold.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
    Widget? action,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20.r, color: AppColors.brandPrimary),
        SizedBox(width: 8.w),
        Text(title, style: AppTextStyles.font16Bold),
        const Spacer(),
        if (action != null) action,
      ],
    );
  }

  Widget _buildAssigneesList() {
    if (_currentAssigneeIds.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.pageBackground,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          'projects.noAssignees'.tr(context: context),
          style: AppTextStyles.font13Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return Column(
      children: _currentAssigneeIds.map((id) {
        final emp = _findEmployee(id);
        final displayName = emp?.name?.isNotEmpty == true
            ? emp!.name!
            : (emp?.userName?.isNotEmpty == true ? emp!.userName! : id);
        final initial = displayName.trim().isNotEmpty
            ? displayName.trim()[0].toUpperCase()
            : '?';
        final subtitle = emp?.position ?? emp?.email ?? emp?.departmentName ?? id;

        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: AppColors.pageBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
            leading: CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColors.softBrandBackground,
              backgroundImage: emp?.imageUrl?.isNotEmpty == true
                  ? NetworkImage(emp!.imageUrl!)
                  : null,
              child: emp?.imageUrl?.isNotEmpty == true
                  ? null
                  : Text(
                      initial,
                      style: AppTextStyles.font16Bold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
            ),
            title: Text(
              displayName,
              style: AppTextStyles.font14Bold,
            ),
            subtitle: Text(
              subtitle,
              style: AppTextStyles.font12Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAttachmentsList() {
    if (widget.task.attachments.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.pageBackground,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          'projects.noAttachments'.tr(context: context),
          style: AppTextStyles.font13Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return Column(
      children: widget.task.attachments.map((file) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: AppColors.pageBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
            leading: Icon(Icons.insert_drive_file_outlined, color: AppColors.brandPrimary),
            title: Text(
              file.fileName ?? 'File',
              style: AppTextStyles.font14Bold,
            ),
            subtitle: file.fileSize != null
                ? Text(
                    '${(file.fileSize! / 1024).toStringAsFixed(1)} KB',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  )
                : null,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActivityLogList() {
    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (context, state) {
        final audit = state is ProjectsStateSuccess
            ? state.audit
            : const <TaskAuditModel>[];

        if (audit.isEmpty) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'projects.noActivity'.tr(context: context),
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          );
        }

        return Column(
          children: audit.map((item) {
            final formattedAction = _formatAuditAction(item.action);
            final dateStr = item.createdAt != null
                ? AppDateFormatter.formatDateString(item.createdAt)
                : '';
            final actor = item.actorName ?? '';

            return Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: AppColors.pageBackground,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.softBrandBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.history_toggle_off_rounded,
                      size: 16.r,
                      color: AppColors.brandPrimary,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedAction,
                          style: AppTextStyles.font13Bold,
                        ),
                        if (actor.isNotEmpty || dateStr.isNotEmpty)
                          SizedBox(height: 2.h),
                        if (actor.isNotEmpty || dateStr.isNotEmpty)
                          Text(
                            '$actor  •  $dateStr',
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
