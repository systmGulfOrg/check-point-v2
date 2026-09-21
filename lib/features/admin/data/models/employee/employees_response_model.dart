import 'package:json_annotation/json_annotation.dart';

import 'employee_model.dart';
import 'package:check_point_v2/core/utils/legacy_api_response_helpers.dart';

part 'employees_response_model.g.dart';

@JsonSerializable(createToJson: false)
class EmployeesResponseModel {
  const EmployeesResponseModel({this.value, this.isSuccess, this.errors});

  final EmployeesPageModel? value;
  final bool? isSuccess;
  final List<String>? errors;

  factory EmployeesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeesResponseModelFromJson({
        ...json,
        'value': legacyPageValue(json['value']),
      });
}

@JsonSerializable(createToJson: false)
class EmployeesPageModel {
  const EmployeesPageModel({
    this.items,
    this.data,
    this.totalCount,
    this.pageCount,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  final List<EmployeeModel>? items;
  final List<EmployeeModel>? data;
  final int? totalCount;
  final int? pageCount;
  final bool? hasNextPage;
  final bool? hasPreviousPage;

  List<EmployeeModel> get list => (items ?? data ?? const [])
      .where((e) =>
          e.userName?.toLowerCase() != 'admin' &&
          e.name.toLowerCase() != 'demo administrator' &&
          e.employeeCode?.toLowerCase() != 'emp-0001' &&
          !e.allRoles.any((r) => r.toLowerCase() == 'admin'))
      .toList();

  factory EmployeesPageModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeesPageModelFromJson(json);
}
