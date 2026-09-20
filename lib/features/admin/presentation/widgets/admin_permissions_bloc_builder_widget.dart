import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/permissions/admin_permission_employee_model.dart';
import '../cubit/permissions/admin_permissions_cubit.dart';
import '../cubit/permissions/admin_permissions_state.dart';
import 'admin_requests_empty_state_widget.dart';
import 'admin_permissions_user_card_widget.dart';

class AdminPermissionsBlocBuilderWidget extends StatelessWidget {
  const AdminPermissionsBlocBuilderWidget({
    required this.onManage,
    super.key,
  });

  final ValueChanged<AdminPermissionEmployeeModel> onManage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminPermissionsCubit, AdminPermissionsState>(
      builder: (context, state) => switch (state) {
        AdminPermissionsInitial() || AdminPermissionsLoading() =>
          const Center(child: CircularProgressIndicator()),
        AdminPermissionsError(:final messageKey) =>
          AdminRequestsEmptyStateWidget(messageKey: messageKey),
        AdminPermissionsSuccess(:final users, :final searchQuery) =>
          Column(
            children: [
              CustomTextFormField(
                hintText: 'admin.permissions.search'.tr(context: context),
                prefixIcon: const Icon(Icons.search),
                onChanged: context.read<AdminPermissionsCubit>().search,
              ),
              hSpace(14),
              if (users.isEmpty)
                AdminRequestsEmptyStateWidget(
                  messageKey: searchQuery.isEmpty
                      ? 'admin.permissions.noUsers'
                      : 'admin.permissions.noSearchResults',
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  separatorBuilder: (_, _) => hSpace(10),
                  itemBuilder: (_, index) => AdminPermissionsUserCardWidget(
                    user: users[index],
                    onManage: () => onManage(users[index]),
                  ),
                ),
            ],
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
