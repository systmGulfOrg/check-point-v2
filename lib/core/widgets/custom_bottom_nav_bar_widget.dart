import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';
import 'custom_bottom_nav_item_widget.dart';
import 'nav_bar_item_data.dart';

export 'custom_bottom_nav_item_widget.dart';
export 'nav_bar_item_data.dart';

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
