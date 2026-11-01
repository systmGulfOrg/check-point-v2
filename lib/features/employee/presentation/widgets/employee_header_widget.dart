import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/notifications/presentation/widgets/notifications_icon_button_bloc_selector_widget.dart';
import 'employee_role_switch_bloc_builder_widget.dart';

/// Home header: avatar, time-of-day greeting and name, with the
/// role switch and notifications on the opposite side.
class EmployeeHeaderWidget extends StatelessWidget {
  const EmployeeHeaderWidget({
    required this.userName,
    this.imageUrl,
    super.key,
  });

  final String userName;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final greetingKey = DateTime.now().hour < 12
        ? 'employee.home.greetingMorning'
        : 'employee.home.greetingEvening';
    return Row(
      children: [
        AppAvatarWidget(
          imageUrl: imageUrl,
          name: userName,
          radius: 24.r,
          backgroundColor: AppColors.softBrandBackground,
          textColor: AppColors.brandPrimaryDark,
        ),
        wSpace(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greetingKey.tr(context: context),
                style: AppTextStyles.font13Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font18Bold,
              ),
            ],
          ),
        ),
        const EmployeeRoleSwitchBlocBuilderWidget(),
        const NotificationsIconButtonBlocSelectorWidget(),
      ],
    );
  }
}
