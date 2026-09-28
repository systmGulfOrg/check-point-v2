import 'package:freezed_annotation/freezed_annotation.dart';

part 'contractor_correction_model.freezed.dart';
part 'contractor_correction_model.g.dart';

@freezed
abstract class ContractorCorrectionModel with _$ContractorCorrectionModel {
  const factory ContractorCorrectionModel({
    required String id,
    required String workerId,
    required String workerName,
    required String workerCode,
    required String date,
    required String requestedCheckIn,
    required String requestedCheckOut,
    required String reason,
    required String status,
    required String createdAt,
    String? supervisorNotes,
    String? approvedById,
    String? approvedAt,
  }) = _ContractorCorrectionModel;

  factory ContractorCorrectionModel.fromJson(Map<String, dynamic> json) =>
      _$ContractorCorrectionModelFromJson(json);
}
