import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_point_v2/features/tenant/data/models/tenant_model.dart';
import 'package:check_point_v2/features/tenant/data/repos/tenant_repo.dart';
import 'tenant_lookup_state.dart';

class TenantLookupCubit extends Cubit<TenantLookupState> {
  TenantLookupCubit({required this.tenantRepo})
      : super(const TenantLookupState.initial());

  final TenantRepo tenantRepo;

  Future<void> lookupTenant(String companyCode) async {
    final sanitized = companyCode.trim();
    if (sanitized.isEmpty) {
      emit(const TenantLookupState.error('tenant.lookup.required'));
      return;
    }

    emit(const TenantLookupState.loading());
    final result = await tenantRepo.lookupTenant(sanitized);

    result.when(
      success: (tenant) => emit(TenantLookupState.success(tenant)),
      failure: (failure) => emit(TenantLookupState.error(failure.messageKey)),
    );
  }

  Future<TenantModel?> getSavedTenant() => tenantRepo.getSavedTenant();

  Future<void> clearSavedTenant() async {
    await tenantRepo.clearTenant();
    emit(const TenantLookupState.initial());
  }
}
