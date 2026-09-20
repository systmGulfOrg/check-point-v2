import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class LeaveBalanceValueWidget extends StatelessWidget {
  const LeaveBalanceValueWidget({
    required this.label,
    required this.value,
    this.color,
    super.key,
  });

  final String label;
  final int value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: AppTextStyles.font18Bold.copyWith(
            color: color ?? AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 2.h),
        Text(label.tr(context: context), style: AppTextStyles.font11Regular),
      ],
    );
  }
}
