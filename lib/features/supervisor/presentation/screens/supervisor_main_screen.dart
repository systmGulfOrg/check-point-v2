import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/customer_visits/admin_customer_visits_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_customers_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_locations_screen.dart';
import 'supervisor_home_screen.dart';
import 'supervisor_profile_screen.dart';
import 'supervisor_team_screen.dart';
import 'package:check_point_v2/features/employee/presentation/screens/employee_clock_screen.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_more_options_sheet_widget.dart';

class SupervisorMainScreen extends StatefulWidget {
  const SupervisorMainScreen({super.key});

  @override
  State<SupervisorMainScreen> createState() => _SupervisorMainScreenState();
}

class _SupervisorMainScreenState extends State<SupervisorMainScreen> {
  int _selectedIndex = 0;
  int _selectedNavIndex = 0;
  late final List<Widget Function()> _screenBuilders = [
    () => const SupervisorHomeScreen(),
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
    () => const SupervisorTeamScreen(),
    () => const SupervisorProfileScreen(),
  ];
  final Map<int, Widget> _loadedScreens = {};

  static const _items = <NavBarItemData>[
    NavBarItemData(icon: Icons.home_outlined, labelKey: 'supervisor.nav.home'),
    NavBarItemData(
      icon: Icons.groups_outlined,
      labelKey: 'supervisor.nav.customers',
    ),
    NavBarItemData(
      icon: Icons.person_pin_circle_outlined,
      labelKey: 'supervisor.nav.myAttendance',
    ),
    NavBarItemData(icon: Icons.group_outlined, labelKey: 'supervisor.nav.team'),
    NavBarItemData(
      icon: Icons.grid_view_rounded,
      labelKey: 'supervisor.nav.more',
    ),
  ];

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
      bottomNavigationBar: CustomBottomNavBarWidget(
        items: _items,
        selectedIndex: _selectedNavIndex,
        onTabSelected: (index) {
          if (index == 4) {
            final authProfileCubit = context.read<AuthProfileCubit>();
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: AppColors.cardBackground,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => BlocProvider.value(
                value: authProfileCubit,
                child: SupervisorMoreOptionsSheetWidget(
                  onLeavesTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.supervisorLeaveManagement,
                  ),
                  onNotificationsTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.supervisorNotifications,
                  ),
                  onProfileTap: () {
                    setState(() {
                      _loadedScreens[4] ??= _screenBuilders[4]();
                      _selectedIndex = 4;
                      _selectedNavIndex = 4;
                    });
                  },
                  onCustomersTap: () {
                    setState(() {
                      _loadedScreens[1] ??= _screenBuilders[1]();
                      _selectedIndex = 1;
                      _selectedNavIndex = 1;
                    });
                  },
                  onRemoteWorkTap: () =>
                      Navigator.pushNamed(context, AppRoutes.remoteWork),
                ),
              ),
            );
            return;
          }
          setState(() {
            _loadedScreens[index] ??= _screenBuilders[index]();
            _selectedIndex = index;
            _selectedNavIndex = index;
          });
        },
      ),
    );
  }
}
