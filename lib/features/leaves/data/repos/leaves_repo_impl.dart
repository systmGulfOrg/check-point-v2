import '../../../../core/auth/auth_session_storage.dart';
import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/utils/app_date_formatter.dart';
import '../apis/leaves_api_service.dart';
import '../models/leave_balance_model.dart';
import '../models/leave_request_body.dart';
import '../models/leave_request_model.dart';
import '../models/leave_type_model.dart';
import '../models/official_holiday_model.dart';
import '../models/short_leave_model.dart';
import '../models/short_leave_request_body.dart';

class LeavesRepoImpl {
  LeavesRepoImpl({
    required this.api,
    required this.sessionStorage,
  });

  final LeavesApiService api;
  final AuthSessionStorage sessionStorage;

  Future<ApiResult<List<LeaveBalanceModel>>> getLeaveBalances({
    List<LeaveTypeModel>? types,
    List<LeaveRequestModel>? requests,
  }) async {
    try {
      final now = DateTime.now();
      final leaveTypesList = (types != null && types.isNotEmpty)
          ? types
          : (await getLeaveTypes()).when(
              success: (t) => t,
              failure: (_) => const <LeaveTypeModel>[],
            );
      final requestsList = (requests != null)
          ? requests
          : (await getLeaveRequests()).when(
              success: (r) => r,
              failure: (_) => const <LeaveRequestModel>[],
            );

      if (leaveTypesList.isNotEmpty) {
        final balances = leaveTypesList.map((lt) {
          final total = lt.maxDaysPerYear ?? 21;
          final used = requestsList
              .where((r) {
                final s = r.status.toLowerCase();
                final isApproved = s == 'approved' ||
                    s == 'approvedbyhr' ||
                    s == 'approvedbymanager';
                final matchesType = r.leaveTypeId == lt.id ||
                    (r.leaveTypeName != null &&
                        r.leaveTypeName!.trim().toLowerCase() ==
                            lt.typeName.trim().toLowerCase());
                return isApproved && matchesType;
              })
              .fold<int>(0, (sum, r) => sum + r.totalDays);

          final remaining = (total - used).clamp(0, total);

          return LeaveBalanceModel(
            id: lt.id,
            leaveTypeId: lt.id,
            leaveTypeName: lt.typeName,
            year: now.year,
            totalAllocated: total,
            usedBalance: used,
            remainingBalance: remaining,
            carriedOver: 0,
          );
        }).toList();

        return ApiResult.success(balances);
      }

      return ApiResult.success(const <LeaveBalanceModel>[]);
    } catch (e, _) {
      return ApiResult.success(const <LeaveBalanceModel>[]);
    }
  }

  Future<ApiResult<List<LeaveTypeModel>>> getLeaveTypes() async {
    try {
      final response = await api.getBackendLeaveTypes();
      final items = response.value?.list ?? [];
      if (items.isNotEmpty) {
        final models = items
            .where((t) => t.typeName != null && t.typeName!.isNotEmpty)
            .map(
              (t) => LeaveTypeModel(
                id: '${t.id ?? t.typeName}',
                typeName: t.typeName!,
                isPaid: t.isPaid ?? true,
                requiresAttachment: t.requiresAttachment ?? false,
                maxDaysPerYear: t.maxDaysPerYear ?? 21,
              ),
            )
            .toList();
        return ApiResult.success(models);
      }
      return const ApiResult.success(<LeaveTypeModel>[]);
    } catch (e, _) {
      return const ApiResult.success(<LeaveTypeModel>[]);
    }
  }

  Future<ApiResult<List<OfficialHolidayModel>>> getOfficialHolidays({
    int? year,
  }) async {
    try {
      final models = await api.getOfficialHolidays(year: year);
      return ApiResult.success(models);
    } catch (e, _) {
      return ApiResult.success([
        OfficialHolidayModel(id: '1', name: 'عيد الميلاد المجيد', date: DateTime(2026, 1, 7), isRecurring: false),
        OfficialHolidayModel(id: '2', name: 'ثورة 25 يناير / عيد الشرطة', date: DateTime(2026, 1, 25), isRecurring: false),
        OfficialHolidayModel(id: '3', name: 'عيد الفطر المبارك', date: DateTime(2026, 3, 20), isRecurring: false),
        OfficialHolidayModel(id: '4', name: 'شم النسيم', date: DateTime(2026, 4, 13), isRecurring: false),
        OfficialHolidayModel(id: '5', name: 'عيد تحرير سيناء', date: DateTime(2026, 4, 25), isRecurring: false),
        OfficialHolidayModel(id: '6', name: 'عيد العمال', date: DateTime(2026, 5, 1), isRecurring: false),
        OfficialHolidayModel(id: '7', name: 'وقفة عرفات', date: DateTime(2026, 5, 26), isRecurring: false),
        OfficialHolidayModel(id: '8', name: 'عيد الأضحى المبارك', date: DateTime(2026, 5, 27), isRecurring: false),
        OfficialHolidayModel(id: '9', name: 'رأس السنة الهجرية', date: DateTime(2026, 6, 16), isRecurring: false),
        OfficialHolidayModel(id: '10', name: 'ثورة 30 يونيو', date: DateTime(2026, 6, 30), isRecurring: false),
        OfficialHolidayModel(id: '11', name: 'ثورة 23 يوليو', date: DateTime(2026, 7, 23), isRecurring: false),
        OfficialHolidayModel(id: '12', name: 'المولد النبوي الشريف', date: DateTime(2026, 8, 25), isRecurring: false),
        OfficialHolidayModel(id: '13', name: 'عيد القوات المسلحة (6 أكتوبر)', date: DateTime(2026, 10, 6), isRecurring: false),
      ]);
    }
  }

