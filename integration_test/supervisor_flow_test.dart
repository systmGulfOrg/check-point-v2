import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/supervisor/presentation/screens/supervisor_main_screen.dart';
import 'package:check_point_v2/features/supervisor/presentation/screens/supervisor_home_screen.dart';
import 'package:check_point_v2/features/supervisor/presentation/screens/supervisor_team_screen.dart';
import 'package:check_point_v2/features/supervisor/presentation/screens/supervisor_attendance_screen.dart';
import 'package:check_point_v2/features/supervisor/presentation/screens/supervisor_leave_management_screen.dart';
import 'package:check_point_v2/features/supervisor/presentation/screens/supervisor_plans_screen.dart';
import 'package:check_point_v2/features/supervisor/presentation/screens/supervisor_notifications_screen.dart';
import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initIntegrationTestEnvironment();
  });

  group('Supervisor Flow Integration Tests', () {
    testWidgets('Renders Supervisor Main Shell and switches bottom tabs', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.supervisor);

      expect(find.byType(SupervisorMainScreen), findsOneWidget);
      expect(find.byType(SupervisorHomeScreen), findsOneWidget);

      // Navigate to Team Tab (Tab 2)
      final bottomNavItems = find.byType(InkWell);
      if (bottomNavItems.evaluate().length >= 3) {
        await tester.tap(bottomNavItems.at(2));
        await tester.pumpAndSettle();
        expect(find.byType(SupervisorTeamScreen), findsOneWidget);
      }

      // Navigate to Attendance Tab (Tab 3)
      if (bottomNavItems.evaluate().length >= 4) {
        await tester.tap(bottomNavItems.at(3));
        await tester.pumpAndSettle();
        expect(find.byType(SupervisorAttendanceScreen), findsOneWidget);
      }

      expect(tester.takeException(), isNull);
    });

    testWidgets('Supervisor Leave Management: Renders approval queue', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.supervisorLeaveManagement);

      expect(find.byType(SupervisorLeaveManagementScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Supervisor Plans: Renders plans management', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.supervisorPlans);

      expect(find.byType(SupervisorPlansScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Supervisor Notifications: Renders notification center', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.supervisorNotifications);

      expect(find.byType(SupervisorNotificationsScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
