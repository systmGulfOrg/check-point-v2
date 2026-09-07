import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class LanguageOptionTileWidget extends StatelessWidget {
  const LanguageOptionTileWidget({
    required this.label,
    required this.sublabel,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final String sublabel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.softBrandBackground
              : AppColors.pageBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.brandPrimary : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: isSelected
                        ? AppColors.brandPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                hSpace(2),
                Text(
                  sublabel,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.brandPrimary,
                size: 22.r,
              ),
          ],
        ),
      ),
    );
  }
}
