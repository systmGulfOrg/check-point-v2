import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../admin/data/models/audit/audit_log_model.dart';

part 'admin_employee_audit_state.freezed.dart';

@freezed
class AdminEmployeeAuditState with _$AdminEmployeeAuditState {
  const factory AdminEmployeeAuditState.initial() = _Initial;
  const factory AdminEmployeeAuditState.loading() = _Loading;
  const factory AdminEmployeeAuditState.success(List<AuditLogModel> logs) = _Success;
  const factory AdminEmployeeAuditState.error(String message) = _Error;
}
