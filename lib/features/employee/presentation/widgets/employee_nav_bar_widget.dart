import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeNavBarWidget extends StatelessWidget {
  const EmployeeNavBarWidget({
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  static const _items = <NavBarItemData>[
    NavBarItemData(icon: Icons.home_outlined, labelKey: 'employee.nav.home'),
    NavBarItemData(
      icon: Icons.access_time_rounded,
      labelKey: 'employee.nav.clock',
    ),
    NavBarItemData(
      icon: Icons.assignment_outlined,
      labelKey: 'employee.nav.tasks',
    ),
    NavBarItemData(icon: Icons.map_outlined, labelKey: 'employee.nav.plans'),
    NavBarItemData(
      icon: Icons.calendar_today_outlined,
      labelKey: 'employee.nav.leaves',
    ),
    NavBarItemData(
      icon: Icons.settings_outlined,
      labelKey: 'employee.nav.settings',
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
