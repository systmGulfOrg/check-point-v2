import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'admin_account_requests_state.dart';

class AdminAccountRequestsCubit extends Cubit<AdminAccountRequestsState> {
  AdminAccountRequestsCubit({required this.employeeRepo})
    : super(const AdminAccountRequestsState.initial());

  final AdminEmployeeRepo employeeRepo;

  Future<void> loadRequests() async {
    emit(const AdminAccountRequestsState.loading());
    final result = await employeeRepo.getAccountRequests();
    switch (result) {
      case Success(:final data):
        emit(AdminAccountRequestsState.success(data));
      case Failure(:final failure):
        emit(AdminAccountRequestsState.error(failure.messageKey));
    }
  }

  Future<bool> deleteRequest({required int id}) async {
    final result = await employeeRepo.deleteAccountRequest(id: id);
    switch (result) {
      case Success():
        await loadRequests();
        return true;
      case Failure(:final failure):
        emit(AdminAccountRequestsState.error(failure.messageKey));
        return false;
    }
    return false;
  }

  Future<bool> rejectRequest({required int id}) => deleteRequest(id: id);
}
