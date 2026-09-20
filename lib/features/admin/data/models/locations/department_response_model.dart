import 'package:json_annotation/json_annotation.dart';

import 'package:check_point_v2/core/utils/legacy_api_response_helpers.dart';

part 'department_response_model.g.dart';

@JsonSerializable(createToJson: false)
class DepartmentResponseModel {
  const DepartmentResponseModel({this.value, this.isSuccess, this.errors});

  final DepartmentPageModel? value;
  final bool? isSuccess;
  final List<String>? errors;

  factory DepartmentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentResponseModelFromJson({
        ...json,
        'value': legacyPageValue(json['value']),
      });
}

@JsonSerializable(createToJson: false)
class DepartmentPageModel {
  const DepartmentPageModel({this.items, this.data, this.totalCount});

  final List<DepartmentModel>? items;
  final List<DepartmentModel>? data;
  final int? totalCount;

  List<DepartmentModel> get list => items ?? data ?? const [];

  factory DepartmentPageModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentPageModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class DepartmentModel {
  const DepartmentModel({this.id, this.departmentName});

  final int? id;
  final String? departmentName;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentModelFromJson({
        ...json,
        'departmentName': json['departmentName'] ?? json['name'],
      });
}
