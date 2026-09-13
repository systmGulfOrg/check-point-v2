import 'package:json_annotation/json_annotation.dart';

import 'package:check_point_v2/core/utils/legacy_api_json_converters.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel {
  const EmployeeModel({
    this.id,
    this.userName,
    this.name,
    this.role,
    this.position,
    this.departmentName,
    this.departmentId,
    this.branchName,
    this.branchId,
    this.imageUrl,
    this.mobileId,
    this.canAddAttendance,
    this.canAddPlan,
    this.shiftName,
    this.clockInTime,
    this.clockOutTime,
    this.area,
  });

  final String? id;
  final String? userName;
  final String? name;
  final String? role;
  final String? position;
  final String? departmentName;
  final int? departmentId;
  final String? branchName;
  final int? branchId;
  final String? imageUrl;
  final String? mobileId;
  final bool? canAddAttendance;
  final bool? canAddPlan;
  final String? shiftName;
  @JsonKey(fromJson: legacyApiValueToString)
  final String? clockInTime;
  @JsonKey(fromJson: legacyApiValueToString)
  final String? clockOutTime;
  final String? area;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}
