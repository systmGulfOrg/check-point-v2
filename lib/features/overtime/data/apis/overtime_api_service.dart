import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'overtime_api_service.g.dart';

@RestApi()
abstract class OvertimeApiService {
  factory OvertimeApiService(Dio dio, {String? baseUrl}) = _OvertimeApiService;

  @GET('/api/v2/overtime-requests')
  Future<dynamic> getRequests({@Query('status') String? status});

  @POST('/api/v2/overtime-requests')
  Future<dynamic> createRequest(@Body() Map<String, dynamic> body);

  @PATCH('/api/v2/overtime-requests/{id}/status')
  Future<dynamic> updateStatus(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/api/v2/overtime-requests/{id}')
  Future<dynamic> deleteRequest(@Path('id') String id);
}
