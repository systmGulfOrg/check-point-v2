import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/permissions/admin_permissions_catalogue_model.dart';
import '../cubit/permissions/admin_permissions_cubit.dart';
import 'admin_permission_badge_widget.dart';
import 'admin_permissions_permission_row_widget.dart';

class AdminPermissionsRolePermissionsListWidget extends StatelessWidget {
  const AdminPermissionsRolePermissionsListWidget({
    required this.catalogue,
    required this.selectedPermissions,
    required this.saving,
    required this.role,
    super.key,
  });

  final AdminPermissionsCatalogueModel catalogue;
  final List<String> selectedPermissions;
  final bool saving;
  final String role;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdminPermissionsCubit>();
    final grouped = cubit.groupedPermissions(catalogue);

    return ListView(
      padding: EdgeInsets.only(top: 14.h, bottom: 24.h),
      children: [
        ...grouped.entries.map(
          (entry) => Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: AppColors.pageBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.key, style: AppTextStyles.font14Bold),
                      AdminPermissionBadgeWidget(
                        label: '${entry.value.length}',
                        color: AppColors.info,
                        background: AppColors.softBlueBackground,
                      ),
                    ],
                  ),
                  hSpace(8),
                  ...entry.value.map(
                    (permission) {
                      final isBase = cubit.isBasePermission(permission);
                      final isSelected = selectedPermissions.contains(permission);
                      return AdminPermissionsPermissionRowWidget(
                        permission: permission,
                        enabled: isSelected || isBase,
                        baseRole: isBase,
                        onChanged: () => cubit.togglePermission(permission),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        CustomButton(
          text: 'admin.permissions.save'.tr(context: context),
          onTap: () async {
            final saved = await cubit.saveSelected();
            if (saved && context.mounted) Navigator.pop(context);
          },
          isLoading: saving,
        ),
      ],
    );
  }
}
