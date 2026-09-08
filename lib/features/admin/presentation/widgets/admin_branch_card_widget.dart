import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'admin_location_action_widget.dart';

class AdminBranchCardWidget extends StatelessWidget {
  const AdminBranchCardWidget({
    required this.branch,
    required this.onDelete,
    this.onEdit,
    super.key,
  });

  final BranchModel branch;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) => Container(
    decoration: AppDecorations.card,
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(14.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 19.r,
                backgroundColor: AppColors.softBlueBackground,
                child: Icon(
                  Icons.home_work_outlined,
                  color: AppColors.info,
                  size: 20.r,
                ),
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      branch.name ?? '-',
                      style: AppTextStyles.font14SemiBold,
                    ),
                    hSpace(4),
                    Text(
                      branch.description ?? '-',
                      style: AppTextStyles.font12Regular,
                    ),
                    hSpace(2),
                    Text(
                      branch.location ?? '-',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.placeholder,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: AdminLocationActionWidget(
                labelKey: 'admin.locations.edit',
                color: AppColors.textSecondary,
                onTap: onEdit,
              ),
            ),
            Expanded(
              child: AdminLocationActionWidget(
                labelKey: 'admin.locations.delete',
                color: AppColors.error,
                onTap: onDelete,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
