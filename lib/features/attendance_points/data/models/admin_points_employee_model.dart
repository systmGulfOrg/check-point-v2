import 'package:freezed_annotation/freezed_annotation.dart';

import 'points_summary_model.dart';

part 'admin_points_employee_model.freezed.dart';
part 'admin_points_employee_model.g.dart';

@freezed
class AdminPointsDepartmentModel with _$AdminPointsDepartmentModel {
  const factory AdminPointsDepartmentModel({String? id, String? name}) =
      _AdminPointsDepartmentModel;

  factory AdminPointsDepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$AdminPointsDepartmentModelFromJson(json);
}

@freezed
class AdminPointsEmployeeModel with _$AdminPointsEmployeeModel {
  const factory AdminPointsEmployeeModel({
    required String id,
    String? name,
    String? employeeCode,
    String? position,
    AdminPointsDepartmentModel? department,
    @Default(PointsBalancesModel()) PointsBalancesModel balances,
    @Default(PointsLevelModel()) PointsLevelModel level,
    @Default(PointsStreakModel()) PointsStreakModel streak,
  }) = _AdminPointsEmployeeModel;

  factory AdminPointsEmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$AdminPointsEmployeeModelFromJson(json);
}

@freezed
class AdminPointsEmployeesPageModel with _$AdminPointsEmployeesPageModel {
  const factory AdminPointsEmployeesPageModel({
    @Default(<AdminPointsEmployeeModel>[]) List<AdminPointsEmployeeModel> items,
    int? totalCount,
    int? index,
    int? itemCount,
    int? totalPages,
    bool? hasNext,
    bool? hasPrevious,
  }) = _AdminPointsEmployeesPageModel;

  factory AdminPointsEmployeesPageModel.fromJson(Map<String, dynamic> json) =>
      _$AdminPointsEmployeesPageModelFromJson(json);
}

@freezed
class AdminPointsEmployeesResponseModel
    with _$AdminPointsEmployeesResponseModel {
  const factory AdminPointsEmployeesResponseModel({
    AdminPointsEmployeesPageModel? value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  }) = _AdminPointsEmployeesResponseModel;

  factory AdminPointsEmployeesResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminPointsEmployeesResponseModelFromJson(json);
}
