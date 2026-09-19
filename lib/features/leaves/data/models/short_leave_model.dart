import 'package:freezed_annotation/freezed_annotation.dart';

part 'short_leave_model.freezed.dart';
part 'short_leave_model.g.dart';

@freezed
class ShortLeaveModel with _$ShortLeaveModel {
  const factory ShortLeaveModel({
    required String id,
    required String employeeId,
    required DateTime date,
    required String startTime,
    required String endTime,
    required String permitType,
    required double totalHours,
    int? durationMinutes,
    required String status,
    String? managerId,
    DateTime? managerActionAt,
    String? managerRejectionReason,
    String? reason,
    DateTime? createdAt,
  }) = _ShortLeaveModel;

  factory ShortLeaveModel.fromJson(Map<String, dynamic> json) =>
      _$ShortLeaveModelFromJson(json);
}
