// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'official_holiday_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OfficialHolidayModelImpl _$$OfficialHolidayModelImplFromJson(
  Map<String, dynamic> json,
) => _$OfficialHolidayModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  date: DateTime.parse(json['date'] as String),
  isRecurring: json['isRecurring'] as bool,
);

Map<String, dynamic> _$$OfficialHolidayModelImplToJson(
  _$OfficialHolidayModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'date': instance.date.toIso8601String(),
  'isRecurring': instance.isRecurring,
};
