import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/styles/app_motion.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_nav_bar_widget.dart';
import 'employee_clock_screen.dart';
import 'employee_home_screen.dart';
import 'package:check_point_v2/features/leaves/presentation/screens/leaves_dashboard_screen.dart';
import 'employee_plans_screen.dart';
import 'employee_settings_screen.dart';
import 'employee_tasks_screen.dart';

class EmployeeMainScreen extends StatefulWidget {
  const EmployeeMainScreen({super.key});

  @override
  State<EmployeeMainScreen> createState() => _EmployeeMainScreenState();
}

class _EmployeeMainScreenState extends State<EmployeeMainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      EmployeeHomeScreen(
        onViewAllTasks: () => setState(() => _selectedIndex = 2),
        onViewAllPlans: () => setState(() => _selectedIndex = 3),
      ),
      const EmployeeClockScreen(),
      const EmployeeTasksScreen(),
      const EmployeePlansScreen(),
      const LeavesDashboardScreen(),
      const EmployeeSettingsScreen(),
    ];

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
          key: ValueKey<int>(_selectedIndex),
          index: _selectedIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: EmployeeNavBarWidget(
        selectedIndex: _selectedIndex,
        onTabSelected: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
