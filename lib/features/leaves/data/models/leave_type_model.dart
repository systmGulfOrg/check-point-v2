import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_type_model.freezed.dart';
part 'leave_type_model.g.dart';

@freezed
class LeaveTypeModel with _$LeaveTypeModel {
  const factory LeaveTypeModel({
    required String id,
    required String typeName,
    required bool isPaid,
    required bool requiresAttachment,
    int? maxDaysPerYear,
  }) = _LeaveTypeModel;

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeModelFromJson(json);
}
