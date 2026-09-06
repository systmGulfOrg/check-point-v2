import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../apis/admin_api_service.dart';
import '../models/admin_attendance_model.dart';
import 'admin_attendance_repo.dart';

class AdminAttendanceRepoImpl implements AdminAttendanceRepo {
  AdminAttendanceRepoImpl({required this.api});
  final AdminApiService api;

  @override
  Future<ApiResult<List<AdminAttendanceModel>>> getAdminAttendance({
    int itemCount = 1000,
    int index = 0,
  }) async {
    try {
      final response = await api.getAdminAttendance(
        itemCount: itemCount,
        index: index,
      );
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteAttendance(int id) async {
    try {
      await api.deleteAttendance(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
