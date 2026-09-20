import 'package:json_annotation/json_annotation.dart';

part 'employee_work_policy_model.g.dart';

@JsonSerializable()
class EmployeeWorkPolicyModel {
  const EmployeeWorkPolicyModel({
    this.id,
    this.name,
    this.policyType,
    this.allowedDays,
    this.onsiteDays,
    this.workingHoursStart,
    this.workingHoursEnd,
    this.allowedDelayTime,
  });

  final String? id;
  final String? name;
  final String? policyType;
  final List<String>? allowedDays;
  final List<String>? onsiteDays;
  final String? workingHoursStart;
  final String? workingHoursEnd;
  final int? allowedDelayTime;

  factory EmployeeWorkPolicyModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeWorkPolicyModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeWorkPolicyModelToJson(this);
}
