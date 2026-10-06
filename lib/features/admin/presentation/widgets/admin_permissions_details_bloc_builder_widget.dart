import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/permissions/admin_permission_employee_model.dart';
import '../../data/models/permissions/admin_permission_user_model.dart';
import '../../data/models/permissions/admin_permissions_catalogue_model.dart';
import '../cubit/permissions/admin_permissions_cubit.dart';
import '../cubit/permissions/admin_permissions_state.dart';
import 'admin_permissions_details_content_widget.dart';

class AdminPermissionsDetailsBlocBuilderWidget extends StatelessWidget {
  const AdminPermissionsDetailsBlocBuilderWidget({super.key});

  Widget _buildSkeleton(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: AdminPermissionsDetailsContentWidget(
        user: const AdminPermissionEmployeeModel(
          id: '1',
          name: 'Loading Employee Name',
          email: 'employee@company.com',
          user: AdminPermissionUserModel(
            id: '1',
            role: 'Supervisor',
            roles: ['Supervisor'],
          ),
        ),
        catalogue: const AdminPermissionsCatalogueModel(
          catalogue: [
            'Attendance.View',
            'Attendance.Edit',
            'Leave.View',
            'Leave.Approve',
          ],
          roles: {
            'Supervisor': ['Attendance.View', 'Leave.View'],
          },
        ),
        selectedPermissions: const ['Attendance.View'],
        saving: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminPermissionsCubit, AdminPermissionsState>(
      builder: (context, state) => switch (state) {
        AdminPermissionsInitial() ||
        AdminPermissionsLoading() => _buildSkeleton(context),
        AdminPermissionsError(:final messageKey) => Center(
          child: Text(messageKey.tr(context: context)),
        ),
        AdminPermissionsSuccess(
          :final selectedUser,
          :final catalogue,
          :final selectedPermissions,
          :final loadingDetails,
          :final saving,
        ) =>
          selectedUser == null
              ? Center(
                  child: Text('admin.permissions.noUser'.tr(context: context)),
                )
              : loadingDetails
              ? _buildSkeleton(context)
              : AdminPermissionsDetailsContentWidget(
                  user: selectedUser,
                  catalogue: catalogue,
                  selectedPermissions: selectedPermissions,
                  saving: saving,
                ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
