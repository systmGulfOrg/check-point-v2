import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/tenant/data/models/tenant_model.dart';

abstract class TenantRepo {
  Future<ApiResult<TenantModel>> lookupTenant(String companyCode);
  Future<TenantModel?> getSavedTenant();
  Future<void> saveTenant(TenantModel tenant);
  Future<void> clearTenant();
}
