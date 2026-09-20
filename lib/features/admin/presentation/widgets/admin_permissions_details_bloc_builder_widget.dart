import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/permissions/admin_permissions_cubit.dart';
import '../cubit/permissions/admin_permissions_state.dart';
import 'admin_permissions_details_content_widget.dart';

class AdminPermissionsDetailsBlocBuilderWidget extends StatelessWidget {
  const AdminPermissionsDetailsBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminPermissionsCubit, AdminPermissionsState>(
      builder: (context, state) => switch (state) {
        AdminPermissionsInitial() || AdminPermissionsLoading() =>
          const Center(child: CircularProgressIndicator()),
        AdminPermissionsError(:final messageKey) => Center(
          child: Text(messageKey.tr(context: context)),
        ),
        AdminPermissionsSuccess(
          :final selectedUser,
          :final catalogue,
          :final selectedPermissions,
          :final loadingDetails,
          :final saving,
        ) => selectedUser == null
            ? Center(child: Text('admin.permissions.noUser'.tr(context: context)))
            : loadingDetails
            ? const Center(child: CircularProgressIndicator())
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
