import 'package:freezed_annotation/freezed_annotation.dart';

part 'contractor_company_model.freezed.dart';
part 'contractor_company_model.g.dart';

@freezed
abstract class ContractorCompanyModel with _$ContractorCompanyModel {
  const factory ContractorCompanyModel({
    required String id,
    required String code,
    required String name,
    String? taxNumber,
    String? commercialReg,
    String? contactName,
    String? contactPhone,
    String? contactEmail,
    @Default('active') String status,
    @Default(0) int workerCount,
    @Default(0) int presentCount,
  }) = _ContractorCompanyModel;

  factory ContractorCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$ContractorCompanyModelFromJson(json);
}
