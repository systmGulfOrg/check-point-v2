// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentResponseModel _$DepartmentResponseModelFromJson(
  Map<String, dynamic> json,
) => DepartmentResponseModel(
  value: json['value'] == null
      ? null
      : DepartmentPageModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

DepartmentPageModel _$DepartmentPageModelFromJson(Map<String, dynamic> json) =>
    DepartmentPageModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DepartmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

DepartmentModel _$DepartmentModelFromJson(Map<String, dynamic> json) =>
    DepartmentModel(
      id: (json['id'] as num?)?.toInt(),
      departmentName: json['departmentName'] as String?,
    );
