import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:check_point_v2/features/tenant/data/models/tenant_model.dart';

part 'tenant_lookup_state.freezed.dart';

@freezed
class TenantLookupState with _$TenantLookupState {
  const factory TenantLookupState.initial() = _Initial;
  const factory TenantLookupState.loading() = _Loading;
  const factory TenantLookupState.success(TenantModel tenant) = _Success;
  const factory TenantLookupState.error(String message) = _Error;
}
