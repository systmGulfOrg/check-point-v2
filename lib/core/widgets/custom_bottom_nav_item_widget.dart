import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'nav_bar_item_data.dart';

class CustomBottomNavItemWidget extends StatelessWidget {
  const CustomBottomNavItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final NavBarItemData item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final itemColor = isSelected
        ? AppColors.brandPrimary
        : AppColors.placeholder;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              height: 3.h,
              width: isSelected ? 28.w : 0,
              decoration: BoxDecoration(
                color: AppColors.brandPrimary,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            hSpace(10),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 1, end: isSelected ? 1.15 : 1.0),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) => Transform.scale(
                scale: scale,
                child: Icon(item.icon, color: itemColor, size: 24.r),
              ),
            ),
            hSpace(6),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: AppTextStyles.font11Medium.copyWith(
                color: itemColor,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
              child: Text(item.labelKey.tr(context: context)),
            ),
            hSpace(10),
          ],
        ),
      ),
    );
  }
}
