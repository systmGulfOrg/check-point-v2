import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_policy_time_card_widget.dart';

class AdminPolicyTimeRangeWidget extends StatelessWidget {
  const AdminPolicyTimeRangeWidget({
    required this.clockIn,
    required this.clockOut,
    super.key,
  });

  final String clockIn;
  final String clockOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AdminPolicyTimeCardWidget(
            labelKey: 'admin.shifts.policies.timeInLabel',
            value: AppDateFormatter.formatTimeString(clockIn),
            icon: Icons.login_rounded,
            color: AppColors.success,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Icon(
            Icons.arrow_forward_rounded,
            size: 16.r,
            color: AppColors.placeholder,
            textDirection: Directionality.of(context),
          ),
        ),
        Expanded(
          child: AdminPolicyTimeCardWidget(
            labelKey: 'admin.shifts.policies.timeOutLabel',
            value: AppDateFormatter.formatTimeString(clockOut),
            icon: Icons.logout_rounded,
            color: AppColors.info,
          ),
        ),
      ],
    );
  }
}
