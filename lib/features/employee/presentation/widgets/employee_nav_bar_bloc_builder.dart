import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeNavBarBlocBuilder extends StatelessWidget {
  const EmployeeNavBarBlocBuilder({
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TenantFeaturesCubit, TenantFeaturesState>(
      builder: (context, state) {
        final cubit = context.read<TenantFeaturesCubit>();
        final items = <NavBarItemData>[
          const NavBarItemData(
            icon: Icons.home_outlined,
            labelKey: 'employee.nav.home',
          ),
          if (cubit.isEnabled(AppFeatureKeys.attendance))
            const NavBarItemData(
              icon: Icons.access_time_rounded,
              labelKey: 'employee.nav.clock',
            ),
          const NavBarItemData(
            icon: Icons.map_outlined,
            labelKey: 'employee.nav.plans',
          ),
          if (cubit.isEnabled(AppFeatureKeys.leave))
            const NavBarItemData(
              icon: Icons.calendar_today_outlined,
              labelKey: 'employee.nav.leaves',
            ),
          const NavBarItemData(
            icon: Icons.settings_outlined,
            labelKey: 'employee.nav.settings',
          ),
        ];

        return CustomBottomNavBarWidget(
          items: items,
          selectedIndex: selectedIndex,
          onTabSelected: onTabSelected,
        );
      },
    );
  }
}
