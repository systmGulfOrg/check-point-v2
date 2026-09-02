import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../admin/presentation/widgets/admin_settings_sign_out_button_widget.dart';
import '../widgets/supervisor_profile_options_widget.dart';
import '../widgets/supervisor_profile_summary_widget.dart';

class SupervisorProfileScreen extends StatelessWidget {
  const SupervisorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'supervisor.nav.profile'.tr(context: context),
              style: AppTextStyles.font20Bold,
            ),
            hSpace(20),
            const SupervisorProfileSummaryWidget(),
            hSpace(20),
            const SupervisorProfileOptionsWidget(),
            hSpace(20),
            const AdminSettingsSignOutButtonWidget(),
          ],
        ),
      ),
    );
  }
}
