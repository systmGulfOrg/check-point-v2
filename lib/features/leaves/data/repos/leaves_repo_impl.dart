import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../apis/leaves_api_service.dart';
import '../models/leave_balance_model.dart';
import '../models/leave_request_body.dart';
import '../models/leave_request_model.dart';
import '../models/leave_type_model.dart';
import '../models/official_holiday_model.dart';
import '../models/short_leave_model.dart';
import '../models/short_leave_request_body.dart';

class LeavesRepoImpl {
  LeavesRepoImpl({required this.api});

  final LeavesApiService api;

  Future<ApiResult<List<LeaveBalanceModel>>> getLeaveBalances() async {
    try {
      final models = await api.getLeaveBalances();
      return ApiResult.success(models);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<List<LeaveTypeModel>>> getLeaveTypes() async {
    try {
      final models = await api.getLeaveTypes();
      return ApiResult.success(models);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
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
      final model = await api.submitLeaveRequest(body);
      return ApiResult.success(model);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<List<LeaveRequestModel>>> getLeaveRequests() async {
    try {
      final models = await api.getLeaveRequests();
      return ApiResult.success(models);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<LeaveRequestModel>> updateLeaveStatus(
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
