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
  arabicName: json['arabicName'] as String?,
  originalDate: json['originalDate'] == null
      ? null
      : DateTime.parse(json['originalDate'] as String),
  isRescheduled: json['isRescheduled'] as bool?,
  rescheduledNote: json['rescheduledNote'] as String?,
  isCancelled: json['isCancelled'] as bool?,
  cancelReason: json['cancelReason'] as String?,
  excludedDepartmentIds: (json['excludedDepartmentIds'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  excludedEmployeeIds: (json['excludedEmployeeIds'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$OfficialHolidayModelImplToJson(
  _$OfficialHolidayModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'date': instance.date.toIso8601String(),
  'isRecurring': instance.isRecurring,
  'arabicName': instance.arabicName,
  'originalDate': instance.originalDate?.toIso8601String(),
  'isRescheduled': instance.isRescheduled,
  'rescheduledNote': instance.rescheduledNote,
  'isCancelled': instance.isCancelled,
  'cancelReason': instance.cancelReason,
  'excludedDepartmentIds': instance.excludedDepartmentIds,
  'excludedEmployeeIds': instance.excludedEmployeeIds,
};

_$OfficialHolidaysResponseModelImpl
_$$OfficialHolidaysResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$OfficialHolidaysResponseModelImpl(
      value:
          (json['value'] as List<dynamic>?)
              ?.map(
                (e) => OfficialHolidayModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OfficialHolidaysResponseModelImplToJson(
  _$OfficialHolidaysResponseModelImpl instance,
) => <String, dynamic>{'value': instance.value};
