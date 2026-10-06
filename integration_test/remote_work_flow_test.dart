import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/remote_work/presentation/screens/remote_work_screen.dart';
import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initIntegrationTestEnvironment();
  });

  group('Remote Work Integration Tests', () {
    testWidgets('Remote Work Screen: Renders tabs and requests queue', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.remoteWork);

      expect(find.byType(RemoteWorkScreen), findsOneWidget);
      expect(find.byType(TabBar), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });
}
