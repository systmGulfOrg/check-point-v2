import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/widgets/app_sheet_handle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(WidgetTester tester) => tester.pumpWidget(
  ScreenUtilPlusInit(
    designSize: const Size(390, 844),
    builder: (_, _) =>
        const MaterialApp(home: Scaffold(body: AppSheetHandleWidget())),
  ),
);

void main() {
  group('AppSheetHandleWidget', () {
    testWidgets('renders a centered bar', (tester) async {
      await _pump(tester);
      await tester.pumpAndSettle();

      expect(find.byType(AppSheetHandleWidget), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppSheetHandleWidget),
          matching: find.byType(Center),
        ),
        findsOneWidget,
      );
    });

    testWidgets('uses the shared border color and a rounded shape', (
      tester,
    ) async {
      await _pump(tester);
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(AppSheetHandleWidget),
          matching: find.byType(Container),
        ),
      );
      final decoration = container.decoration! as BoxDecoration;

      expect(decoration.color, AppColors.border);
      expect(decoration.borderRadius, isNotNull);
    });
  });
}
