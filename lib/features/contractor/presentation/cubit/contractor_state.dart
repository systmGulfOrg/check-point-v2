import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/contractor_company_model.dart';
import '../../data/models/contractor_worker_model.dart';
import '../../data/models/site_boundary_model.dart';
import '../../data/models/contractor_attendance_model.dart';
import '../../data/models/contractor_correction_model.dart';
import '../../data/models/samco_customization_model.dart';
import '../../data/models/worker_site_assignment_model.dart';

part 'contractor_state.freezed.dart';

@freezed
abstract class ContractorState with _$ContractorState {
  const factory ContractorState.initial() = _Initial;
  const factory ContractorState.loading() = _Loading;
  const factory ContractorState.success({
    @Default([]) List<ContractorCompanyModel> contractors,
    @Default([]) List<ContractorWorkerModel> workers,
    @Default([]) List<ContractorAttendanceModel> attendanceLogs,
    @Default([]) List<ContractorCorrectionModel> corrections,
    @Default([]) List<SiteBoundaryModel> sites,
    @Default([]) List<WorkerSiteAssignmentModel> assignments,
    SiteBoundaryModel? selectedSiteBoundary,
    SamcoCustomizationModel? customization,
    @Default(0) int pendingOfflineCount,
    String? message,
  }) = _Success;
  const factory ContractorState.error(String message) = _Error;
}
