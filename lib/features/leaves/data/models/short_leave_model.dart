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

  factory ShortLeaveModel.fromJson(Map<String, dynamic> json) {
    final raw = (json['value'] is Map<String, dynamic>)
        ? json['value'] as Map<String, dynamic>
        : (json['data'] is Map<String, dynamic>)
            ? json['data'] as Map<String, dynamic>
            : json;
    final payload = Map<String, dynamic>.from(raw);
    payload['id'] = (payload['id'] ?? payload['_id'] ?? '').toString();
    payload['employeeId'] = (payload['employeeId'] ?? '').toString();
    payload['date'] = payload['date'] ?? DateTime.now().toIso8601String();
    payload['startTime'] = (payload['startTime'] ?? '00:00').toString();
    payload['endTime'] = (payload['endTime'] ?? '00:00').toString();
    payload['permitType'] = (payload['permitType'] ?? 'LateArrival').toString();
    payload['totalHours'] = (payload['totalHours'] as num?)?.toDouble() ?? 0.0;
    payload['status'] = (payload['status'] ?? 'Pending').toString();
    return _$ShortLeaveModelFromJson(payload);
  }
}
