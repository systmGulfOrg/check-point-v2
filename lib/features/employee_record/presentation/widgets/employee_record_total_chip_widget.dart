import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeRecordTotalChipWidget extends StatelessWidget {
  const EmployeeRecordTotalChipWidget({
    required this.labelKey,
    required this.value,
    required this.color,
    super.key,
  });

  final String labelKey;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: AppColors.border),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          NumberFormat.decimalPattern(context.locale.toString()).format(value),
          style: AppTextStyles.font14Bold.copyWith(color: color),
        ),
        vSpace(6),
        Text(labelKey.tr(context: context), style: AppTextStyles.font12Regular),
      ],
    ),
  );
}
