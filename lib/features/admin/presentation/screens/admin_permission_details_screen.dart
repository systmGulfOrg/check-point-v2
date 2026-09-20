import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/permissions/admin_permission_employee_model.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_permissions_details_bloc_builder_widget.dart';

class AdminPermissionDetailsScreen extends StatelessWidget {
  const AdminPermissionDetailsScreen({required this.supervisorKey, super.key});

  final AdminPermissionEmployeeModel supervisorKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.permissions.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 0),
          child: const AdminPermissionsDetailsBlocBuilderWidget(),
        ),
      ),
    );
  }
}
