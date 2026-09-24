import 'package:flutter_test/flutter_test.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/leaves/data/models/official_holiday_model.dart';
import 'package:check_point_v2/features/leaves/data/repos/leaves_repo_impl.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/upcoming_holiday/upcoming_holiday_state.dart';

class _FakeLeavesRepo implements LeavesRepoImpl {
  List<OfficialHolidayModel> holidays = [];

  @override
  Future<ApiResult<List<OfficialHolidayModel>>> getOfficialHolidays({int? year}) async {
    return ApiResult.success(holidays);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _FakeLeavesRepo fakeRepo;
  late UpcomingHolidayCubit cubit;

  setUp(() {
    fakeRepo = _FakeLeavesRepo();
    cubit = UpcomingHolidayCubit(leavesRepo: fakeRepo);
  });

  tearDown(() {
    cubit.close();
  });

  group('UpcomingHolidayCubit', () {
    test('initial state is UpcomingHolidayStateInitial', () {
      expect(cubit.state, isA<UpcomingHolidayStateInitial>());
    });

    test('emits loaded with todayHoliday when today is a holiday', () async {
      final now = DateTime.now();
      fakeRepo.holidays = [
        OfficialHolidayModel(
          id: '1',
          name: 'Eid al-Fitr',
          date: DateTime(now.year, now.month, now.day),
          isRecurring: false,
        ),
      ];

      await cubit.loadUpcomingHoliday();

      expect(cubit.state, isA<UpcomingHolidayStateLoaded>());
      final loaded = cubit.state as UpcomingHolidayStateLoaded;
      expect(loaded.isTodayHoliday, isTrue);
      expect(loaded.todayHoliday?.name, 'Eid al-Fitr');
    });

    test('emits loaded with nearest upcoming holiday in future', () async {
      final now = DateTime.now();
      fakeRepo.holidays = [
        OfficialHolidayModel(
          id: '2',
          name: 'Sinai Liberation Day',
          date: DateTime(now.year, now.month, now.day).add(const Duration(days: 5)),
          isRecurring: false,
        ),
      ];

      await cubit.loadUpcomingHoliday();

      expect(cubit.state, isA<UpcomingHolidayStateLoaded>());
      final loaded = cubit.state as UpcomingHolidayStateLoaded;
      expect(loaded.isTodayHoliday, isFalse);
      expect(loaded.nearestUpcomingHoliday?.name, 'Sinai Liberation Day');
      expect(loaded.daysUntilNearest, 5);
    });
  });
}
