import 'package:freezed_annotation/freezed_annotation.dart';

part 'official_holiday_model.freezed.dart';
part 'official_holiday_model.g.dart';

@freezed
class OfficialHolidayModel with _$OfficialHolidayModel {
  const factory OfficialHolidayModel({
    required String id,
    required String name,
    required DateTime date,
    required bool isRecurring,
    String? arabicName,
    DateTime? originalDate,
    bool? isRescheduled,
    String? rescheduledNote,
  }) = _OfficialHolidayModel;

  factory OfficialHolidayModel.fromJson(Map<String, dynamic> json) =>
      _$OfficialHolidayModelFromJson(json);
}

@freezed
class OfficialHolidaysResponseModel with _$OfficialHolidaysResponseModel {
  const factory OfficialHolidaysResponseModel({
    @Default([]) List<OfficialHolidayModel> value,
  }) = _OfficialHolidaysResponseModel;

  factory OfficialHolidaysResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OfficialHolidaysResponseModelFromJson(json);
}
