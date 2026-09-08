// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_employee_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleEmployeeResponseModel _$SingleEmployeeResponseModelFromJson(
  Map<String, dynamic> json,
) => SingleEmployeeResponseModel(
  value: json['value'] == null
      ? null
      : EmployeeModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);
