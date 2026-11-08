import 'dart:async';

import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/approve_account_request_body.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'admin_account_requests_state.dart';

class AdminAccountRequestsCubit extends SafeCubit<AdminAccountRequestsState> {
  AdminAccountRequestsCubit({required this.employeeRepo})
    : super(const AdminAccountRequestsState.initial());

  final AdminEmployeeRepo employeeRepo;

  static const int pageSize = 20;
  static const Duration searchDebounce = Duration(milliseconds: 400);

  /// Loaded rows of the current filter; paging state lives next to it (§15).
  List<AccountRequestModel> allRequests = const [];
  int page = 0;
  bool isLoading = false;
  bool isComplete = false;
  String currentFilter = 'admin.requests.filterPending';
  String currentSearch = '';
  bool newestFirst = true;
  Timer? searchTimer;

  /// The status sent to the server for the selected tab (null = all).
  String? get statusFilter => switch (currentFilter) {
    'admin.requests.filterPending' => 'Pending',
    'admin.requests.filterApproved' => 'Approved',
    'admin.requests.filterRejected' => 'Rejected',
    _ => null,
  };

  /// [newResponse] true: first page (initial load, refresh, filter change).
  /// false: next page, ignored while loading or when everything is loaded.
  Future<void> loadRequests({bool newResponse = true}) async {
    if (!newResponse && (isLoading || isComplete)) return;
    isLoading = true;
    if (newResponse) {
      page = 0;
      isComplete = false;
      emit(const AdminAccountRequestsState.loading());
    } else {
      emit(
        AdminAccountRequestsState.success(
          allRequests,
          hasMore: true,
          isLoadingMore: true,
        ),
      );
    }
    final result = await employeeRepo.getAccountRequests(
      page: page,
      pageSize: pageSize,
      status: statusFilter,
      search: currentSearch,
      newestFirst: newestFirst,
    );
    isLoading = false;
    result.when(
      success: (data) {
        final rows = data.list;
        allRequests = newResponse ? rows : [...allRequests, ...rows];
        isComplete = !(data.hasNext ?? rows.length == pageSize);
        page++;
        safeEmit(
          AdminAccountRequestsState.success(allRequests, hasMore: !isComplete),
        );
      },
      failure: (failure) {
        safeEmit(AdminAccountRequestsState.error(failure.messageKey));
      },
    );
  }

  Future<void> setFilter(String filterKey) {
    currentFilter = filterKey;
    return loadRequests();
  }

  void setSearch(String search) {
    currentSearch = search;
    searchTimer?.cancel();
    searchTimer = Timer(searchDebounce, loadRequests);
  }

  Future<void> setSort({required bool newest}) {
    newestFirst = newest;
    return loadRequests();
  }

  @override
  Future<void> close() {
    searchTimer?.cancel();
    return super.close();
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
