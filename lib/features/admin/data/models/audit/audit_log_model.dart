import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_log_model.freezed.dart';
part 'audit_log_model.g.dart';

@freezed
class AuditLogModel with _$AuditLogModel {
  const factory AuditLogModel({
    required String id,
    String? actorId,
    String? actorName,
    required String action,
    required DateTime createdAt,
    Map<String, dynamic>? before,
    Map<String, dynamic>? after,
  }) = _AuditLogModel;

  factory AuditLogModel.fromJson(Map<String, dynamic> json) => _$AuditLogModelFromJson(json);
}

@freezed
class AuditLogsResponseModel with _$AuditLogsResponseModel {
  const factory AuditLogsResponseModel({
    required bool isSuccess,
    required int status,
    required AuditLogsResponseValue value,
  }) = _AuditLogsResponseModel;

  factory AuditLogsResponseModel.fromJson(Map<String, dynamic> json) => _$AuditLogsResponseModelFromJson(json);
}

@freezed
class AuditLogsResponseValue with _$AuditLogsResponseValue {
  const factory AuditLogsResponseValue({
    required List<AuditLogModel> items,
    int? totalCount,
  }) = _AuditLogsResponseValue;

  factory AuditLogsResponseValue.fromJson(Map<String, dynamic> json) => _$AuditLogsResponseValueFromJson(json);
}
