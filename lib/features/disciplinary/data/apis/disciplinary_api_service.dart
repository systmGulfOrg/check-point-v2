import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'disciplinary_api_service.g.dart';

@RestApi()
abstract class DisciplinaryApiService {
  factory DisciplinaryApiService(Dio dio, {String? baseUrl}) =
      _DisciplinaryApiService;

  @GET('/api/v2/disciplinary/matrix')
  Future<dynamic> getMatrix();

  @GET('/api/v2/disciplinary/my-violations')
  Future<dynamic> getMyViolations({@Query('month') String? month});

  @POST('/api/v2/disciplinary/appeals')
  Future<dynamic> submitAppeal(@Body() Map<String, dynamic> body);

  @GET('/api/v2/disciplinary/preview')
  Future<dynamic> previewViolation({
    @Query('employeeId') required String employeeId,
    @Query('ruleId') required String ruleId,
    @Query('date') String? date,
  });

  @POST('/api/v2/disciplinary/violations')
  Future<dynamic> recordViolation(@Body() Map<String, dynamic> body);

  @GET('/api/v2/disciplinary/violations')
  Future<dynamic> listViolations({
    @Query('month') String? month,
    @Query('status') String? status,
    @Query('index') int? index,
    @Query('itemCount') int? itemCount,
  });
}
