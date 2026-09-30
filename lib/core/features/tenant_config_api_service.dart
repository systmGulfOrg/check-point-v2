import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'tenant_config_model.dart';

part 'tenant_config_api_service.g.dart';

@RestApi()
abstract class TenantConfigApiService {
  factory TenantConfigApiService(Dio dio, {String? baseUrl}) =
      _TenantConfigApiService;

  @GET('/api/v1/tenant/config')
  Future<TenantConfigApiResponse> getTenantConfig();
}
