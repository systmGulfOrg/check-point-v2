import 'package:check_point_v2/core/network/api_result.dart';

import 'tenant_config_model.dart';

abstract class TenantFeaturesRepo {
  Future<ApiResult<TenantConfigModel>> getTenantConfig();
}
