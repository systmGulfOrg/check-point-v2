import 'package:check_point_v2/core/network/api_result.dart';
import '../models/contractor_company_model.dart';
import '../models/contractor_worker_model.dart';
import '../models/contractor_batch_models.dart';
import '../models/site_boundary_model.dart';
import '../models/worker_site_assignment_model.dart';
import '../models/contractor_attendance_model.dart';
import '../models/contractor_correction_model.dart';
import '../models/offline_attendance_log_model.dart';
import '../models/samco_customization_model.dart';

abstract class ContractorRepo {
  // SAMCO Workforce v2
  Future<ApiResult<SiteBoundaryModel>> getSamcoSiteBoundary(String siteId);

  Future<ApiResult<void>> recordSamcoContractorAttendance(
    ContractorDailyAttendanceRequestBody body,
  );

  Future<ApiResult<BatchWorkerAttendanceSummaryModel>> recordSamcoBatchWorkerAttendance(
    BatchWorkerAttendanceRequestBody body,
  );

  Future<ApiResult<List<ContractorWorkerModel>>> getSamcoWorkers({
    String? contractorId,
  });

  Future<ApiResult<dynamic>> syncSamcoAttendanceOffline(
    Map<String, dynamic> body,
  );

  // Existing methods
  Future<ApiResult<List<ContractorCompanyModel>>> getContractors();

  Future<ApiResult<ContractorCompanyModel>> createContractor(
    Map<String, dynamic> body,
  );

  Future<ApiResult<List<ContractorWorkerModel>>> getContractorWorkers(
    String contractorId,
  );

  Future<ApiResult<ContractorWorkerModel>> createContractorWorker(
    String contractorId,
    Map<String, dynamic> body,
  );

  Future<ApiResult<SiteBoundaryModel>> getSiteBoundary(String siteId);

  Future<ApiResult<List<WorkerSiteAssignmentModel>>> assignWorkerToSite(
    Map<String, dynamic> body,
  );

  Future<ApiResult<ContractorAttendanceModel>> checkIn(
    Map<String, dynamic> body,
  );

  Future<ApiResult<ContractorAttendanceModel>> checkOut(
    Map<String, dynamic> body,
  );

  Future<ApiResult<Map<String, dynamic>>> syncAttendanceBatch(
    List<OfflineAttendanceLogModel> logs,
  );

  Future<ApiResult<List<SiteBoundaryModel>>> getSites({
    String? projectId,
    String? search,
  });

  Future<ApiResult<SiteBoundaryModel>> createSite(Map<String, dynamic> body);

  Future<ApiResult<List<WorkerSiteAssignmentModel>>> getWorkerAssignments({
    String? siteId,
    String? projectId,
    String? workerId,
    bool? isActive,
  });

  Future<ApiResult<List<ContractorAttendanceModel>>> getAttendance({
    int index = 0,
    int itemCount = 50,
    String? from,
    String? to,
  });

  Future<ApiResult<ContractorCorrectionModel>> submitCorrection(
    Map<String, dynamic> body,
  );

  Future<ApiResult<List<ContractorCorrectionModel>>> getCorrections({
    String? status,
  });

  Future<ApiResult<ContractorCorrectionModel>> updateCorrectionStatus({
    required String correctionId,
    required Map<String, dynamic> body,
  });

  Future<ApiResult<SamcoCustomizationModel>> getCustomization();
}
