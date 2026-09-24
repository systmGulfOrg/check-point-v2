import 'package:json_annotation/json_annotation.dart';

part 'employee_holiday_models.g.dart';

@JsonSerializable()
class EmployeeTodayHolidayModel {
  const EmployeeTodayHolidayModel({
    this.isHoliday,
    this.name,
    this.arabicName,
    this.date,
    this.greeting,
    this.message,
  });

  final bool? isHoliday;
  final String? name;
  final String? arabicName;
  final String? date;
  final String? greeting;
  final String? message;

  factory EmployeeTodayHolidayModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeTodayHolidayModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeTodayHolidayModelToJson(this);
}

@JsonSerializable()
class EmployeeNextHolidayModel {
  const EmployeeNextHolidayModel({
    this.name,
    this.arabicName,
    this.date,
    this.daysRemaining,
    this.greeting,
    this.message,
  });

  final String? name;
  final String? arabicName;
  final String? date;
  final int? daysRemaining;
  final String? greeting;
  final String? message;

  factory EmployeeNextHolidayModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeNextHolidayModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeNextHolidayModelToJson(this);
}
