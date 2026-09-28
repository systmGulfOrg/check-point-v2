import 'package:flutter/material.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_motion.dart';
import 'package:check_point_v2/core/widgets/custom_bottom_nav_bar_widget.dart';
import 'contractor_home_screen.dart';
import 'contractor_workers_screen.dart';
import 'contractor_attendance_screen.dart';
import 'contractor_requests_screen.dart';
import 'contractor_reports_screen.dart';
import 'contractor_profile_screen.dart';

class ContractorMainScreen extends StatefulWidget {
  const ContractorMainScreen({super.key});

  @override
  State<ContractorMainScreen> createState() => _ContractorMainScreenState();
}

class _ContractorMainScreenState extends State<ContractorMainScreen> {
  int _selectedIndex = 0;

  static const _navItems = <NavBarItemData>[
    NavBarItemData(icon: Icons.home_outlined, labelKey: 'contractor.nav.home'),
    NavBarItemData(icon: Icons.people_outline_rounded, labelKey: 'contractor.nav.workers'),
    NavBarItemData(icon: Icons.access_time_rounded, labelKey: 'contractor.nav.attendance'),
    NavBarItemData(icon: Icons.edit_calendar_outlined, labelKey: 'contractor.nav.requests'),
    NavBarItemData(icon: Icons.bar_chart_rounded, labelKey: 'contractor.nav.reports'),
    NavBarItemData(icon: Icons.person_outline_rounded, labelKey: 'contractor.nav.profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      ContractorHomeScreen(
        onViewWorkersTap: () => setState(() => _selectedIndex = 1),
        onViewAttendanceTap: () => setState(() => _selectedIndex = 2),
      ),
      const ContractorWorkersScreen(),
      const ContractorAttendanceScreen(),
      const ContractorRequestsScreen(),
      const ContractorReportsScreen(),
      const ContractorProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
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
      bottomNavigationBar: CustomBottomNavBarWidget(
        items: _navItems,
        selectedIndex: _selectedIndex,
        onTabSelected: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
