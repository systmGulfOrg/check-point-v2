import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import '../../../../../core/network/api_failure_mapper.dart';
import '../../../data/apis/admin_api_service.dart';
import 'admin_employee_audit_state.dart';

class AdminEmployeeAuditCubit extends SafeCubit<AdminEmployeeAuditState> {
  AdminEmployeeAuditCubit({required this.api})
    : super(const AdminEmployeeAuditState.initial());

  final AdminApiService api;

  Future<void> loadAuditLogs(String employeeId) async {
    emit(const AdminEmployeeAuditState.loading());
    try {
      final response = await api.getAuditLogs(employeeId);
      if (response.isSuccess == true) {
        safeEmit(AdminEmployeeAuditState.success(response.value.items));
      } else {
        safeEmit(
          const AdminEmployeeAuditState.error('Failed to load audit logs'),
        );
      }
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      safeEmit(AdminEmployeeAuditState.error(failure.messageKey));
    }
  }
}
