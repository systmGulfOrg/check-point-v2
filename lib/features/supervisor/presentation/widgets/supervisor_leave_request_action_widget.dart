import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class SupervisorLeaveRequestActionWidget extends StatelessWidget {
  const SupervisorLeaveRequestActionWidget({
    required this.labelKey,
    required this.color,
    super.key,
    this.onTap,
  });

  final String labelKey;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = labelKey.contains('.') ? labelKey.tr(context: context) : labelKey;
    final isEnabled = onTap != null;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 9.h),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.transparent : AppColors.pageBackground,
          border: const Border(top: BorderSide(color: AppColors.border)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTextStyles.font13SemiBold.copyWith(
            color: isEnabled ? color : AppColors.placeholder,
          ),
        ),
      ),
    );
  }
}
