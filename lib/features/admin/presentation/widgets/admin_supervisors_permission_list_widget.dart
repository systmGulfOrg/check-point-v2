import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'admin_supervisor_permission_card_widget.dart';
import 'admin_supervisor_permission_data.dart';

class AdminSupervisorsPermissionListWidget extends StatelessWidget {
  const AdminSupervisorsPermissionListWidget({
    required this.supervisors,
    required this.onSupervisorTap,
    super.key,
  });

  final List<EmployeeModel> supervisors;
  final ValueChanged<String> onSupervisorTap;

  @override
  Widget build(BuildContext context) {
    final supervisorsData = supervisors
        .where(
          (employee) =>
              employee.id != null &&
              employee.role?.toLowerCase().contains('supervisor') == true,
        )
        .map(
          (employee) => AdminSupervisorPermissionData(
            id: employee.id!,
            name: employee.name ?? employee.userName ?? '-',
            email: employee.userName ?? '-',
            initials: _initials(employee.name ?? employee.userName),
            permissionCount: [
              employee.canAddAttendance,
              employee.canAddPlan,
            ].where((permission) => permission == true).length,
          ),
        )
        .toList();
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: supervisorsData.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (_, index) {
        final supervisor = supervisorsData[index];
        return AdminSupervisorPermissionCardWidget(
          supervisor: supervisor,
          onTap: () => onSupervisorTap(supervisor.id),
        );
      },
    );
  }

  static String _initials(String? value) {
    final parts = (value ?? '').trim().split(RegExp(r'\s+'));
    final initials = parts
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();
    return initials.isEmpty ? '?' : initials;
  }
}
