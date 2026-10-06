// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contractor_batch_models.freezed.dart';
part 'contractor_batch_models.g.dart';

@freezed
class ContractorDailyAttendanceRequestBody with _$ContractorDailyAttendanceRequestBody {
  const factory ContractorDailyAttendanceRequestBody({
    @JsonKey(name: 'contractor_id') required String contractorId,
    @JsonKey(name: 'site_id') required String siteId,
    @JsonKey(name: 'date') required String date,
    @JsonKey(name: 'status') @Default('Present') String status,
    @JsonKey(name: 'notes') String? notes,
  }) = _ContractorDailyAttendanceRequestBody;

  factory ContractorDailyAttendanceRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ContractorDailyAttendanceRequestBodyFromJson(json);
}

@freezed
class BatchWorkerAttendanceRequestBody with _$BatchWorkerAttendanceRequestBody {
  const factory BatchWorkerAttendanceRequestBody({
    @JsonKey(name: 'site_id') required String siteId,
    @JsonKey(name: 'contractor_id') required String contractorId,
    @JsonKey(name: 'date') required String date,
    @JsonKey(name: 'worker_ids') required List<String> workerIds,
    @JsonKey(name: 'latitude') double? latitude,
    @JsonKey(name: 'longitude') double? longitude,
  }) = _BatchWorkerAttendanceRequestBody;

  factory BatchWorkerAttendanceRequestBody.fromJson(Map<String, dynamic> json) =>
      _$BatchWorkerAttendanceRequestBodyFromJson(json);
}

@freezed
class SingleWorkerBatchResultModel with _$SingleWorkerBatchResultModel {
  const factory SingleWorkerBatchResultModel({
    @JsonKey(name: 'workerId') required String workerId,
    @JsonKey(name: 'workerName') String? workerName,
    @JsonKey(name: 'status') required String status, // RECORDED, REJECTED
    @JsonKey(name: 'errorCode') String? errorCode,
    @JsonKey(name: 'errorMessage') String? errorMessage,
  }) = _SingleWorkerBatchResultModel;

  factory SingleWorkerBatchResultModel.fromJson(Map<String, dynamic> json) =>
      _$SingleWorkerBatchResultModelFromJson(json);
}

@freezed
class BatchWorkerAttendanceSummaryModel with _$BatchWorkerAttendanceSummaryModel {
  const factory BatchWorkerAttendanceSummaryModel({
    @JsonKey(name: 'totalSubmitted') @Default(0) int totalSubmitted,
    @JsonKey(name: 'successfulCount') @Default(0) int successfulCount,
    @JsonKey(name: 'failedCount') @Default(0) int failedCount,
    @JsonKey(name: 'results') @Default([]) List<SingleWorkerBatchResultModel> results,
  }) = _BatchWorkerAttendanceSummaryModel;

  factory BatchWorkerAttendanceSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$BatchWorkerAttendanceSummaryModelFromJson(json);
}

@freezed
class BatchWorkerAttendanceResponseModel with _$BatchWorkerAttendanceResponseModel {
  const factory BatchWorkerAttendanceResponseModel({
    @JsonKey(name: 'isSuccess') @Default(false) bool isSuccess,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'value') BatchWorkerAttendanceSummaryModel? value,
    @JsonKey(name: 'errorMessage') String? errorMessage,
  }) = _BatchWorkerAttendanceResponseModel;

  factory BatchWorkerAttendanceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BatchWorkerAttendanceResponseModelFromJson(json);
}

@freezed
class NationalIdDetailsModel with _$NationalIdDetailsModel {
  const factory NationalIdDetailsModel({
    @JsonKey(name: 'birthDate') String? birthDate,
    @JsonKey(name: 'gender') String? gender,
    @JsonKey(name: 'governorate') String? governorate,
    @JsonKey(name: 'governorateCode') String? governorateCode,
    @JsonKey(name: 'century') String? century,
  }) = _NationalIdDetailsModel;

  factory NationalIdDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$NationalIdDetailsModelFromJson(json);
}
