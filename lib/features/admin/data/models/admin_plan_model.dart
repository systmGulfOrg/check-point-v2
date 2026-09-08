import 'package:json_annotation/json_annotation.dart';

part 'admin_plan_model.g.dart';

@JsonSerializable()
class AdminPlanModel {
  const AdminPlanModel({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.assignedEmployeeId,
    this.assignedEmployeeName,
    this.notes,
    this.planDate,
    this.planType,
    this.status,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? assignedEmployeeId;
  final String? assignedEmployeeName;
  final String? notes;
  final String? planDate;
  final String? planType;
  final String? status;

  factory AdminPlanModel.fromJson(Map<String, dynamic> json) =>
      _$AdminPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPlanModelToJson(this);
}

@JsonSerializable()
class PlansResponseModel {
  const PlansResponseModel({this.value, this.isSuccess, this.successMessage});

  final PlansPageModel? value;
  final bool? isSuccess;
  final String? successMessage;

  factory PlansResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PlansResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlansResponseModelToJson(this);
}

@JsonSerializable()
class SinglePlanResponseModel {
  const SinglePlanResponseModel({this.value, this.isSuccess, this.successMessage});

  final AdminPlanModel? value;
  final bool? isSuccess;
  final String? successMessage;

  factory SinglePlanResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SinglePlanResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SinglePlanResponseModelToJson(this);
}

@JsonSerializable()
class PlansPageModel {
  const PlansPageModel({this.items, this.data, this.totalCount});

  final List<AdminPlanModel>? items;
  final List<AdminPlanModel>? data;
  final int? totalCount;

  List<AdminPlanModel> get list => items ?? data ?? const [];

  factory PlansPageModel.fromJson(Map<String, dynamic> json) =>
      _$PlansPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlansPageModelToJson(this);
}

@JsonSerializable()
class CreatePlanRequestBody {
  const CreatePlanRequestBody({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.assignedEmployeeId,
    this.departmentId,
  });

  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String assignedEmployeeId;
  final int? departmentId;

  factory CreatePlanRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreatePlanRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePlanRequestBodyToJson(this);
}
