import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/tenant/tenant_storage.dart';
import 'package:check_point_v2/features/tenant/data/apis/tenant_api_service.dart';
import 'package:check_point_v2/features/tenant/data/models/tenant_model.dart';
import 'package:check_point_v2/features/tenant/data/repos/tenant_repo.dart';

class TenantRepoImpl implements TenantRepo {
  TenantRepoImpl({
    required this.api,
    required this.tenantStorage,
  });

  final TenantApiService api;
  final TenantStorage tenantStorage;

  @override
  Future<ApiResult<TenantModel>> lookupTenant(String companyCode) async {
    final sanitizedCode = companyCode.trim().toLowerCase();
    if (sanitizedCode.isEmpty) {
      return const ApiResult.failure(
        ApiFailure(messageKey: 'tenant.lookup.required'),
      );
    }

    try {
      TenantLookupResponseModel response;
      try {
        response = await api.lookupByPath(sanitizedCode);
      } catch (_) {
        response = await api.lookupByQuery(sanitizedCode);
      }

      if (response.value != null) {
        final tenant = response.value!;
        await tenantStorage.saveTenant(tenant);
        return ApiResult.success(tenant);
      }

      // If response is successful but value is null, construct tenant from code
      if (response.isSuccess) {
        final tenant = TenantModel(
          tenantId: sanitizedCode,
          tenantCode: sanitizedCode,
          companyName: response.successMessage ?? sanitizedCode.toUpperCase(),
        );
        await tenantStorage.saveTenant(tenant);
        return ApiResult.success(tenant);
      }

      return const ApiResult.failure(
        ApiFailure(messageKey: 'errors.notFound'),
      );
    } catch (e) {
      // Special handling for local/demo test tenants if server has not deployed /api/Tenant endpoint yet
      if (sanitizedCode == 'demo' ||
          sanitizedCode == 'systm-gulf' ||
          sanitizedCode == 'demo-tenant-000000000000') {
        final demoTenant = TenantModel(
          tenantId: sanitizedCode == 'demo-tenant-000000000000'
              ? sanitizedCode
              : 'demo-tenant-000000000000',
          tenantCode: sanitizedCode,
          companyName:
              sanitizedCode == 'systm-gulf' ? 'Systm Gulf' : 'Demo Company',
          isActive: true,
        );
        await tenantStorage.saveTenant(demoTenant);
        return ApiResult.success(demoTenant);
      }

      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<TenantModel?> getSavedTenant() => tenantStorage.readTenant();

  @override
  Future<void> saveTenant(TenantModel tenant) =>
      tenantStorage.saveTenant(tenant);

  @override
  Future<void> clearTenant() => tenantStorage.clearTenant();
}
