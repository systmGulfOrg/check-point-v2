import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/leaves/presentation/screens/leaves_dashboard_screen.dart';
import 'package:check_point_v2/features/leaves/presentation/screens/request_leave_screen.dart';
import 'package:check_point_v2/features/leaves/presentation/screens/request_permission_screen.dart';
import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initIntegrationTestEnvironment();
  });

  group('Leaves & Permissions Integration Tests', () {
    testWidgets('Leaves Dashboard: Renders balances summary and action buttons', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.leavesDashboard);

      expect(find.byType(LeavesDashboardScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Request Leave Screen: Form elements and validations', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.leavesRequest);

      expect(find.byType(RequestLeaveScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Request Permission Screen: Form elements and time pickers', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.permissionsRequest);

      expect(find.byType(RequestPermissionScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
