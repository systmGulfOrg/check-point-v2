import 'package:json_annotation/json_annotation.dart';

part 'shift_model.g.dart';

@JsonSerializable()
class ShiftModel {
  const ShiftModel({this.id, this.name, this.branchesCount});

  final int? id;
  final String? name;
  final int? branchesCount;

  factory ShiftModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftModelToJson(this);
}

@JsonSerializable()
class ShiftResponseModel {
  const ShiftResponseModel({this.value, this.isSuccess, this.successMessage});

  final ShiftPageModel? value;
  final bool? isSuccess;
  final String? successMessage;

  factory ShiftResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftResponseModelToJson(this);
}

@JsonSerializable()
class ShiftPageModel {
  const ShiftPageModel({this.items, this.data, this.totalCount});

  final List<ShiftModel>? items;
  final List<ShiftModel>? data;
  final int? totalCount;

  List<ShiftModel> get list => items ?? data ?? const [];

  factory ShiftPageModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftPageModelToJson(this);
}

@JsonSerializable()
class AddShiftRequestBody {
  const AddShiftRequestBody({required this.name});

  final String name;

  factory AddShiftRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddShiftRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddShiftRequestBodyToJson(this);
}

@JsonSerializable()
class AssignShiftsRequestBody {
  const AssignShiftsRequestBody({
    required this.shiftId,
    required this.branchIds,
  });

  final int shiftId;
  final List<int> branchIds;

  factory AssignShiftsRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AssignShiftsRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AssignShiftsRequestBodyToJson(this);
}
