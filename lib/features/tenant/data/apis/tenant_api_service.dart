import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:check_point_v2/features/tenant/data/models/tenant_model.dart';

part 'tenant_api_service.g.dart';

@RestApi()
abstract class TenantApiService {
  factory TenantApiService(Dio dio, {String? baseUrl}) = _TenantApiService;

  @GET('/api/Tenant/lookup/{companyCode}')
  Future<TenantLookupResponseModel> lookupByPath(
    @Path('companyCode') String companyCode,
  );

  @GET('/api/Tenant/lookup')
  Future<TenantLookupResponseModel> lookupByQuery(
    @Query('code') String companyCode,
  );
}
