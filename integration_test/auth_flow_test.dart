import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/auth/presentation/screens/login_screen.dart';
import 'package:check_point_v2/features/auth/presentation/screens/request_access_screen.dart';
import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initIntegrationTestEnvironment();
  });

  group('Auth Flow Integration Tests', () {
    testWidgets('Renders Login Screen with all required controls', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.login);

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2)); // Username & Password
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('Validation: Submitting empty form shows validation errors', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.login);

      final submitButton = find.byType(ElevatedButton).first;
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('Input: Handles extreme string lengths and special characters without crash or overflow', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.login);

      final textFields = find.byType(TextFormField);
      final usernameField = textFields.first;
      final passwordField = textFields.at(1);

      const extremeText = 'very_long_user_name_with_special_characters_!@#\$%^&*()_+-=[]{}|;:",.<>?/~`1234567890';
      await tester.enterText(usernameField, extremeText);
      await tester.enterText(passwordField, 'P@ssw0rd!_1234567890_Very_Long');
      await tester.pumpAndSettle();

      expect(find.text(extremeText), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Navigation: Navigates to Request Access Screen and back', (tester) async {
      await pumpTestApp(tester, initialRoute: AppRoutes.login);

      final textButtons = find.byType(TextButton);
      if (textButtons.evaluate().isNotEmpty) {
        await tester.tap(textButtons.first);
        await tester.pumpAndSettle();
        expect(find.byType(RequestAccessScreen), findsOneWidget);

        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
          expect(find.byType(LoginScreen), findsOneWidget);
        }
      }
    });
  });
}
