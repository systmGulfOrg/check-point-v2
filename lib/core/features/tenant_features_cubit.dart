import 'package:flutter_bloc/flutter_bloc.dart';

import 'tenant_features_repo.dart';
import 'tenant_features_state.dart';

class TenantFeaturesCubit extends Cubit<TenantFeaturesState> {
  TenantFeaturesCubit({required this.tenantFeaturesRepo})
      : super(const TenantFeaturesState.initial());

  final TenantFeaturesRepo tenantFeaturesRepo;

  List<String> get enabledFeatures => switch (state) {
    TenantFeaturesLoaded(:final enabledFeatures) => enabledFeatures,
    _ => const [],
  };

  bool isEnabled(String featureKey) {
    if (enabledFeatures.isEmpty) {
      return true;
    }
    return enabledFeatures.contains(featureKey);
  }

  Future<void> loadFeatures() async {
    emit(const TenantFeaturesState.loading());
    final result = await tenantFeaturesRepo.getTenantConfig();
    result.when(
      success: (config) =>
          emit(TenantFeaturesState.loaded(config.enabledFeatures)),
      failure: (f) =>
          emit(TenantFeaturesState.error(f.messageKey)),
    );
  }
}
