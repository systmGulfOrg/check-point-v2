import 'package:json_annotation/json_annotation.dart';

import 'employee_model.dart';
import 'shift_model.dart';

part 'police_model.g.dart';

@JsonSerializable()
class PoliceModel {
  const PoliceModel({
    this.id,
    this.shiftId,
    this.policyName,
    this.workDays,
    this.startTime,
    this.endTime,
    this.clockInTime,
    this.clockOutTime,
    this.area,
    this.month,
    this.year,
    this.shift,
    this.employees,
    this.allowedDelayTime,
    this.allowedEarlyLeaveTime,
  });

  final int? id;
  final int? shiftId;
  final String? policyName;
  final List<String>? workDays;
  final String? startTime;
  final String? endTime;
  final String? clockInTime;
  final String? clockOutTime;
  final String? area;
  final int? month;
  final int? year;
  final ShiftModel? shift;
  final List<EmployeeModel>? employees;
  final int? allowedDelayTime;
  final int? allowedEarlyLeaveTime;

  String get effectiveName =>
      policyName ?? shift?.name ?? 'Policy #${id ?? ''}';
  String get effectiveClockIn => clockInTime ?? startTime ?? '-';
  String get effectiveClockOut => clockOutTime ?? endTime ?? '-';

  factory PoliceModel.fromJson(Map<String, dynamic> json) =>
      _$PoliceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PoliceModelToJson(this);
}

@JsonSerializable()
class PoliceResponseModel {
  const PoliceResponseModel({this.value, this.isSuccess, this.successMessage});

  final PolicePageModel? value;
  final bool? isSuccess;
  final String? successMessage;

  factory PoliceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PoliceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PoliceResponseModelToJson(this);
}

@JsonSerializable()
class PolicePageModel {
  const PolicePageModel({this.items, this.data, this.totalCount});

  final List<PoliceModel>? items;
  final List<PoliceModel>? data;
  final int? totalCount;

  List<PoliceModel> get list => items ?? data ?? const [];

  factory PolicePageModel.fromJson(Map<String, dynamic> json) =>
      _$PolicePageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PolicePageModelToJson(this);
}

@JsonSerializable()
class AddPoliceRequestBody {
  const AddPoliceRequestBody({
    required this.shiftId,
    required this.policyName,
    required this.workDays,
    required this.startTime,
    required this.endTime,
    required this.allowedDelayTime,
    required this.allowedEarlyLeaveTime,
  });

  final int shiftId;
  final String policyName;
  final List<String> workDays;
  final String startTime;
  final String endTime;
  final int allowedDelayTime;
  final int allowedEarlyLeaveTime;

  factory AddPoliceRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddPoliceRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddPoliceRequestBodyToJson(this);
}

@JsonSerializable()
class AssignPoliceRequestBody {
  const AssignPoliceRequestBody({
    required this.policyId,
    required this.employeeIds,
  });

  final int policyId;
  final List<String> employeeIds;

  factory AssignPoliceRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AssignPoliceRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AssignPoliceRequestBodyToJson(this);
}

@JsonSerializable()
class RemoveAssignPolicyRequestBody {
  const RemoveAssignPolicyRequestBody({required this.employeeId});

  final String employeeId;

  factory RemoveAssignPolicyRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RemoveAssignPolicyRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveAssignPolicyRequestBodyToJson(this);
}
