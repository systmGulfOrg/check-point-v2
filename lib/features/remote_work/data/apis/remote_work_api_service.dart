import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'remote_work_api_service.g.dart';

@RestApi()
abstract class RemoteWorkApiService {
  factory RemoteWorkApiService(Dio dio, {String? baseUrl}) =
      _RemoteWorkApiService;

  @GET('/api/v2/remote-policies')
  Future<dynamic> getPolicies();

  @POST('/api/v2/remote-policies')
  Future<dynamic> createPolicy(@Body() Map<String, dynamic> body);

  @PUT('/api/v2/remote-policies/{id}')
  Future<dynamic> updatePolicy(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/api/v2/remote-policies/{id}')
  Future<dynamic> deactivatePolicy(@Path('id') String id);

  @GET('/api/v2/remote-policies/{id}/employees')
  Future<dynamic> getPolicyEmployees(@Path('id') String id);

  @GET('/api/v2/remote-requests')
  Future<dynamic> getRequests({
    @Query('status') String? status,
    @Query('employeeId') String? employeeId,
    @Query('itemCount') int itemCount = 100,
  });

  @POST('/api/v2/remote-requests')
  Future<dynamic> createRequest(@Body() Map<String, dynamic> body);

  @PATCH('/api/v2/remote-requests/{id}/status')
  Future<dynamic> updateRequestStatus(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/api/v2/remote-requests/{id}')
  Future<dynamic> deleteRequest(@Path('id') String id);
}
