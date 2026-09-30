import 'package:freezed_annotation/freezed_annotation.dart';

part 'tenant_features_state.freezed.dart';

@freezed
abstract class TenantFeaturesState with _$TenantFeaturesState {
  const factory TenantFeaturesState.initial() = TenantFeaturesInitial;
  const factory TenantFeaturesState.loading() = TenantFeaturesLoading;
  const factory TenantFeaturesState.loaded(
    List<String> enabledFeatures,
  ) = TenantFeaturesLoaded;
  const factory TenantFeaturesState.error(String messageKey) =
      TenantFeaturesError;
}
