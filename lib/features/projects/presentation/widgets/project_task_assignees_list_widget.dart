import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';

class ProjectTaskAssigneesListWidget extends StatelessWidget {
  const ProjectTaskAssigneesListWidget({
    super.key,
    required this.assigneeIds,
    required this.findEmployee,
    required this.getAssigneeName,
    required this.getAssigneeImageUrl,
  });

  final List<String> assigneeIds;
  final EmployeeModel? Function(String id) findEmployee;
  final String Function(String id) getAssigneeName;
  final String? Function(String id) getAssigneeImageUrl;

  @override
  Widget build(BuildContext context) {
    if (assigneeIds.isEmpty) {
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
      children: assigneeIds.map((id) {
        final displayName = getAssigneeName(id);
        final imageUrl = getAssigneeImageUrl(id);
        final emp = findEmployee(id);
        final initial = displayName.trim().isNotEmpty
            ? displayName.trim()[0].toUpperCase()
            : '?';
        final subtitle =
            emp?.position ?? emp?.email ?? emp?.departmentName ?? id;

        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: AppColors.pageBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 4.h,
            ),
            leading: AppAvatarWidget(
              imageUrl: imageUrl,
              name: displayName,
              initials: initial,
              subtitle: subtitle,
              radius: 20.r,
              enablePreview: true,
            ),
            title: Text(displayName, style: AppTextStyles.font14Bold),
            subtitle: subtitle != displayName
                ? Text(
                    subtitle,
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
}
