// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'contractor_batch_models.dart';
import 'contractor_company_model.dart';

part 'contractor_worker_model.freezed.dart';
part 'contractor_worker_model.g.dart';

@freezed
class ContractorWorkerModel with _$ContractorWorkerModel {
  const ContractorWorkerModel._();

  const factory ContractorWorkerModel({
    required String id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'fullName') String? fullName,
    @JsonKey(name: 'employeeCode') String? employeeCode,
    @JsonKey(name: 'workerCode') String? workerCode,
    @JsonKey(name: 'nationalId') @Default('') String nationalId,
    @JsonKey(name: 'phone') @Default('') String phone,
    @JsonKey(name: 'position') String? position,
    @JsonKey(name: 'jobTitle') String? jobTitle,
    @JsonKey(name: 'projectName') String? projectName,
    @JsonKey(name: 'siteName') String? siteName,
    @JsonKey(name: 'status') @Default('active') String status,
    @JsonKey(name: 'startDate') @Default('') String startDate,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'photoUrl') String? photoUrl,
    @JsonKey(name: 'lastCheckIn') String? lastCheckIn,
    @JsonKey(name: 'contractorId') String? contractorId,
    @JsonKey(name: 'contractorName') String? contractorName,
    @JsonKey(name: 'deviceUuid') String? deviceUuid,
    @JsonKey(name: 'contractor') ContractorCompanyModel? contractor,
    @JsonKey(name: 'nationalIdDetails') NationalIdDetailsModel? nationalIdDetails,
  }) = _ContractorWorkerModel;

  factory ContractorWorkerModel.fromJson(Map<String, dynamic> json) =>
      _$ContractorWorkerModelFromJson(json);

  String get displayName => name ?? fullName ?? '';
  String get displayCode => employeeCode ?? workerCode ?? '';
  String get displayJob => position ?? jobTitle ?? '';
  String? get displayImage => imageUrl ?? photoUrl;
}
