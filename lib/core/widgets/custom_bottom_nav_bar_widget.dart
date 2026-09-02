import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class NavBarItemData {
  const NavBarItemData({required this.icon, required this.labelKey});

  final IconData icon;
  final String labelKey;
}

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

class CustomBottomNavBarWidget extends StatelessWidget {
  const CustomBottomNavBarWidget({
    required this.items,
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
  });

  final List<NavBarItemData> items;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: const Border(top: BorderSide(color: AppColors.border)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 14,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(top: 2.h, bottom: 6.h),
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++)
            CustomBottomNavItemWidget(
              item: items[i],
              isSelected: selectedIndex == i,
              onTap: () => onTabSelected(i),
            ),
        ],
      ),
    );
  }
}
