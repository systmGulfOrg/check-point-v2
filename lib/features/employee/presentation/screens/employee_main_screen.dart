import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
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
  late final List<Widget Function()> _screenBuilders = [
    () => const EmployeeHomeScreen(),
    () => MultiBlocProvider(
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
    () => const EmployeeClockScreen(),
    () => const LeavesDashboardScreen(),
    () => const EmployeeSettingsScreen(),
  ];
  final Map<int, Widget> _loadedScreens = {};

  @override
  void initState() {
    super.initState();
    _loadedScreens[0] = _screenBuilders[0]();
  }

  @override
  Widget build(BuildContext context) {
    final screens = List<Widget>.generate(
      _screenBuilders.length,
      (index) => _loadedScreens[index] ?? const SizedBox.shrink(),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      body: IndexedStack(index: _selectedIndex, children: screens),
      bottomNavigationBar: EmployeeNavBarWidget(
        selectedIndex: _selectedIndex,
        onTabSelected: (index) {
          _loadedScreens[index] ??= _screenBuilders[index]();
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
