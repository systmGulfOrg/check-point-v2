import 'package:freezed_annotation/freezed_annotation.dart';

part 'worker_site_assignment_model.freezed.dart';
part 'worker_site_assignment_model.g.dart';

@freezed
abstract class WorkerSiteAssignmentModel with _$WorkerSiteAssignmentModel {
  const factory WorkerSiteAssignmentModel({
    required String id,
    required String workerId,
    required String workerName,
    required String branchId,
    required String siteName,
    String? assignedById,
    String? assignedByName,
    String? validFrom,
    String? validUntil,
    @Default(true) bool isActive,
    String? contractorId,
    String? contractorName,
    String? projectId,
    String? projectName,
  }) = _WorkerSiteAssignmentModel;

  factory WorkerSiteAssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$WorkerSiteAssignmentModelFromJson(json);
}
