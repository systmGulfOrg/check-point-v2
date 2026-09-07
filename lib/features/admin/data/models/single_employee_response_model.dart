import 'package:json_annotation/json_annotation.dart';

import 'employee_model.dart';

part 'single_employee_response_model.g.dart';

@JsonSerializable(createToJson: false)
class SingleEmployeeResponseModel {
  const SingleEmployeeResponseModel({this.value, this.isSuccess, this.errors});

  final EmployeeModel? value;
  final bool? isSuccess;
  final List<String>? errors;

  factory SingleEmployeeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SingleEmployeeResponseModelFromJson(json);
}
