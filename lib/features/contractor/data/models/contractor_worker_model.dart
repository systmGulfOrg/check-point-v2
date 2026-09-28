import 'package:freezed_annotation/freezed_annotation.dart';

part 'contractor_worker_model.freezed.dart';
part 'contractor_worker_model.g.dart';

@freezed
abstract class ContractorWorkerModel with _$ContractorWorkerModel {
  const factory ContractorWorkerModel({
    required String id,
    required String fullName,
    required String workerCode,
    required String nationalId,
    required String phone,
    required String jobTitle,
    required String projectName,
    required String siteName,
    @Default('active') String status,
    @Default('') String startDate,
    String? photoUrl,
    String? lastCheckIn,
    String? contractorId,
    String? contractorName,
    String? deviceUuid,
  }) = _ContractorWorkerModel;

  factory ContractorWorkerModel.fromJson(Map<String, dynamic> json) =>
      _$ContractorWorkerModelFromJson(json);
}
