import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/permissions/admin_permissions_cubit.dart';
import '../cubit/permissions/admin_permissions_state.dart';
import 'admin_permissions_details_content_widget.dart';
import 'admin_permissions_details_skeleton_widget.dart';

class AdminPermissionsDetailsBlocBuilderWidget extends StatelessWidget {
  const AdminPermissionsDetailsBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminPermissionsCubit, AdminPermissionsState>(
      builder: (context, state) => switch (state) {
        AdminPermissionsInitial() ||
        AdminPermissionsLoading() =>
          const AdminPermissionsDetailsSkeletonWidget(),
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
          loadingDetails || selectedUser == null
              ? const AdminPermissionsDetailsSkeletonWidget()
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
