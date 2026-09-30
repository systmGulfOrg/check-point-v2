import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';

class ProjectTaskDetailAssigneesListWidget extends StatelessWidget {
  const ProjectTaskDetailAssigneesListWidget({
    required this.assigneeIds,
    required this.employees,
    super.key,
  });

  final List<String> assigneeIds;
  final List<EmployeeModel> employees;

  EmployeeModel? _findEmployee(String id) {
    for (final emp in employees) {
      if (emp.id == id || emp.employeeCode == id) return emp;
    }
    return null;
  }

  String _getAssigneeName(String id) {
    final emp = _findEmployee(id);
    if (emp != null && emp.name != null && emp.name!.isNotEmpty) {
      return emp.name!;
    }
    return id;
  }

  String? _getAssigneeImageUrl(String id) {
    return _findEmployee(id)?.imageUrl;
  }

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
        final displayName = _getAssigneeName(id);
        final imageUrl = _getAssigneeImageUrl(id);
        final emp = _findEmployee(id);
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
            leading: CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColors.softBrandBackground,
              backgroundImage: imageUrl?.isNotEmpty == true
                  ? NetworkImage(imageUrl!)
                  : null,
              child: imageUrl?.isNotEmpty == true
                  ? null
                  : Text(
                      initial,
                      style: AppTextStyles.font16Bold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
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
