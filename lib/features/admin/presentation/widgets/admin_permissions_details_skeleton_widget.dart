import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/permissions/admin_permission_employee_model.dart';
import '../../data/models/permissions/admin_permission_user_model.dart';
import '../../data/models/permissions/admin_permissions_catalogue_model.dart';
import 'admin_permissions_details_content_widget.dart';

class AdminPermissionsDetailsSkeletonWidget extends StatelessWidget {
  const AdminPermissionsDetailsSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
}
