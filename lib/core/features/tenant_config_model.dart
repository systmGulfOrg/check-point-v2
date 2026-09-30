// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tenant_config_model.freezed.dart';
part 'tenant_config_model.g.dart';

@freezed
abstract class TenantConfigModel with _$TenantConfigModel {
  const factory TenantConfigModel({
    required String tenantId,
    required String companyName,
    required List<String> enabledFeatures,
    String? orgModel,
    String? timezone,
    String? locale,
  }) = _TenantConfigModel;

  factory TenantConfigModel.fromJson(Map<String, dynamic> json) =>
      _$TenantConfigModelFromJson(json);
}

@freezed
abstract class TenantConfigApiResponse with _$TenantConfigApiResponse {
  const factory TenantConfigApiResponse({
    @JsonKey(name: 'isSuccess') @Default(false) bool isSuccess,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'value') TenantConfigModel? value,
    @JsonKey(name: 'successMessage') String? successMessage,
    @JsonKey(name: 'errors') @Default([]) List<dynamic> errors,
  }) = _TenantConfigApiResponse;

  factory TenantConfigApiResponse.fromJson(Map<String, dynamic> json) =>
      _$TenantConfigApiResponseFromJson(json);
}
