import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/employee/presentation/screens/employee_main_screen.dart';
import 'package:check_point_v2/features/employee/presentation/screens/employee_clock_screen.dart';
import 'package:check_point_v2/features/employee/presentation/screens/employee_home_screen.dart';
import 'package:check_point_v2/features/employee/presentation/screens/employee_plans_screen.dart';
import 'package:check_point_v2/features/employee/presentation/screens/employee_settings_screen.dart';
import 'package:check_point_v2/features/leaves/presentation/screens/leaves_dashboard_screen.dart';
import 'package:check_point_v2/features/projects/presentation/screens/projects_screen.dart';
import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initIntegrationTestEnvironment();
  });

  group('Employee Flow Integration Tests', () {
    testWidgets('Renders Employee Main Shell and switches bottom tabs', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.employee);

      expect(find.byType(EmployeeMainScreen), findsOneWidget);
      expect(find.byType(EmployeeHomeScreen), findsOneWidget);

      // Navigate to Clock Tab (Tab 1)
      final bottomNavItems = find.byType(InkWell);
      if (bottomNavItems.evaluate().length >= 2) {
        await tester.tap(bottomNavItems.at(1));
        await tester.pumpAndSettle();
        expect(find.byType(EmployeeClockScreen), findsOneWidget);
      }

      // Navigate to Projects Tab (Tab 2)
      if (bottomNavItems.evaluate().length >= 3) {
        await tester.tap(bottomNavItems.at(2));
        await tester.pumpAndSettle();
        expect(find.byType(ProjectsScreen), findsOneWidget);
      }

      // Navigate to Plans Tab (Tab 3)
      if (bottomNavItems.evaluate().length >= 4) {
        await tester.tap(bottomNavItems.at(3));
        await tester.pumpAndSettle();
        expect(find.byType(EmployeePlansScreen), findsOneWidget);
      }

      // Navigate to Leaves Tab (Tab 4)
      if (bottomNavItems.evaluate().length >= 5) {
        await tester.tap(bottomNavItems.at(4));
        await tester.pumpAndSettle();
        expect(find.byType(LeavesDashboardScreen), findsOneWidget);
      }

      // Navigate to Settings Tab (Tab 5)
      if (bottomNavItems.evaluate().length >= 6) {
        await tester.tap(bottomNavItems.at(5));
        await tester.pumpAndSettle();
        expect(find.byType(EmployeeSettingsScreen), findsOneWidget);
      }

      expect(tester.takeException(), isNull);
    });

    testWidgets('Employee Settings: Settings Screen controls', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.employeeSettings);

      expect(find.byType(EmployeeSettingsScreen), findsOneWidget);
      expect(find.byType(ListTile), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });
}
