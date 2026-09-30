import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/styles/app_motion.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/attendance/admin_attendance_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/tasks/admin_tasks_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_desktop_sidebar_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_nav_bar_widget.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
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

  List<Widget> get _screens => [
    AdminHomeScreen(
      onNavigateToEmployees: () => _onTabSelected(2),
      onNavigateToRequests: () => _onTabSelected(1),
    ),
    const AdminRequestsScreen(),
    const AdminEmployeesScreen(),
    const AdminManageScreen(),
    const AdminSettingsScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        context.read<AuthProfileCubit>().loadProfile();
        context.read<AdminAttendanceCubit>().loadAttendance();
        context.read<AdminTasksCubit>().loadTasks();
        context.read<AdminLeaveRequestsCubit>().loadRequests();
        context.read<AdminAccountRequestsCubit>().loadRequests();
        context.read<AdminEmployeesCubit>().loadEmployees();
        break;
      case 1:
        context.read<AdminAccountRequestsCubit>().loadRequests();
        context.read<AdminLeaveRequestsCubit>().loadRequests();
        context.read<AdminPendingDevicesCubit>().loadDevices();
        break;
      case 2:
        context.read<AdminEmployeesCubit>().loadEmployees();
        break;
      case 3:
        context.read<AuthProfileCubit>().loadProfile();
        break;
      case 4:
        context.read<AuthProfileCubit>().loadProfile();
        break;
    }
  }

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
                  onTabSelected: _onTabSelected,
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
              onTabSelected: _onTabSelected,
            )
          : null,
    );
  }
}
