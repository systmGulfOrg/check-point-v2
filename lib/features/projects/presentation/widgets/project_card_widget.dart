import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/project_models.dart';

class ProjectCardWidget extends StatelessWidget {
  const ProjectCardWidget({
    required this.project,
    required this.onTap,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final ProjectModel project;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46.r,
                    height: 46.r,
                    decoration: BoxDecoration(
                      color: AppColors.softBrandBackground,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.folder_open_rounded,
                      color: AppColors.brandPrimary,
                      size: 24.r,
                    ),
                  ),
                  wSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                project.name,
                                style: AppTextStyles.font16Bold,
                              ),
                            ),
                            if (project.code?.isNotEmpty == true)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.pageBackground,
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Text(
                                  project.code!,
                                  style: AppTextStyles.font12Bold.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (project.departmentName?.isNotEmpty == true ||
                            project.managerName?.isNotEmpty == true) ...[
                          hSpace(6),
                          Wrap(
                            spacing: 6.w,
                            runSpacing: 4.h,
                            children: [
                              if (project.departmentName?.isNotEmpty == true)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.softBlueBackground,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.business_rounded,
                                        size: 13.r,
                                        color: AppColors.brandPrimary,
                                      ),
                                      wSpace(4),
                                      Text(
                                        project.departmentName!,
                                        style: AppTextStyles.font11Medium
                                            .copyWith(
                                              color: AppColors.brandPrimary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (project.managerName?.isNotEmpty == true)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.softBrandBackground,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.person_outline_rounded,
                                        size: 13.r,
                                        color: AppColors.brandPrimary,
                                      ),
                                      wSpace(4),
                                      Text(
                                        project.managerName!,
                                        style: AppTextStyles.font11Medium
                                            .copyWith(
                                              color: AppColors.brandPrimary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                        if (project.description?.isNotEmpty == true) ...[
                          hSpace(6),
                          Text(
                            project.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                        if (project.statuses.isNotEmpty) ...[
                          hSpace(8),
                          Wrap(
                            spacing: 4.w,
                            runSpacing: 4.h,
                            children: project.statuses.map((status) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.pageBackground,
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Text(
                                  status.name,
                                  style: AppTextStyles.font11Regular.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.placeholder,
                  ),
                ],
              ),
            ),
          ),
          if (onEdit != null || onDelete != null) ...[
            const Divider(height: 1, color: AppColors.border),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              child: Row(
                children: [
                  if (onEdit != null)
                    Expanded(
                      child: InkWell(
                        onTap: onEdit,
                        borderRadius: BorderRadius.circular(8.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.edit_outlined,
                                  size: 16,
                                  color: AppColors.textSecondary,
                                ),
                                wSpace(6),
                                Text(
                                  'common.edit'.tr(context: context),
                                  style: AppTextStyles.font14Bold.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (onEdit != null && onDelete != null)
                    Container(width: 1, height: 18.h, color: AppColors.border),
                  if (onDelete != null)
                    Expanded(
                      child: InkWell(
                        onTap: onDelete,
                        borderRadius: BorderRadius.circular(8.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.delete_outline,
                                  size: 16,
                                  color: AppColors.error,
                                ),
                                wSpace(6),
                                Text(
                                  'common.delete'.tr(context: context),
                                  style: AppTextStyles.font14Bold.copyWith(
                                    color: AppColors.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
