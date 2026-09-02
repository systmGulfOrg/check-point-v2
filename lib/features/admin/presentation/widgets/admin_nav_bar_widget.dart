import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AdminNavBarWidget extends StatelessWidget {
  const AdminNavBarWidget({
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  static const _items = <NavBarItemData>[
    NavBarItemData(
      icon: Icons.home_outlined,
      labelKey: 'admin.nav.home',
    ),
    NavBarItemData(
      icon: Icons.person_outline_rounded,
      labelKey: 'admin.nav.requests',
    ),
    NavBarItemData(
      icon: Icons.group_outlined,
      labelKey: 'admin.nav.employees',
    ),
    NavBarItemData(
      icon: Icons.grid_view_rounded,
      labelKey: 'admin.nav.manage',
    ),
    NavBarItemData(
      icon: Icons.settings_outlined,
      labelKey: 'admin.nav.settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavBarWidget(
      items: _items,
      selectedIndex: selectedIndex,
      onTabSelected: onTabSelected,
    );
  }
}
