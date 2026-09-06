// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchResponseModel _$BranchResponseModelFromJson(Map<String, dynamic> json) =>
    BranchResponseModel(
      value: json['value'] == null
          ? null
          : BranchPageModel.fromJson(json['value'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

BranchPageModel _$BranchPageModelFromJson(Map<String, dynamic> json) =>
    BranchPageModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => BranchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BranchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  location: json['location'] as String?,
  description: json['description'] as String?,
);
