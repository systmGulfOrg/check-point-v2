import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/project_models.dart';
import '../cubit/projects_cubit.dart';
import '../cubit/projects_state.dart';

class ProjectTaskDetailActivityLogListWidget extends StatelessWidget {
  const ProjectTaskDetailActivityLogListWidget({super.key});

  String _formatAuditAction(String? action) {
    if (action == null || action.isEmpty) return '';
    return switch (action.toLowerCase()) {
      'created' => 'Created',
      'status_changed' => 'Status changed',
      'assigned' => 'Assigned',
      'unassigned' => 'Unassigned',
      'tags_updated' => 'Tags updated',
      'due_date_changed' => 'Due date updated',
      'updated' => 'Updated',
      'priority_changed' => 'Priority changed',
      _ => action.replaceAll('_', ' '),
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (context, state) {
        final audit = switch (state) {
          ProjectsStateSuccess(:final audit) => audit,
          _ => const <TaskAuditModel>[],
        };

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
                ? AppDateFormatter.formatDateString(item.createdAt!)
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
                    decoration: const BoxDecoration(
                      color: AppColors.softBrandBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.history_toggle_off_rounded,
                      size: 16.r,
                      color: AppColors.brandPrimary,
                    ),
                  ),
                  wSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(formattedAction, style: AppTextStyles.font13Bold),
                        if (actor.isNotEmpty || dateStr.isNotEmpty)
                          hSpace(2),
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
