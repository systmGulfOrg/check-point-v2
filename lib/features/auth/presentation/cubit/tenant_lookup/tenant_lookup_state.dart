import 'package:freezed_annotation/freezed_annotation.dart';

part 'tenant_lookup_state.freezed.dart';

@freezed
abstract class TenantLookupState with _$TenantLookupState {
  const factory TenantLookupState.initial() = TenantLookupInitial;
  const factory TenantLookupState.loading() = TenantLookupLoading;
  const factory TenantLookupState.success(String tenantSlug) =
      TenantLookupSuccess;
  const factory TenantLookupState.error(String messageKey) =
      TenantLookupError;
}
