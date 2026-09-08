import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_supervisors_permission_list_widget.dart';

class AdminPermissionsScreen extends StatelessWidget {
  const AdminPermissionsScreen({super.key});

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
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'admin.permissions.description'.tr(context: context),
                style: AppTextStyles.font12Regular,
              ),
              hSpace(14),
              AdminSupervisorsPermissionListWidget(
                onSupervisorTap: (key) => Navigator.pushNamed(
                  context,
                  AppRoutes.adminPermissionDetails,
                  arguments: key,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
