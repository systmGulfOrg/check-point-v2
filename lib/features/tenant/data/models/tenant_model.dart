// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tenant_model.freezed.dart';
part 'tenant_model.g.dart';

@freezed
class TenantModel with _$TenantModel {
  const factory TenantModel({
    @JsonKey(name: 'tenantId') String? tenantId,
    @JsonKey(name: 'tenantCode') String? tenantCode,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'companyName') String? companyName,
    @JsonKey(name: 'logoUrl') String? logoUrl,
    @JsonKey(name: 'baseUrl') String? baseUrl,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'isActive') @Default(true) bool isActive,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'roles') List<String>? roles,
    @JsonKey(name: 'orgModel') String? orgModel,
    @JsonKey(name: 'features') Map<String, dynamic>? features,
  }) = _TenantModel;

  factory TenantModel.fromJson(Map<String, dynamic> json) =>
      _$TenantModelFromJson(json);
}

@freezed
class TenantLookupResponseModel with _$TenantLookupResponseModel {
  const factory TenantLookupResponseModel({
    @JsonKey(name: 'isSuccess') @Default(false) bool isSuccess,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'value') TenantModel? value,
    @JsonKey(name: 'successMessage') String? successMessage,
    @JsonKey(name: 'errors') @Default([]) List<dynamic> errors,
  }) = _TenantLookupResponseModel;

  factory TenantLookupResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TenantLookupResponseModelFromJson(json);
}
