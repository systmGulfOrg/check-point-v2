// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeesResponseModel _$EmployeesResponseModelFromJson(
  Map<String, dynamic> json,
) => EmployeesResponseModel(
  value: json['value'] == null
      ? null
      : EmployeesPageModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

EmployeesPageModel _$EmployeesPageModelFromJson(Map<String, dynamic> json) =>
    EmployeesPageModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
      pageCount: (json['pageCount'] as num?)?.toInt(),
      hasNextPage: json['hasNextPage'] as bool?,
      hasPreviousPage: json['hasPreviousPage'] as bool?,
    );
