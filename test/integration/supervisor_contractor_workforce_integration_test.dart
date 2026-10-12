import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/services/location_service.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_attendance_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_details_sheet_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_batch_attendance_sheet_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_contractor_headcount_card_widget.dart';

class _TestAssetLoader extends AssetLoader {
  const _TestAssetLoader();

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return {
      'supervisor.samco.contractorsCount': 'المقاولون في الموقع',
      'core.actions.ok': 'حسناً',
    };
  }
}

Widget createTestApp(Widget child) {
  return EasyLocalization(
    supportedLocales: const [Locale('ar'), Locale('en')],
    path: 'assets/translations',
    assetLoader: const _TestAssetLoader(),
    saveLocale: false,
    useOnlyLangCode: true,
    fallbackLocale: const Locale('ar'),
    startLocale: const Locale('ar'),
    child: Builder(
      builder: (context) => ScreenUtilPlusInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (ctx, _) => MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.pageBackground,
            useMaterial3: true,
          ),
          home: Scaffold(body: child),
        ),
      ),
    ),
  );
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    if (!sl.isRegistered<LocationService>()) {
      sl.registerLazySingleton<LocationService>(LocationService.new);
    }
  });

  group('Integration Flow: Supervisor Contractors & Workforce Management', () {
    final testContractor = ContractorCompanyModel(
      id: 'cnt-samco-01',
      name: 'شركة الأمل للمقاولات',
      code: 'CNT-010',
      contactPhone: '01012345678',
      workerCount: 3,
    );

    final testWorkers = [
      const ContractorWorkerModel(
        id: 'wrk-01',
        name: 'أحمد محمود إسماعيل',
        workerCode: 'WRK-1001',
        jobTitle: 'حداد مسلح',
        contractorId: 'cnt-samco-01',
        contractorName: 'شركة الأمل للمقاولات',
        siteName: 'الوفاء والامل',
      ),
      const ContractorWorkerModel(
        id: 'wrk-02',
        name: 'محمود حسن عبد الله',
        workerCode: 'WRK-1002',
        jobTitle: 'نجار مسلح',
        contractorId: 'cnt-samco-01',
        contractorName: 'شركة الأمل للمقاولات',
        siteName: 'الوفاء والامل',
      ),
      const ContractorWorkerModel(
        id: 'wrk-03',
        name: 'إبراهيم سيد علي',
        workerCode: 'WRK-1003',
        jobTitle: 'عامل بناء',
        contractorId: 'cnt-samco-02',
        contractorName: 'شركة النيل العامة',
        siteName: 'الوفاء والامل',
      ),
    ];

    final testAttendance = [
      const ContractorAttendanceModel(
        id: 'att-01',
        workerId: 'wrk-01',
        workerName: 'أحمد محمود إسماعيل',
        workerCode: 'WRK-1001',
        jobTitle: 'حداد مسلح',
        siteName: 'الوفاء والامل',
        projectName: 'Monorail Line East',
        date: '2026-10-12',
        status: 'Present',
        checkInTime: '2026-10-12T08:30:00.000Z',
      ),
    ];

    final testSites = [
      const SiteBoundaryModel(
        siteIdCamel: 'site-wafaa',
        siteNameCamel: 'الوفاء والامل',
        projectName: 'Monorail Line East',
        workerCount: 15,
      ),
    ];

    testWidgets('1. Contractor Headcount Card renders details & handles tap event',
        (tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        createTestApp(
          SupervisorContractorHeadcountCardWidget(
            contractorName: testContractor.name,
            code: testContractor.code,
            presentCount: 1,
            totalCount: 3,
            lateCount: 0,
            outsideGeofenceCount: 0,
            onTap: () {
              wasTapped = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('شركة الأمل للمقاولات'), findsOneWidget);
      expect(find.text('Code: CNT-010'), findsOneWidget);
      expect(find.text('1 / 3 Present'), findsOneWidget);

      await tester.tap(find.text('شركة الأمل للمقاولات'));
      await tester.pumpAndSettle();
      expect(wasTapped, isTrue);
    });

    testWidgets(
        '2. Contractor Details Sheet renders contractor info, attendance badges and check-in times',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createTestApp(
          ContractorDetailsSheetWidget(
            contractor: testContractor,
            workers: testWorkers.where((w) => w.contractorId == testContractor.id).toList(),
            attendanceLogs: testAttendance,
            sites: testSites,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Check header info
      expect(find.text('شركة الأمل للمقاولات'), findsOneWidget);
      expect(find.text('CNT-010'), findsOneWidget);
      expect(find.text('01012345678'), findsOneWidget);

      // Check counters: 2 workers, 1 present, 1 absent
      expect(find.text('إجمالي العمالة'), findsOneWidget);
      expect(find.text('حاضر اليوم'), findsOneWidget);
      expect(find.text('غياب اليوم'), findsOneWidget);
      expect(find.text('2'), findsOneWidget); // total
      expect(find.text('1'), findsNWidgets(2)); // 1 present, 1 absent

      // Check worker names
      expect(find.text('أحمد محمود إسماعيل'), findsOneWidget);
      expect(find.text('محمود حسن عبد الله'), findsOneWidget);

      // Check status badges
      expect(find.text('حاضر'), findsOneWidget);
      expect(find.text('غائب'), findsOneWidget);
    });

    testWidgets(
        '3. Batch Attendance Sheet renders Contractor badges & filters workers by contractor',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createTestApp(
          ContractorBatchAttendanceSheetWidget(
            workers: testWorkers,
            sites: testSites,
            contractors: [
              testContractor,
              ContractorCompanyModel(
                id: 'cnt-samco-02',
                name: 'شركة النيل العامة',
                code: 'CNT-020',
              ),
            ],
            contractorId: '',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Renders title
      expect(find.text('تسجيل الحضور الجماعي للعمالة'), findsOneWidget);

      // Renders contractor badges on worker tiles
      expect(find.text('المقاول: شركة الأمل للمقاولات'), findsNWidgets(2));
      expect(find.text('المقاول: شركة النيل العامة'), findsOneWidget);

      // Select All initially marks all 3
      final selectAllBtn = find.text('تحديد الكل');
      expect(selectAllBtn, findsOneWidget);
      await tester.tap(selectAllBtn);
      await tester.pumpAndSettle();

      expect(find.text('المحدد: 3 من 3'), findsOneWidget);
    });

    test('4. Date Formatting ISO-8601 is strictly ASCII (safe for backend across Arabic locales)', () {
      final now = DateTime.now();
      final isoDate = now.toIso8601String().split('T')[0];

      // Must be 10 characters: YYYY-MM-DD
      expect(isoDate.length, 10);
      expect(RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(isoDate), isTrue);

      // Verify that no Eastern Arabic numerals exist in the ISO string
      expect(isoDate.contains(RegExp(r'[٠-٩]')), isFalse);
    });
  });
}
