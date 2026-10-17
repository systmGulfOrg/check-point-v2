import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/approve_account_request_body.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'admin_account_requests_state.dart';

class AdminAccountRequestsCubit extends SafeCubit<AdminAccountRequestsState> {
  AdminAccountRequestsCubit({required this.employeeRepo})
    : super(const AdminAccountRequestsState.initial());

  final AdminEmployeeRepo employeeRepo;
  List<AccountRequestModel> allRequests = const [];
  String currentFilter = 'admin.requests.filterPending';
  String currentSearch = '';
  bool newestFirst = true;

  Future<void> loadRequests() async {
    emit(const AdminAccountRequestsState.loading());
    final result = await employeeRepo.getAccountRequests(
      page: 0,
      pageSize: 100,
    );
    result.when(
      success: (data) {
        allRequests = data;
        _emitFiltered();
      },
      failure: (failure) {
        safeEmit(AdminAccountRequestsState.error(failure.messageKey));
      },
    );
  }

  void setFilter(String filterKey) {
    currentFilter = filterKey;
    _emitFiltered();
  }

  void setSearch(String search) {
    currentSearch = search;
    _emitFiltered();
  }

  void setSort({required bool newest}) {
    newestFirst = newest;
    _emitFiltered();
  }

  void _emitFiltered() {
    var filtered = List<AccountRequestModel>.from(allRequests);

    if (currentFilter == 'admin.requests.filterPending') {
      filtered = filtered.where((r) => r.isPending).toList();
    } else if (currentFilter == 'admin.requests.filterApproved') {
      filtered = filtered.where((r) => r.isApproved).toList();
    } else if (currentFilter == 'admin.requests.filterRejected') {
      filtered = filtered.where((r) => r.isRejected).toList();
    }

    if (currentSearch.trim().isNotEmpty) {
      final query = currentSearch.trim().toLowerCase();
      filtered = filtered.where((r) {
        final name = (r.name ?? '').toLowerCase();
        final mobile = (r.mobileId ?? '').toLowerCase();
        final phone = (r.phone ?? '').toLowerCase();
        return name.contains(query) ||
            mobile.contains(query) ||
            phone.contains(query);
      }).toList();
    }

    filtered.sort((a, b) {
      final dateA = a.createdDate ?? DateTime.fromMillisecondsSinceEpoch(0);
      final dateB = b.createdDate ?? DateTime.fromMillisecondsSinceEpoch(0);
      return newestFirst ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
    });

    emit(AdminAccountRequestsState.success(filtered));
  }

  Future<String?> approveRequest({
    required int id,
    required ApproveAccountRequestBody body,
  }) async {
    emit(const AdminAccountRequestsState.loading());
    final result = await employeeRepo.approveAccountRequest(id: id, body: body);
    return result.when(
      success: (_) async {
        await loadRequests();
        return null;
      },
      failure: (failure) {
        safeEmit(AdminAccountRequestsState.error(failure.messageKey));
        return failure.messageKey;
      },
    );
  }

  Future<String?> rejectRequest({
    required int id,
    required String reason,
  }) async {
    emit(const AdminAccountRequestsState.loading());
    final result = await employeeRepo.rejectAccountRequest(
      id: id,
      reason: reason,
    );
    return result.when(
      success: (_) async {
        await loadRequests();
        return null;
      },
      failure: (failure) {
        safeEmit(AdminAccountRequestsState.error(failure.messageKey));
        return failure.messageKey;
      },
    );
  }

  Future<String?> deleteRequest({required int id}) async {
    emit(const AdminAccountRequestsState.loading());
    final result = await employeeRepo.deleteAccountRequest(id: id);
    return result.when(
      success: (_) async {
        await loadRequests();
        return null;
      },
      failure: (failure) {
        safeEmit(AdminAccountRequestsState.error(failure.messageKey));
        return failure.messageKey;
      },
    );
  }
}
