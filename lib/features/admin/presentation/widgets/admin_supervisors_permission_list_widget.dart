import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'admin_supervisor_permission_card_widget.dart';
import 'admin_supervisor_permission_data.dart';

class AdminSupervisorsPermissionListWidget extends StatelessWidget {
  const AdminSupervisorsPermissionListWidget({
    required this.onSupervisorTap,
    super.key,
  });

  final ValueChanged<String> onSupervisorTap;

  static const _supervisors = <AdminSupervisorPermissionData>[
    AdminSupervisorPermissionData(
      nameKey: 'admin.permissions.supervisors.sarah.name',
      email: 'sarah.johnson@checkpoint.app',
      initials: 'SJ',
      permissionCount: 0,
    ),
    AdminSupervisorPermissionData(
      nameKey: 'admin.permissions.supervisors.ali.name',
      email: 'ali.hassan@checkpoint.app',
      initials: 'AH',
      permissionCount: 7,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _supervisors.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (_, index) => AdminSupervisorPermissionCardWidget(
        supervisor: _supervisors[index],
        onTap: () => onSupervisorTap(_supervisors[index].nameKey),
      ),
    );
  }
}
