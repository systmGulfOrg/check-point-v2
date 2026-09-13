import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/styles/app_motion.dart';
import 'supervisor_attendance_screen.dart';
import 'supervisor_home_screen.dart';
import 'supervisor_profile_screen.dart';
import 'supervisor_tasks_screen.dart';
import 'supervisor_team_screen.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_more_options_sheet_widget.dart';

class SupervisorMainScreen extends StatefulWidget {
  const SupervisorMainScreen({super.key});

  @override
  State<SupervisorMainScreen> createState() => _SupervisorMainScreenState();
}

class _SupervisorMainScreenState extends State<SupervisorMainScreen> {
  int _selectedIndex = 0;
  int _selectedNavIndex = 0;

  static const _items = <NavBarItemData>[
    NavBarItemData(icon: Icons.home_outlined, labelKey: 'supervisor.nav.home'),
    NavBarItemData(icon: Icons.group_outlined, labelKey: 'supervisor.nav.team'),
    NavBarItemData(
      icon: Icons.access_time_rounded,
      labelKey: 'supervisor.nav.attendance',
    ),
    NavBarItemData(
      icon: Icons.assignment_outlined,
      labelKey: 'supervisor.nav.tasks',
    ),
    NavBarItemData(
      icon: Icons.grid_view_rounded,
      labelKey: 'supervisor.nav.more',
    ),
  ];

  static const _screens = <Widget>[
    SupervisorHomeScreen(),
    SupervisorTeamScreen(),
    SupervisorAttendanceScreen(),
    SupervisorTasksScreen(),
    SupervisorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
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
          children: _screens,
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarWidget(
        items: _items,
        selectedIndex: _selectedNavIndex,
        onTabSelected: (index) {
          if (index == 4) {
            setState(() => _selectedNavIndex = index);
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: AppColors.cardBackground,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => SupervisorMoreOptionsSheetWidget(
                onLeavesTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.supervisorLeaveManagement,
                ),
                onPlansTap: () =>
                    Navigator.pushNamed(context, AppRoutes.supervisorPlans),
                onNotificationsTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.supervisorNotifications,
                ),
                onProfileTap: () {
                  setState(() {
                    _selectedIndex = 4;
                    _selectedNavIndex = 4;
                  });
                },
              ),
            );
            return;
          }
          setState(() {
            _selectedIndex = index;
            _selectedNavIndex = index;
          });
        },
      ),
    );
  }
}
