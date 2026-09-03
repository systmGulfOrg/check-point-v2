// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) =>
    EmployeeModel(
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String?,
      position: json['position'] as String?,
      departmentName: json['departmentName'] as String?,
      branchName: json['branchName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      mobileId: json['mobileId'] as String?,
      canAddAttendance: json['canAddAttendance'] as bool?,
      canAddPlan: json['canAddPlan'] as bool?,
    );

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'name': instance.name,
      'role': instance.role,
      'position': instance.position,
      'departmentName': instance.departmentName,
      'branchName': instance.branchName,
      'imageUrl': instance.imageUrl,
      'mobileId': instance.mobileId,
      'canAddAttendance': instance.canAddAttendance,
      'canAddPlan': instance.canAddPlan,
    };
