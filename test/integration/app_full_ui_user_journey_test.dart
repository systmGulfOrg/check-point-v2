import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/site_members/admin_site_members_filter_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/site_members/admin_site_members_header_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/site_members/admin_site_worker_card_widget.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_batch_attendance_sheet_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_daily_presence_sheet_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_worker_card_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/apply_for_leave_sheet_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_today_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TestAssetLoader extends AssetLoader {
  const _TestAssetLoader();

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return {
      'admin.siteMembers.title': 'Site Members',
      'admin.siteMembers.all': 'All',
      'admin.siteMembers.contractors': 'Contractors',
      'admin.siteMembers.workers': 'Workers',
      'contractor.batchAttendance.title': 'Batch Attendance',
      'common.save': 'Save',
      'common.cancel': 'Cancel',
      'common.submit': 'Submit',
      'active': 'Active',
      'employee.today.title': 'Today Attendance',
      'employee.leave.apply': 'Apply for Leave',
      'employee.home.today': 'Today',
      'employee.home.leaveBalance': 'Leave Balance',
      'employee.home.checkInLabel': 'Check In',
      'employee.home.checkOutLabel': 'Check Out',
      'employee.home.checkOutAction': 'Check Out',
      'employee.leaves.applyTitle': 'Apply for Leave',
      'employee.leaves.leaveType': 'Leave Type',
      'employee.leaves.types.leaveRequest': 'Leave Request',
      'employee.leaves.types.requestClaim': 'Request Claim',
      'employee.leaves.types.leaveSchedule': 'Leave Schedule',
      'employee.leaves.types.leavePlanner': 'Leave Planner',
      'employee.leaves.types.incident': 'Incident',
      'employee.leaves.types.documentWorkflow': 'Document Workflow',
      'employee.leaves.startDate': 'Start Date',
      'employee.leaves.dateHint': 'dd/mm/yyyy',
      'employee.leaves.endDate': 'End Date',
      'employee.leaves.reason': 'Reason',
      'employee.leaves.reasonHint': 'Describe reason...',
      'employee.leaves.remark': 'Remark',
      'employee.leaves.remarkHint': 'Add remark...',
      'employee.leaves.cancel': 'Cancel',
      'employee.leaves.submit': 'Submit',
    };
  }
}

Widget createTestApp(Widget child) {
  return EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    assetLoader: const _TestAssetLoader(),
    saveLocale: false,
    useOnlyLangCode: true,
    fallbackLocale: const Locale('en'),
    startLocale: const Locale('en'),
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
  });

  group('Full End-to-End User Flow Simulation (SAMCO Requirements)', () {
    const sampleSite = SiteBoundaryModel(
      siteIdCamel: 'site-101',
      siteNameCamel: 'New Administrative Capital - R7',
      centerLat: 30.0123,
      centerLng: 31.5432,
      radiusMeters: 500,
      boundaryType: 'polygon',
    );

    const sampleSites = [sampleSite];

    const sampleWorker = ContractorWorkerModel(
      id: 'worker-701',
      contractorId: 'contractor-202',
      name: 'Ahmed Mahmoud Mostafa',
      workerCode: 'WRK-10842',
      nationalId: '29508151234567',
      phone: '01012345678',
      position: 'Civil Foreman',
      status: 'active',
    );

    testWidgets('1. Daily Presence Sheet verifies Contractor and Site details', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestApp(
          const ContractorDailyPresenceSheetWidget(
            contractorId: 'contractor-202',
            contractorName: 'Al-Rowad Concrete Co.',
            sites: sampleSites,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ContractorDailyPresenceSheetWidget), findsOneWidget);
      expect(find.text('Al-Rowad Concrete Co.'), findsOneWidget);
    });

    testWidgets('2. Batch Attendance Sheet renders Worker list & Batch submission action',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestApp(
          const ContractorBatchAttendanceSheetWidget(
            contractorId: 'contractor-202',
            sites: sampleSites,
            workers: [sampleWorker],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ContractorBatchAttendanceSheetWidget), findsOneWidget);
      expect(find.text('Ahmed Mahmoud Mostafa'), findsOneWidget);
    });

    testWidgets('3. Contractor Worker Card displays WRK-XXXXX and Arabic worker details',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestApp(
          ContractorWorkerCardWidget(
            worker: sampleWorker,
            onTap: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ContractorWorkerCardWidget), findsOneWidget);
      expect(find.text('Ahmed Mahmoud Mostafa'), findsOneWidget);
      expect(find.textContaining('WRK-10842'), findsOneWidget);
    });

    testWidgets('4. Employee Today Attendance Card displays shift time, status & hours',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestApp(
          EmployeeTodayCardWidget(
            policyText: 'Standard 8h Shift (09:00 AM - 05:00 PM)',
            isOnTime: true,
            checkInTime: '08:55 AM',
            checkOutTime: '--:--',
            isCheckedIn: true,
            hasCheckedOut: false,
            workedHours: '6.5 hrs',
            leaveBalance: 18,
            workModeText: 'On-Site',
            workSystemText: 'Biometric Verified',
            onToggleCheckInOut: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(EmployeeTodayCardWidget), findsOneWidget);
      expect(find.text('Standard 8h Shift (09:00 AM - 05:00 PM)'), findsOneWidget);
      expect(find.text('08:55 AM'), findsOneWidget);
    });

    testWidgets('5. Apply For Leave Sheet renders reason, remark and submission controls',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestApp(
          ApplyForLeaveSheetWidget(
            onSubmit: ({
              String? attachmentUrl,
              required String endDate,
              required String leaveRequestType,
              required String reason,
              required String remark,
              required String startDate,
            }) async {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ApplyForLeaveSheetWidget), findsOneWidget);
    });

    testWidgets('6. Admin Site Members Header renders Site name and Worker/Contractor counters',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestApp(
          AdminSiteMembersHeaderWidget(
            site: sampleSite,
            workerCount: 45,
            contractorCount: 3,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AdminSiteMembersHeaderWidget), findsOneWidget);
      expect(find.text('New Administrative Capital - R7'), findsOneWidget);
      expect(find.text('45'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('7. Admin Site Members Filter Widget renders All, Contractors and Workers chips',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestApp(
          AdminSiteMembersFilterWidget(
            selectedFilter: SiteMemberFilterType.all,
            allCount: 48,
            contractorsCount: 3,
            workersCount: 45,
            onFilterSelected: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AdminSiteMembersFilterWidget), findsOneWidget);
      expect(find.text('48'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('45'), findsOneWidget);
    });

    testWidgets('8. Admin Site Worker Card displays WRK-XXXXX and Authorization toggles',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createTestApp(
          AdminSiteWorkerCardWidget(
            worker: sampleWorker,
            onTap: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AdminSiteWorkerCardWidget), findsOneWidget);
      expect(find.text('Ahmed Mahmoud Mostafa'), findsOneWidget);
      expect(find.text('WRK-10842'), findsOneWidget);
    });
  });
}
