import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/leaves/data/models/official_holiday_model.dart';

part 'upcoming_holiday_state.freezed.dart';

@freezed
class UpcomingHolidayState with _$UpcomingHolidayState {
  const factory UpcomingHolidayState.initial() = UpcomingHolidayStateInitial;
  const factory UpcomingHolidayState.loading() = UpcomingHolidayStateLoading;
  const factory UpcomingHolidayState.loaded({
    required List<OfficialHolidayModel> holidays,
    OfficialHolidayModel? todayHoliday,
    OfficialHolidayModel? nearestUpcomingHoliday,
    int? daysUntilNearest,
    @Default(false) bool isTodayHoliday,
  }) = UpcomingHolidayStateLoaded;
  const factory UpcomingHolidayState.error(String messageKey) =
      UpcomingHolidayStateError;
}
