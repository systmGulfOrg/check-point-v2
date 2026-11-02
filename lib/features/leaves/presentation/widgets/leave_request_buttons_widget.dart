import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

/// "Request leave" and "Request permit" side by side at the top of the
/// requests screen.
class LeaveRequestButtonsWidget extends StatelessWidget {
  const LeaveRequestButtonsWidget({
    required this.onRequestLeave,
    required this.onRequestPermit,
    super.key,
  });

  final VoidCallback onRequestLeave;
  final VoidCallback onRequestPermit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'leaves.dashboard.requestLeave'.tr(context: context),
            icon: Icons.beach_access_rounded,
            height: 46,
            onTap: onRequestLeave,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomButton(
            text: 'leaves.dashboard.requestPermission'.tr(context: context),
            icon: Icons.timer_outlined,
            height: 46,
            backgroundColor: AppColors.softBrandBackground,
            textColor: AppColors.brandPrimary,
            onTap: onRequestPermit,
          ),
        ),
      ],
    );
  }
}
