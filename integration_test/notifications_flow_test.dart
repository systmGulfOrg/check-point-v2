import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/supervisor/presentation/screens/supervisor_notifications_screen.dart';
import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initIntegrationTestEnvironment();
  });

  group('Notifications Flow Integration Tests', () {
    testWidgets('Notifications Screen: Renders notification center and actions', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.supervisorNotifications);

      expect(find.byType(SupervisorNotificationsScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