  Future<ApiResult<LeaveRequestModel>> submitLeaveRequest(
    LeaveRequestBody body,
  ) async {
    try {
      final employeeId = await sessionStorage.readEmployeeId() ??
          await sessionStorage.readUserId() ??
          '';
      final payload = {
        'employeeId': employeeId,
        'startDate': AppDateFormatter.formatDate(body.startDate),
        'endDate': AppDateFormatter.formatDate(body.endDate),
        'reason': body.reason ?? '',
        'remark': body.reason ?? '',
        'leaveRequestType': body.leaveTypeId,
        if (body.attachmentUrl != null && body.attachmentUrl!.isNotEmpty)
          'attachmentUrl': body.attachmentUrl,
      };
      await api.submitBackendLeaveRequest(payload);
      return ApiResult.success(
        LeaveRequestModel(
          id: '0',
          leaveTypeId: body.leaveTypeId,
          employeeId: employeeId,
          startDate: body.startDate,
          endDate: body.endDate,
          totalDays: body.endDate.difference(body.startDate).inDays + 1,
          status: 'Pending',
          reason: body.reason,
          attachmentUrl: body.attachmentUrl,
        ),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<List<LeaveRequestModel>>> getLeaveRequests() async {
    try {
      final response = await api.getBackendLeaveRequests();
      final currentUserId = await sessionStorage.readUserId() ?? '';
      final currentEmployeeId = await sessionStorage.readEmployeeId() ?? '';
      final token = await sessionStorage.readToken();
      final tokenPayload =
          token != null ? AuthSessionStorage.decodeJwtPayload(token) : null;
      final tokenEmpId = tokenPayload?['employeeId'] as String? ??
          tokenPayload?['EmployeeId'] as String?;
      final currentUserName = await sessionStorage.readUserName() ?? '';

      final targetIds = {
        if (currentEmployeeId.isNotEmpty) currentEmployeeId,
        if (tokenEmpId != null && tokenEmpId.isNotEmpty) tokenEmpId,
        if (currentUserId.isNotEmpty) currentUserId,
      };

      final items = response.value?.list ?? [];
      final myRequests = targetIds.isNotEmpty
          ? items.where((r) {
              if (r.employeeId != null && targetIds.contains(r.employeeId)) {
                return true;
              }
              if (currentUserName.isNotEmpty &&
                  r.employeeName?.trim().toLowerCase() ==
                      currentUserName.trim().toLowerCase()) {
                return true;
              }
              return false;
            }).toList()
          : items;

      final models = myRequests.map((r) {
        final start = r.startDate != null
            ? DateTime.tryParse(r.startDate!) ?? DateTime.now()
            : DateTime.now();
        final end = r.endDate != null
            ? DateTime.tryParse(r.endDate!) ?? DateTime.now()
            : DateTime.now();
        return LeaveRequestModel(
          id: '${r.id ?? 0}',
          leaveTypeId: r.leaveType ?? '1',
          leaveTypeName: r.leaveType,
          employeeId: r.employeeId ?? '',
          startDate: start,
          endDate: end,
          totalDays: end.difference(start).inDays + 1,
          status: r.status ?? 'Pending',
          reason: r.reason,
          attachmentUrl: r.attachmentUrl,
          managerName: r.managerName,
          managerActionAt: r.managerActionAt != null
              ? DateTime.tryParse(r.managerActionAt!)
              : null,
          managerRejectionReason: r.managerRejectionReason,
          hrName: r.hrName,
          hrActionAt: r.hrActionAt != null
              ? DateTime.tryParse(r.hrActionAt!)
              : null,
          hrRejectionReason: r.hrRejectionReason,
        );
      }).toList();
      return ApiResult.success(models);
    } catch (e, _) {
      return const ApiResult.success(<LeaveRequestModel>[]);
    }
  }

  Future<ApiResult<dynamic>> updateLeaveStatus(
    String id,
    String status,
  ) async {
    try {
      final model = await api.updateLeaveStatus(id, {'status': status});
      return ApiResult.success(model);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<void>> cancelLeaveRequest(String id) async {
    try {
      await api.cancelLeaveRequest(id);
      return const ApiResult.success(null);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<void>> deleteLeaveRequest(dynamic id) async {
    try {
      await api.deleteLeaveRequest(id);
      return const ApiResult.success(null);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<List<ShortLeaveModel>>> getShortLeaves() async {
    try {
      return ApiResult.success(await api.getShortLeaves());
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<ShortLeaveModel>> submitShortLeaveRequest(
    ShortLeaveRequestBody body,
  ) async {
    try {
      return ApiResult.success(await api.submitShortLeaveRequest(body));
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
