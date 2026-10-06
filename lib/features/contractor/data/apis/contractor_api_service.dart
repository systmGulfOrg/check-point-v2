import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:check_point_v2/features/contractor/data/models/contractor_batch_models.dart';

part 'contractor_api_service.g.dart';

@RestApi()
abstract class ContractorApiService {
  factory ContractorApiService(Dio dio, {String? baseUrl}) =
      _ContractorApiService;

  // SAMCO Workforce v2
  @GET('/api/v2/workforce/samco/sites/{siteId}/boundary')
  Future<dynamic> getSamcoSiteBoundary(@Path('siteId') String siteId);

  @POST('/api/v2/workforce/samco/attendance/contractors')
  Future<dynamic> recordSamcoContractorAttendance(
    @Body() ContractorDailyAttendanceRequestBody body,
  );

  @POST('/api/v2/workforce/samco/attendance/workers/batch')
  Future<BatchWorkerAttendanceResponseModel> recordSamcoBatchWorkerAttendance(
    @Body() BatchWorkerAttendanceRequestBody body,
  );

  @GET('/api/v2/workforce/samco/workers')
  Future<dynamic> getSamcoWorkers(
    @Query('contractor_id') String? contractorId,
  );

  @POST('/api/v2/workforce/samco/attendance/sync')
  Future<dynamic> syncSamcoAttendanceOffline(
    @Body() Map<String, dynamic> body,
  );

  // Existing / v1 endpoints
  @GET('/api/v1/contractors')
  Future<dynamic> getContractors();

  @POST('/api/v1/contractors')
  Future<dynamic> createContractor(@Body() Map<String, dynamic> body);

  @GET('/api/v1/contractors/{id}/workers')
  Future<dynamic> getContractorWorkers(@Path('id') String contractorId);

  @POST('/api/v1/contractors/{id}/workers')
  Future<dynamic> createContractorWorker(
    @Path('id') String contractorId,
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/v1/sites/{id}/boundary')
  Future<dynamic> getSiteBoundary(@Path('id') String siteId);

  @POST('/api/v1/workers/assignments')
  Future<dynamic> assignWorkerToSite(@Body() Map<String, dynamic> body);

  @POST('/api/v1/attendance/check-in')
  Future<dynamic> checkIn(@Body() Map<String, dynamic> body);

  @POST('/api/v1/attendance/check-out')
  Future<dynamic> checkOut(@Body() Map<String, dynamic> body);

  @POST('/api/v1/attendance/sync-batch')
  Future<dynamic> syncAttendanceBatch(@Body() Map<String, dynamic> body);

  @POST('/api/v1/attendance/corrections')
  Future<dynamic> submitCorrection(@Body() Map<String, dynamic> body);

  @GET('/api/v1/attendance/corrections')
  Future<dynamic> getCorrections({@Query('status') String? status});

  @PATCH('/api/v1/attendance/corrections/{id}/status')
  Future<dynamic> updateCorrectionStatus(
    @Path('id') String correctionId,
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/v2/auth/customization')
  Future<dynamic> getCustomization();

  @GET('/api/v1/sites')
  Future<dynamic> getSites({
    @Query('projectId') String? projectId,
    @Query('search') String? search,
  });

  @POST('/api/v1/sites')
  Future<dynamic> createSite(@Body() Map<String, dynamic> body);

  @GET('/api/v1/workers/assignments')
  Future<dynamic> getWorkerAssignments({
    @Query('siteId') String? siteId,
    @Query('projectId') String? projectId,
    @Query('workerId') String? workerId,
    @Query('isActive') bool? isActive,
  });

  @GET('/api/v2/attendance')
  Future<dynamic> getAttendance({
    @Query('index') int? index,
    @Query('itemCount') int? itemCount,
    @Query('from') String? from,
    @Query('to') String? to,
  });
}
