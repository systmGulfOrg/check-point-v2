import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/leaves/data/models/official_holiday_model.dart';
import 'package:check_point_v2/features/leaves/domain/repos/leaves_repo.dart';
import 'upcoming_holiday_state.dart';

class UpcomingHolidayCubit extends SafeCubit<UpcomingHolidayState> {
  UpcomingHolidayCubit({required this.leavesRepo})
    : super(const UpcomingHolidayState.initial());

  final LeavesRepo leavesRepo;

  Future<void> loadUpcomingHoliday({int? year}) async {
    emit(const UpcomingHolidayState.loading());
    final currentYear = year ?? DateTime.now().year;
    final result = await leavesRepo.getOfficialHolidays(year: currentYear);

    result.when(
      success: (holidays) {
        final now = DateTime.now();
        final todayMidnight = DateTime(now.year, now.month, now.day);

        OfficialHolidayModel? todayHoliday;
        OfficialHolidayModel? nearestUpcomingHoliday;
        int? daysUntilNearest;

        final sorted = List<OfficialHolidayModel>.from(holidays)
          ..sort((a, b) => a.date.compareTo(b.date));

        for (final h in sorted) {
          final hMidnight = DateTime(h.date.year, h.date.month, h.date.day);
          final diff = hMidnight.difference(todayMidnight).inDays;

          if (diff == 0) {
            todayHoliday = h;
          } else if (diff > 0) {
            if (nearestUpcomingHoliday == null) {
              nearestUpcomingHoliday = h;
              daysUntilNearest = diff;
            }
          }
        }

        safeEmit(
          UpcomingHolidayState.loaded(
            holidays: sorted,
            todayHoliday: todayHoliday,
            nearestUpcomingHoliday: nearestUpcomingHoliday,
            daysUntilNearest: daysUntilNearest,
            isTodayHoliday: todayHoliday != null,
          ),
        );
      },
      failure: (failure) {
        safeEmit(UpcomingHolidayState.error(failure.messageKey));
      },
    );
  }
}
