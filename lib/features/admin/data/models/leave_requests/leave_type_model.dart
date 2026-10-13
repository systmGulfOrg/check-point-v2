import 'package:json_annotation/json_annotation.dart';

import 'package:check_point_v2/core/utils/legacy_api_response_helpers.dart';

part 'leave_type_model.g.dart';

@JsonSerializable()
class LeaveTypeModel {
  const LeaveTypeModel({
    this.id,
    this.typeName,
    this.maxDaysPerYear,
    this.isPaid,
    this.requiresAttachment,
    this.isCasual,
  });

  final int? id;
  final String? typeName;
  final int? maxDaysPerYear;
  final bool? isPaid;
  final bool? requiresAttachment;
  final bool? isCasual;

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypeModelToJson(this);
}

@JsonSerializable()
class LeaveTypesResponseModel {
  const LeaveTypesResponseModel({
    this.value,
    this.isSuccess,
    this.successMessage,
  });

  final LeaveTypesPageModel? value;
  final bool? isSuccess;
  final String? successMessage;

  factory LeaveTypesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypesResponseModelFromJson({
        ...json,
        'value': legacyPageValue(json['value']),
      });

  Map<String, dynamic> toJson() => _$LeaveTypesResponseModelToJson(this);
}

@JsonSerializable()
class LeaveTypesPageModel {
  const LeaveTypesPageModel({this.items, this.data, this.totalCount});

  final List<LeaveTypeModel>? items;
  final List<LeaveTypeModel>? data;
  final int? totalCount;

  List<LeaveTypeModel> get list => items ?? data ?? const [];

  factory LeaveTypesPageModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypesPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypesPageModelToJson(this);
}

@JsonSerializable()
class AddLeaveTypeRequestBody {
  const AddLeaveTypeRequestBody({
    required this.typeName,
    this.maxDaysPerYear,
    this.isPaid = true,
    this.requiresAttachment = false,
  });

  final String typeName;
  final int? maxDaysPerYear;
  final bool isPaid;
  final bool requiresAttachment;

  factory AddLeaveTypeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddLeaveTypeRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddLeaveTypeRequestBodyToJson(this);
}
