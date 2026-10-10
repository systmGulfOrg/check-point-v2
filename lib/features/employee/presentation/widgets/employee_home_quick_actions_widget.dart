import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'employee_quick_action_button_widget.dart';

class EmployeeHomeQuickActionsWidget extends StatelessWidget {
  const EmployeeHomeQuickActionsWidget({
    required this.onRequestLeave,
    required this.onRequestPermission,
    this.onCustomerVisitsTap,
    super.key,
  });

  final VoidCallback onRequestLeave;
  final VoidCallback onRequestPermission;
  final VoidCallback? onCustomerVisitsTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'employee.home.quickActions'.tr(context: context),
          style: AppTextStyles.font16Bold,
        ),
        hSpace(12),
        Row(
          children: [
            Expanded(
              child: EmployeeQuickActionButtonWidget(
                icon: Icons.beach_access_rounded,
                title: 'employee.home.requestLeave'.tr(context: context),
                iconColor: AppColors.brandPrimary,
                backgroundColor: AppColors.softBrandBackground,
                borderColor: AppColors.brandPrimary.withValues(alpha: 0.2),
                onTap: onRequestLeave,
              ),
            ),
            wSpace(12),
            Expanded(
              child: EmployeeQuickActionButtonWidget(
                icon: Icons.timer_outlined,
                title: 'employee.home.requestPermission'.tr(context: context),
                iconColor: AppColors.info,
                backgroundColor: AppColors.softBlueBackground,
                borderColor: AppColors.info.withValues(alpha: 0.2),
                onTap: onRequestPermission,
              ),
            ),
          ],
        ),
        if (onCustomerVisitsTap != null) ...[
          hSpace(10),
          EmployeeQuickActionButtonWidget(
            icon: Icons.handshake_outlined,
            title: 'employee.home.customerVisits'.tr(context: context),
            iconColor: AppColors.warning,
            backgroundColor: AppColors.softYellowBackground,
            borderColor: AppColors.warning.withValues(alpha: 0.25),
            onTap: onCustomerVisitsTap!,
          ),
        ],
      ],
    );
  }
}
