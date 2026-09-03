import 'package:json_annotation/json_annotation.dart';

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
    this.branchName,
    this.imageUrl,
    this.mobileId,
    this.canAddAttendance,
    this.canAddPlan,
  });

  final String? id;
  final String? userName;
  final String? name;
  final String? role;
  final String? position;
  final String? departmentName;
  final String? branchName;
  final String? imageUrl;
  final String? mobileId;
  final bool? canAddAttendance;
  final bool? canAddPlan;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}
