// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_holiday_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeTodayHolidayModel _$EmployeeTodayHolidayModelFromJson(
  Map<String, dynamic> json,
) => EmployeeTodayHolidayModel(
  isHoliday: json['isHoliday'] as bool?,
  name: json['name'] as String?,
  arabicName: json['arabicName'] as String?,
  date: json['date'] as String?,
  greeting: json['greeting'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$EmployeeTodayHolidayModelToJson(
  EmployeeTodayHolidayModel instance,
) => <String, dynamic>{
  'isHoliday': instance.isHoliday,
  'name': instance.name,
  'arabicName': instance.arabicName,
  'date': instance.date,
  'greeting': instance.greeting,
  'message': instance.message,
};

EmployeeNextHolidayModel _$EmployeeNextHolidayModelFromJson(
  Map<String, dynamic> json,
) => EmployeeNextHolidayModel(
  name: json['name'] as String?,
  arabicName: json['arabicName'] as String?,
  date: json['date'] as String?,
  daysRemaining: (json['daysRemaining'] as num?)?.toInt(),
  greeting: json['greeting'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$EmployeeNextHolidayModelToJson(
  EmployeeNextHolidayModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'arabicName': instance.arabicName,
  'date': instance.date,
  'daysRemaining': instance.daysRemaining,
  'greeting': instance.greeting,
  'message': instance.message,
};
