import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/styles/app_motion.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_nav_bar_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_desktop_sidebar_widget.dart';
import 'admin_employees_screen.dart';
import 'admin_home_screen.dart';
import 'admin_manage_screen.dart';
import 'admin_requests_screen.dart';
import 'admin_settings_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedIndex = 0;

  static const _screens = <Widget>[
    AdminHomeScreen(),
    AdminRequestsScreen(),
    AdminEmployeesScreen(),
    AdminManageScreen(),
    AdminSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final content = AnimatedSwitcher(
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
          );
          if (constraints.maxWidth >= 800) {
            return Row(
              children: [
                AdminDesktopSidebarWidget(
                  selectedIndex: _selectedIndex,
                  onTabSelected: (index) =>
                      setState(() => _selectedIndex = index),
                ),
                Expanded(child: content),
              ],
            );
          }
          return content;
        },
      ),
      bottomNavigationBar: MediaQuery.sizeOf(context).width < 800
          ? AdminNavBarWidget(
              selectedIndex: _selectedIndex,
              onTabSelected: (index) => setState(() => _selectedIndex = index),
            )
          : null,
    );
  }
}
