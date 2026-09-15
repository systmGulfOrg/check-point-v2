import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/api_failure_mapper.dart';
import '../../../data/apis/admin_api_service.dart';
import 'admin_employee_audit_state.dart';

class AdminEmployeeAuditCubit extends Cubit<AdminEmployeeAuditState> {
  AdminEmployeeAuditCubit({required this.api}) : super(const AdminEmployeeAuditState.initial());

  final AdminApiService api;

  Future<void> loadAuditLogs(String employeeId) async {
    emit(const AdminEmployeeAuditState.loading());
    try {
      final response = await api.getAuditLogs(employeeId);
      if (response.isSuccess == true) {
        emit(AdminEmployeeAuditState.success(response.value.items));
      } else {
        emit(const AdminEmployeeAuditState.error('Failed to load audit logs'));
      }
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      emit(AdminEmployeeAuditState.error(failure.messageKey));
    }
  }
}
