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
                children: [
                  Container(
                    width: 44.r,
                    height: 44.r,
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
                  vSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          style: AppTextStyles.font16Bold,
                        ),
                        if (project.departmentName?.isNotEmpty == true ||
                            project.managerName?.isNotEmpty == true) ...[
                          hSpace(4),
                          Wrap(
                            spacing: 6.w,
                            runSpacing: 4.h,
                            children: [
                              if (project.departmentName?.isNotEmpty == true)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.softBlueBackground,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.business_rounded,
                                        size: 12.r,
                                        color: AppColors.brandPrimary,
                                      ),
                                      wSpace(3),
                                      Text(
                                        project.departmentName!,
                                        style: AppTextStyles.font11Medium.copyWith(
                                          color: AppColors.brandPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (project.managerName?.isNotEmpty == true)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.softBrandBackground,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.person_outline_rounded,
                                        size: 12.r,
                                        color: AppColors.brandPrimary,
                                      ),
                                      wSpace(3),
                                      Text(
                                        project.managerName!,
                                        style: AppTextStyles.font11Medium.copyWith(
                                          color: AppColors.brandPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                        if (project.description?.isNotEmpty == true ||
                            project.code?.isNotEmpty == true) ...[
                          hSpace(4),
                          Text(
                            project.description ?? project.code ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
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
                            child: Text(
                              'common.edit'.tr(context: context),
                              style: AppTextStyles.font14Bold.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (onEdit != null && onDelete != null)
                    Container(
                      width: 1,
                      height: 18.h,
                      color: AppColors.border,
                    ),
                  if (onDelete != null)
                    Expanded(
                      child: InkWell(
                        onTap: onDelete,
                        borderRadius: BorderRadius.circular(8.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Center(
                            child: Text(
                              'common.delete'.tr(context: context),
                              style: AppTextStyles.font14Bold.copyWith(
                                color: AppColors.error,
                              ),
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
