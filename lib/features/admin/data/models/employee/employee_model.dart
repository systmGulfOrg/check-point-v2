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
    this.roles,
    this.position,
    this.departmentName,
    this.departmentId,
    this.branchName,
    this.branchId,
    this.imageUrl,
    this.mobileId,
    this.deviceTokens,
    this.phone,
    this.email,
    this.employeeCode,
    this.canAddAttendance,
    this.canAddPlan,
    this.shiftName,
    this.shiftId,
    this.clockInTime,
    this.clockOutTime,
    this.area,
    this.leaveBalance,
  });

  final String? id;
  final String? userName;
  final String? name;
  final String? role;
  final List<String>? roles;
  final String? position;
  final String? departmentName;
  final int? departmentId;
  final String? branchName;
  final int? branchId;
  final String? imageUrl;
  final String? mobileId;
  final List<String>? deviceTokens;
  final String? phone;
  final String? email;
  final String? employeeCode;
  final bool? canAddAttendance;
  final bool? canAddPlan;
  final String? shiftName;
  final int? shiftId;
  @JsonKey(fromJson: legacyApiValueToString)
  final String? clockInTime;
  @JsonKey(fromJson: legacyApiValueToString)
  final String? clockOutTime;
  final String? area;
  final int? leaveBalance;

  List<String> get allRoles {
    final set = <String>{};
    if (role != null && role!.trim().isNotEmpty) {
      set.add(role!.trim());
    }
    if (roles != null) {
      for (final r in roles!) {
        if (r.trim().isNotEmpty) set.add(r.trim());
      }
    }
    return set.isEmpty ? const ['Employee'] : set.toList();
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}
