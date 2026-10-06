import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/styles/app_motion.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_nav_bar_bloc_builder.dart';
import 'employee_clock_screen.dart';
import 'employee_home_screen.dart';
import 'package:check_point_v2/features/leaves/presentation/screens/leaves_dashboard_screen.dart';
import 'employee_plans_screen.dart';
import 'employee_settings_screen.dart';

class EmployeeMainScreen extends StatefulWidget {
  const EmployeeMainScreen({super.key});

  @override
  State<EmployeeMainScreen> createState() => _EmployeeMainScreenState();
}

class _EmployeeMainScreenState extends State<EmployeeMainScreen> {
  int _selectedIndex = 0;

  List<Widget> _buildScreens(TenantFeaturesCubit cubit) {
    int currentIdx = 1;
    final hasAttendance = cubit.isEnabled(AppFeatureKeys.attendance);
    if (hasAttendance) {
      currentIdx++;
    }

    final int plansIdx = currentIdx++;

    final hasLeaves = cubit.isEnabled(AppFeatureKeys.leave);
    final int? leavesIdx = hasLeaves ? currentIdx++ : null;

    return <Widget>[
      EmployeeHomeScreen(
        onViewAllPlans: () => setState(() => _selectedIndex = plansIdx),
        onViewLeaves: leavesIdx != null
            ? () => setState(() => _selectedIndex = leavesIdx)
            : () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LeavesDashboardScreen(),
                ),
              ),
      ),
      if (hasAttendance) const EmployeeClockScreen(),
      const EmployeePlansScreen(),
      if (hasLeaves) const LeavesDashboardScreen(),
      const EmployeeSettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TenantFeaturesCubit, TenantFeaturesState>(
      builder: (context, state) {
        final cubit = context.read<TenantFeaturesCubit>();
        final screens = _buildScreens(cubit);

        // Clamp index to avoid out-of-bounds after feature state changes.
        final safeIndex = _selectedIndex.clamp(0, screens.length - 1);

        return Scaffold(
          backgroundColor: AppColors.white,
          body: AnimatedSwitcher(
            duration: AppMotion.tabSwitch,
            switchInCurve: AppMotion.enterCurve,
            switchOutCurve: AppMotion.exitCurve,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: AppMotion.routeScaleBegin,
                  end: 1,
                ).animate(animation),
                child: child,
              ),
            ),
            child: IndexedStack(
              key: ValueKey<int>(safeIndex),
              index: safeIndex,
              children: screens,
            ),
          ),
          bottomNavigationBar: EmployeeNavBarBlocBuilder(
            selectedIndex: safeIndex,
            onTabSelected: (index) {
              setState(() => _selectedIndex = index);
            },
          ),
        );
      },
    );
  }
}
