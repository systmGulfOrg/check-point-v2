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
import 'package:check_point_v2/features/projects/presentation/screens/projects_screen.dart';

class EmployeeMainScreen extends StatefulWidget {
  const EmployeeMainScreen({super.key});

  @override
  State<EmployeeMainScreen> createState() => _EmployeeMainScreenState();
}

class _EmployeeMainScreenState extends State<EmployeeMainScreen> {
  int _selectedIndex = 0;

  List<Widget> _buildScreens(TenantFeaturesCubit cubit) {
    int plansIndex = 1;

    if (cubit.isEnabled(AppFeatureKeys.attendance)) plansIndex++;
    if (cubit.isEnabled(AppFeatureKeys.tasks)) plansIndex++;

    return <Widget>[
      EmployeeHomeScreen(
        onViewAllTasks: () => setState(
          () => _selectedIndex =
              cubit.isEnabled(AppFeatureKeys.attendance) ? 2 : 1,
        ),
        onViewAllPlans: () => setState(() => _selectedIndex = plansIndex),
      ),
      if (cubit.isEnabled(AppFeatureKeys.attendance))
        const EmployeeClockScreen(),
      if (cubit.isEnabled(AppFeatureKeys.tasks)) const ProjectsScreen(),
      const EmployeePlansScreen(),
      if (cubit.isEnabled(AppFeatureKeys.leave))
        const LeavesDashboardScreen(),
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
