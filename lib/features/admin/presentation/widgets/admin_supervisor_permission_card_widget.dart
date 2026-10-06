import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_supervisor_permission_data.dart';

class AdminSupervisorPermissionCardWidget extends StatelessWidget {
  const AdminSupervisorPermissionCardWidget({
    required this.supervisor,
    required this.onTap,
    super.key,
  });

  final AdminSupervisorPermissionData supervisor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            AppAvatarWidget(
              imageUrl: supervisor.imageUrl,
              name: supervisor.name,
              initials: supervisor.initials,
              subtitle: supervisor.email,
              radius: 19.r,
              backgroundColor: AppColors.softBlueBackground,
              textColor: AppColors.info,
              enablePreview: true,
            ),
            vSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(supervisor.name, style: AppTextStyles.font14SemiBold),
                  hSpace(3),
                  Text(
                    supervisor.email,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.placeholder,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.shield_outlined, color: AppColors.info, size: 17.r),
            hSpace(4),
            Text(
              '${supervisor.permissionCount} / 10',
              style: AppTextStyles.font12Medium.copyWith(color: AppColors.info),
            ),
            hSpace(8),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.placeholder,
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}
