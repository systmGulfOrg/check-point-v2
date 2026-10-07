import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/styles/app_motion.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_nav_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/customer_visits/admin_customer_visits_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_customers_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_locations_screen.dart';
import 'employee_clock_screen.dart';
import 'employee_home_screen.dart';
import 'package:check_point_v2/features/leaves/presentation/screens/leaves_dashboard_screen.dart';
import 'employee_settings_screen.dart';

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
      const EmployeeHomeScreen(),
      MultiBlocProvider(
        providers: [
          BlocProvider<AdminCustomersCubit>(
            create: (_) => sl<AdminCustomersCubit>()..load(type: 'Customer'),
          ),
          BlocProvider<AdminCustomerVisitsCubit>(
            create: (_) => sl<AdminCustomerVisitsCubit>()..loadAllVisits(),
          ),
          BlocProvider<AdminBranchesCubit>(
            create: (_) => sl<AdminBranchesCubit>()..load(),
          ),
        ],
        child: const AdminLocationsScreen(),
      ),
      const EmployeeClockScreen(),
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
