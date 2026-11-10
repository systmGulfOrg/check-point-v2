import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/employee_record/data/apis/employee_record_api_service.dart';
import 'package:check_point_v2/features/employee_record/data/models/employee_record_model.dart';
import 'package:check_point_v2/features/employee_record/data/repos/employee_record_repo.dart';
import 'package:check_point_v2/features/employee_record/data/repos/employee_record_repo_impl.dart';
import 'package:check_point_v2/features/employee_record/presentation/cubit/employee_record_cubit.dart';
import 'package:check_point_v2/features/employee_record/presentation/cubit/employee_record_state.dart';
import 'package:check_point_v2/features/employee_record/presentation/widgets/employee_record_bloc_builder_widget.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _json = <String, dynamic>{
  'employee': {'id': 'emp-1', 'name': 'Sara', 'employeeCode': 'E-1'},
  'from': '2026-09-01',
  'to': '2026-09-30',
  'totals': {'presentDays': 2, 'lateDays': 1, 'coveredDays': 1, 'leaveDays': 1, 'weeklyOffDays': 8},
  'days': [
    {'date': '2026-09-04', 'dayType': 'weeklyOff', 'status': 'none'},
    {'date': '2026-09-14', 'dayType': 'leave', 'status': 'none', 'leave': {'id': 'l1', 'typeName': 'Annual'}},
    {
      'date': '2026-09-16', 'dayType': 'working', 'status': 'lateCovered', 'lateMinutes': 30,
      'clockIn': '2026-09-16T06:30:00.000Z', 'clockOut': '2026-09-16T14:00:00.000Z',
      'permits': [
        {'id': 'p1', 'permitType': 'LateArrival', 'status': 'Approved', 'durationMinutes': 60, 'startTime': '09:00', 'endTime': '10:00'},
      ],
    },
    {'date': '2026-09-17', 'dayType': 'working', 'status': 'late', 'lateMinutes': 40, 'clockIn': '2026-09-17T06:40:00.000Z'},
  ],
};

class _FakeApi implements EmployeeRecordApiService {
  final calls = <(String, String, String)>[];
  Object? error;

  @override
  Future<EmployeeRecordResponseModel> getRecord(String employeeId, {required String from, required String to}) async {
    calls.add((employeeId, from, to));
    if (error != null) throw error!;
    return EmployeeRecordResponseModel.fromJson({'value': _json});
  }
}

class _FakeRepo implements EmployeeRecordRepo {
  final months = <DateTime>[];
  bool fail = false;

  @override
  Future<ApiResult<EmployeeRecordModel>> getMonth({required String employeeId, required DateTime month}) async {
    months.add(month);
    if (fail) return const ApiResult.failure(ApiFailure(messageKey: 'errors.server'));
    return ApiResult.success(EmployeeRecordModel.fromJson(_json));
  }
}

void main() {
  group('EmployeeRecordModel', () {
    test('parses days, dates, permits and totals', () {
      final record = EmployeeRecordModel.fromJson(_json);
      expect(record.days, hasLength(4));
      expect(record.days.first.date, DateTime.utc(2026, 9, 4));
      final covered = record.days[2];
      expect(covered.isCovered, isTrue);
      expect(covered.clockIn, DateTime.utc(2026, 9, 16, 6, 30));
      expect(covered.permits.single.permitType, 'LateArrival');
      expect(record.days[1].leave?.typeName, 'Annual');
      expect(record.days[3].isCovered, isFalse);
      expect(record.totals.coveredDays, 1);
    });
  });

  group('EmployeeRecordRepoImpl', () {
    test('asks for the whole calendar month', () async {
      final api = _FakeApi();
      final result = await EmployeeRecordRepoImpl(api: api).getMonth(employeeId: 'me', month: DateTime(2026, 2, 17));
      expect(result, isA<Success<EmployeeRecordModel>>());
      expect(api.calls.single, ('me', '2026-02-01', '2026-02-28'));
    });

    test('maps a 404 (outside your scope) to a failure key', () async {
      final api = _FakeApi()
        ..error = DioException(
          requestOptions: RequestOptions(path: '/x'),
          response: Response(requestOptions: RequestOptions(path: '/x'), statusCode: 404),
          type: DioExceptionType.badResponse,
        );
      final result = await EmployeeRecordRepoImpl(api: api).getMonth(employeeId: 'emp-2', month: DateTime(2026, 9));
      expect(result, isA<Failure<EmployeeRecordModel>>());
    });
  });

  group('EmployeeRecordCubit', () {
    test('loads the current month, then moves back; never past the current month', () async {
      final repo = _FakeRepo();
      final cubit = EmployeeRecordCubit(recordRepo: repo, clock: () => DateTime(2026, 9, 20));
      addTearDown(cubit.close);

      await cubit.load(forEmployee: 'emp-1');
      expect(cubit.state, isA<EmployeeRecordSuccess>());
      expect(cubit.canGoNext, isFalse);
      await cubit.nextMonth();
      await cubit.previousMonth();

      expect(repo.months, [DateTime(2026, 9), DateTime(2026, 8)]);
      expect(cubit.employeeId, 'emp-1');
      expect(cubit.canGoNext, isTrue);
    });

    test('emits the error key with the month', () async {
      final repo = _FakeRepo()..fail = true;
      final cubit = EmployeeRecordCubit(recordRepo: repo, clock: () => DateTime(2026, 9, 20));
      addTearDown(cubit.close);
      await cubit.load();
      expect(cubit.state, EmployeeRecordState.error('errors.server', DateTime(2026, 9)));
    });
  });

  group('EmployeeRecordBlocBuilderWidget', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await EasyLocalization.ensureInitialized();
    });

    testWidgets('shows a permit-covered late day as covered, not late (real cubit, fake repo)', (tester) async {
      final cubit = EmployeeRecordCubit(recordRepo: _FakeRepo(), clock: () => DateTime(2026, 9, 20));
      // Tall surface so the lazy list builds every day.
      tester.view
        ..physicalSize = const Size(1170, 6000)
        ..devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      await tester.runAsync(() => tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: Builder(
            builder: (context) => ScreenUtilPlusInit(
              designSize: const Size(390, 844),
              builder: (_, _) => MaterialApp(
                locale: const Locale('en'),
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                home: Scaffold(
                  body: BlocProvider.value(value: cubit, child: const EmployeeRecordBlocBuilderWidget()),
                ),
              ),
            ),
          ),
        ),
      ));
      // Translations load from assets asynchronously; give them real time.
      await tester.runAsync(() async {
        await cubit.load();
        await Future<void>.delayed(const Duration(milliseconds: 300));
      });
      await tester.pumpAndSettle();

      expect(find.text('Late – permit'), findsOneWidget);
      expect(find.text('Late'), findsOneWidget);
      expect(find.text('On leave'), findsOneWidget);
      expect(find.text('Day off'), findsOneWidget);
      await cubit.close();
    });
  });
}
