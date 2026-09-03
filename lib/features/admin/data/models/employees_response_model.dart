import 'package:json_annotation/json_annotation.dart';

import 'employee_model.dart';

part 'employees_response_model.g.dart';

@JsonSerializable(createToJson: false)
class EmployeesResponseModel {
  const EmployeesResponseModel({this.value, this.isSuccess, this.errors});

  final EmployeesPageModel? value;
  final bool? isSuccess;
  final List<String>? errors;

  factory EmployeesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeesResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class EmployeesPageModel {
  const EmployeesPageModel({
    this.data,
    this.totalCount,
    this.pageCount,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  final List<EmployeeModel>? data;
  final int? totalCount;
  final int? pageCount;
  final bool? hasNextPage;
  final bool? hasPreviousPage;

  factory EmployeesPageModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeesPageModelFromJson(json);
}
