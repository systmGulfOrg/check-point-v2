import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';

import 'tenant_config_api_service.dart';
import 'tenant_config_model.dart';
import 'tenant_features_repo.dart';

class TenantFeaturesRepoImpl implements TenantFeaturesRepo {
  TenantFeaturesRepoImpl({required this.api});

  final TenantConfigApiService api;

  @override
  Future<ApiResult<TenantConfigModel>> getTenantConfig() async {
    try {
      final response = await api.getTenantConfig();
      final config = response.value;
      if (config == null) {
        return const ApiResult.failure(
          ApiFailure(messageKey: 'errors.unknown'),
        );
      }
      return ApiResult.success(config);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
