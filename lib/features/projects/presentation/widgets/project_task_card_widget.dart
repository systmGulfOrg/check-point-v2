import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/project_models.dart';

class ProjectTaskCardWidget extends StatelessWidget {
  const ProjectTaskCardWidget({
    required this.task,
    required this.boardProject,
    required this.onTap,
    this.canManage = false,
    this.onMoveStatus,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final ProjectTaskModel task;
  final ProjectModel boardProject;
  final VoidCallback onTap;
  final bool canManage;
  final ValueChanged<String>? onMoveStatus;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

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

  @override
  Widget build(BuildContext context) {
    final status = boardProject.statuses.firstWhere(
      (item) => item.id == task.statusId,
      orElse: () => boardProject.statuses.isNotEmpty
          ? boardProject.statuses.first
          : const ProjectStatusModel(id: '', name: ''),
    );

    final priority = task.priority ?? 'NORMAL';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Padding(
          padding: EdgeInsets.all(14.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: _priorityBackground(priority),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      priority,
                      style: AppTextStyles.font12Bold.copyWith(
                        color: _priorityColor(priority),
                      ),
                    ),
                  ),
                  wSpace(8),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      status.name,
                      style: AppTextStyles.font11Medium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (canManage)
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      onSelected: (value) {
                        if (value == 'edit') {
                          onEdit?.call();
                        } else if (value == 'delete') {
                          onDelete?.call();
                        } else {
                          onMoveStatus?.call(value);
                        }
                      },
                      itemBuilder: (_) => [
                        if (onEdit != null)
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.edit_outlined,
                                  size: 18,
                                  color: AppColors.textPrimary,
                                ),
                                wSpace(8),
                                Text('common.edit'.tr(context: context)),
                              ],
                            ),
                          ),
                        ...boardProject.statuses
                            .where((s) => s.id != task.statusId)
                            .map(
                              (s) => PopupMenuItem(
                                value: s.id,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.swap_horiz_rounded,
                                      size: 18,
                                      color: AppColors.brandPrimary,
                                    ),
                                    wSpace(8),
                                    Text(
                                      '${'projects.moveTo'.tr(context: context)} ${s.name}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        if (onDelete != null)
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.delete_outline,
                                  size: 18,
                                  color: AppColors.error,
                                ),
                                wSpace(8),
                                Text(
                                  'common.delete'.tr(context: context),
                                  style: const TextStyle(color: AppColors.error),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
              hSpace(8),
              Text(
                task.title,
                style: AppTextStyles.font16Bold,
              ),
              if (task.description?.isNotEmpty == true) ...[
                hSpace(4),
                Text(
                  task.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
              hSpace(12),
              Row(
                children: [
                  if (task.assigneeIds.isNotEmpty) ...[
                    Wrap(
                      spacing: -6.w,
                      children: task.assigneeIds.take(3).map((id) {
                        return CircleAvatar(
                          radius: 12.r,
                          backgroundColor: AppColors.brandPrimary,
                          child: Text(
                            id.isNotEmpty ? id[0].toUpperCase() : '?',
                            style: AppTextStyles.font12Bold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    wSpace(8),
                  ],
                  if (task.dueDate?.isNotEmpty == true) ...[
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14.r,
                      color: AppColors.textSecondary,
                    ),
                    wSpace(4),
                    Text(
                      AppDateFormatter.formatDateString(task.dueDate),
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    wSpace(12),
                  ],
                  if (task.attachments.isNotEmpty) ...[
                    Icon(
                      Icons.attach_file_rounded,
                      size: 14.r,
                      color: AppColors.textSecondary,
                    ),
                    wSpace(2),
                    Text(
                      '${task.attachments.length}',
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
