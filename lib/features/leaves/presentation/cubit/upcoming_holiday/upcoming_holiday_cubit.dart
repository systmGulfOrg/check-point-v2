import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/leaves/data/models/official_holiday_model.dart';
import 'package:check_point_v2/features/leaves/data/repos/leaves_repo_impl.dart';
import 'upcoming_holiday_state.dart';

class UpcomingHolidayCubit extends Cubit<UpcomingHolidayState> {
  UpcomingHolidayCubit({required this.leavesRepo})
    : super(const UpcomingHolidayState.initial());

  final LeavesRepoImpl leavesRepo;

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

        // Sort ascending by date
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

        emit(
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
        emit(UpcomingHolidayState.error(failure.messageKey));
      },
    );
  }
}
