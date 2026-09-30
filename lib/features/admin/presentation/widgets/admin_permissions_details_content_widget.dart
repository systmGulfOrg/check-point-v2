import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/permissions/admin_permission_employee_model.dart';
import '../../data/models/permissions/admin_permissions_catalogue_model.dart';
import 'admin_permissions_admin_banner_widget.dart';
import 'admin_permissions_role_permissions_list_widget.dart';

class AdminPermissionsDetailsContentWidget extends StatelessWidget {
  const AdminPermissionsDetailsContentWidget({
    required this.user,
    required this.catalogue,
    required this.selectedPermissions,
    required this.saving,
    super.key,
  });

  final AdminPermissionEmployeeModel user;
  final AdminPermissionsCatalogueModel catalogue;
  final List<String> selectedPermissions;
  final bool saving;

  @override
  Widget build(BuildContext context) {
    final roles = user.user.allRoles.isEmpty ? ['Employee'] : user.user.allRoles;
    final isPureAdmin = roles.length == 1 && roles.first == 'Admin';
    final hasMultipleRoles = roles.length > 1;

    final roleText = roles.join(', ');
    final contact = user.email ??
        user.employeeCode ??
        'admin.permissions.notAvailable'.tr(context: context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 21.r,
              backgroundColor: AppColors.softBlueBackground,
              child: Text(
                user.initials,
                style: AppTextStyles.font12Bold.copyWith(color: AppColors.info),
              ),
            ),
            vSpace(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: AppTextStyles.font16Bold),
                  Text(
                    '$roleText • $contact',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.placeholder,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        hSpace(14),
        if (isPureAdmin)
          const Expanded(
            child: SingleChildScrollView(
              child: AdminPermissionsAdminBannerWidget(),
            ),
          )
        else if (hasMultipleRoles)
          Expanded(
            child: DefaultTabController(
              length: roles.length,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    isScrollable: true,
                    labelColor: AppColors.brandPrimary,
                    unselectedLabelColor: AppColors.textSecondary,
                    indicatorColor: AppColors.brandPrimary,
                    tabs: roles.map((r) => Tab(text: r)).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: roles.map((r) {
                        if (r == 'Admin') {
                          return const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: SingleChildScrollView(
                              child: AdminPermissionsAdminBannerWidget(),
                            ),
                          );
                        }
                        return AdminPermissionsRolePermissionsListWidget(
                          catalogue: catalogue,
                          selectedPermissions: selectedPermissions,
                          saving: saving,
                          role: r,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: AdminPermissionsRolePermissionsListWidget(
              catalogue: catalogue,
              selectedPermissions: selectedPermissions,
              saving: saving,
              role: roles.first,
            ),
          ),
      ],
    );
  }
}
