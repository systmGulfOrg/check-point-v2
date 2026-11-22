import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/tenant_lookup/tenant_lookup_state.dart';

class TenantLookupCubit extends SafeCubit<TenantLookupState> {
  TenantLookupCubit({required this.authRepo, required this.authSessionStorage})
    : super(const TenantLookupState.initial());

  final AuthRepo authRepo;
  final AuthSessionStorage authSessionStorage;

  Future<void> verify(String companyCode) async {
    final tenantSlug = companyCode.trim().toLowerCase();
    emit(const TenantLookupState.loading());
    final result = await authRepo.verifyTenant(tenantSlug);
    result.when(
      success: (tenant) async {
        await authSessionStorage.saveTenantSlug(
          tenant.tenantSlug ?? tenantSlug,
        );
        safeEmit(TenantLookupState.success(tenant.tenantSlug ?? tenantSlug));
      },
      failure: (failure) =>
          safeEmit(TenantLookupState.error(failure.messageKey)),
    );
  }
}
