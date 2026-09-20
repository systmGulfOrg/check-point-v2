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
  }) = _OfficialHolidayModel;

  factory OfficialHolidayModel.fromJson(Map<String, dynamic> json) =>
      _$OfficialHolidayModelFromJson(json);
}
