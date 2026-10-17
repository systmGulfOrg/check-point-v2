import 'package:json_annotation/json_annotation.dart';

import 'tenant_lookup_model.dart';

part 'tenant_lookup_result_model.g.dart';

@JsonSerializable()
class TenantLookupResultModel {
  const TenantLookupResultModel({
    this.value,
    this.isSuccess,
    this.successMessage,
    this.errors,
  });

  final TenantLookupModel? value;
  final bool? isSuccess;
  final String? successMessage;
  final List<String>? errors;

  factory TenantLookupResultModel.fromJson(Map<String, dynamic> json) =>
      _$TenantLookupResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$TenantLookupResultModelToJson(this);
}
