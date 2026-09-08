import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminLocationActionWidget extends StatelessWidget {
  const AdminLocationActionWidget({
    required this.labelKey,
    required this.color,
    this.onTap,
    super.key,
  });

  final String labelKey;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        alignment: Alignment.center,
        child: Text(
          labelKey.tr(context: context),
          style: AppTextStyles.font13SemiBold.copyWith(color: color),
        ),
      ),
    );
  }
}
