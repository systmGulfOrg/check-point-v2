import 'package:json_annotation/json_annotation.dart';

part 'department_request_model.g.dart';

@JsonSerializable(createToJson: false)
class DepartmentRequestModel {
  const DepartmentRequestModel({required this.departmentName});

  final String departmentName;

  factory DepartmentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentRequestModelFromJson(json);

  Map<String, dynamic> toJson() => {
        'name': departmentName,
        'departmentName': departmentName,
      };
}
