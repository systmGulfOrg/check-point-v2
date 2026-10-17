import 'package:json_annotation/json_annotation.dart';

part 'tenant_lookup_model.g.dart';

@JsonSerializable()
class TenantLookupModel {
  const TenantLookupModel({
    this.valid,
    this.tenantStatus,
    this.reason,
    this.tenantId,
    this.tenantSlug,
    this.companyName,
  });

  final bool? valid;
  final String? tenantStatus;
  final String? reason;
  final String? tenantId;
  final String? tenantSlug;
  final String? companyName;

  factory TenantLookupModel.fromJson(Map<String, dynamic> json) =>
      _$TenantLookupModelFromJson(json);

  Map<String, dynamic> toJson() => _$TenantLookupModelToJson(this);
}
