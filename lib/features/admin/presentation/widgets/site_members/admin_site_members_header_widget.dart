import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';

class AdminSiteMembersHeaderWidget extends StatelessWidget {
  const AdminSiteMembersHeaderWidget({
    required this.site,
    required this.contractorCount,
    required this.workerCount,
    super.key,
  });

  final SiteBoundaryModel site;
  final int contractorCount;
  final int workerCount;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(16.r),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: AppColors.border),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: AppColors.softBlueBackground,
              child: Icon(
                Icons.map_outlined,
                color: AppColors.info,
                size: 24.r,
              ),
            ),
            vSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    site.siteName.isEmpty ? '-' : site.siteName,
                    style: AppTextStyles.font16Bold,
                  ),
                  if (site.projectName != null &&
                      site.projectName!.isNotEmpty) ...[
                    hSpace(2),
                    Text(
                      site.projectName!,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.softGreenBackground,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                site.status.tr(context: context),
                style: AppTextStyles.font11Medium.copyWith(
                  color: AppColors.success,
                ),
              ),
            ),
          ],
        ),
        hSpace(14),
        const Divider(height: 1, color: AppColors.border),
        hSpace(12),
        Row(
          children: [
            Expanded(
              child: _buildStatItem(
                context,
                title: 'admin.siteMembers.contractors'.tr(context: context),
                count: contractorCount,
                icon: Icons.business_rounded,
                color: AppColors.brandPrimary,
              ),
            ),
            Container(width: 1, height: 32.h, color: AppColors.border),
            Expanded(
              child: _buildStatItem(
                context,
                title: 'admin.siteMembers.workers'.tr(context: context),
                count: workerCount,
                icon: Icons.groups_rounded,
                color: AppColors.info,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildStatItem(
    BuildContext context, {
    required String title,
    required int count,
    required IconData icon,
    required Color color,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, size: 18.r, color: color),
      vSpace(6),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$count',
            style: AppTextStyles.font14Bold.copyWith(color: AppColors.textPrimary),
          ),
          Text(
            title,
            style: AppTextStyles.font11Medium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ],
  );
}
