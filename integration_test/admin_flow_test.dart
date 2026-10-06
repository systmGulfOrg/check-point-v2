import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_main_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_home_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_employees_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_manage_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_create_employee_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_deleted_employees_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_departments_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_locations_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_shifts_policies_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_permissions_screen.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_devices_screen.dart';
import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initIntegrationTestEnvironment();
  });

  group('Admin Flow Integration Tests', () {
    testWidgets('Renders Admin Main Shell and switches tabs', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.admin);

      expect(find.byType(AdminMainScreen), findsOneWidget);
      expect(find.byType(AdminHomeScreen), findsOneWidget);

      // Navigate to Employees Tab
      final bottomNavItems = find.byType(InkWell);
      if (bottomNavItems.evaluate().length >= 3) {
        await tester.tap(bottomNavItems.at(2));
        await tester.pumpAndSettle();
        expect(find.byType(AdminEmployeesScreen), findsOneWidget);
      }

      // Navigate to Manage Hub Tab
      if (bottomNavItems.evaluate().length >= 4) {
        await tester.tap(bottomNavItems.at(3));
        await tester.pumpAndSettle();
        expect(find.byType(AdminManageScreen), findsOneWidget);
      }

      expect(tester.takeException(), isNull);
    });

    testWidgets('Admin Create Employee Screen: Inputs and validations', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.adminCreateEmployee);

      expect(find.byType(AdminCreateEmployeeScreen), findsOneWidget);
      expect(find.byType(TextFormField), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Admin Deleted Employees: Trash bin render', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.adminDeletedEmployees);

      expect(find.byType(AdminDeletedEmployeesScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Admin Departments: Department directory render', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.adminDepartments);

      expect(find.byType(AdminDepartmentsScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Admin Locations: Locations directory render', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.adminLocations);

      expect(find.byType(AdminLocationsScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Admin Shifts & Policies: Work schedule configuration', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.adminShiftsPolicies);

      expect(find.byType(AdminShiftsPoliciesScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Admin Permissions: Permissions catalog matrix', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.adminPermissions);

      expect(find.byType(AdminPermissionsScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Admin Pending Devices: Device binding authorizations', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.adminPendingDevices);

      expect(find.byType(AdminDevicesScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
