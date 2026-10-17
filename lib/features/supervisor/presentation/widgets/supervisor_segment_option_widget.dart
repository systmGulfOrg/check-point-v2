import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class SupervisorSegmentOptionWidget extends StatelessWidget {
  const SupervisorSegmentOptionWidget({
    required this.labelKey,
    required this.labelArgs,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String labelKey;
  final List<String> labelArgs;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          style: isSelected
              ? AppTextStyles.font12Bold.copyWith(color: AppColors.brandPrimary)
              : AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
          child: Text(
            labelKey.tr(context: context, args: labelArgs),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
