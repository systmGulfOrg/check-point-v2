import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
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
  late final List<Widget Function()> _screenBuilders = [
    () => const AdminHomeScreen(),
    () => const AdminRequestsScreen(),
    () => const AdminEmployeesScreen(),
    () => const AdminManageScreen(),
    () => const AdminSettingsScreen(),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final content = IndexedStack(
            index: _selectedIndex,
            children: screens,
          );
          if (constraints.maxWidth >= 800) {
            return Row(
              children: [
                AdminDesktopSidebarWidget(
                  selectedIndex: _selectedIndex,
                  onTabSelected: (index) {
                    _loadedScreens[index] ??= _screenBuilders[index]();
                    setState(() => _selectedIndex = index);
                  },
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
              onTabSelected: (index) {
                _loadedScreens[index] ??= _screenBuilders[index]();
                setState(() => _selectedIndex = index);
              },
            )
          : null,
    );
  }
}
