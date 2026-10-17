import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_notifications_bloc_builder_widget.dart';

class SupervisorNotificationsScreen extends StatelessWidget {
  const SupervisorNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'supervisor.notifications.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: const SafeArea(child: SupervisorNotificationsBlocBuilderWidget()),
    );
  }
}
