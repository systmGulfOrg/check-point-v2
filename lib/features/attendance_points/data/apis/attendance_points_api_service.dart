import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'attendance_points_api_service.g.dart';

@RestApi()
abstract class AttendancePointsApiService {
  factory AttendancePointsApiService(Dio dio, {String? baseUrl}) =
      _AttendancePointsApiService;

  @GET('/api/v2/points/summary')
  Future<dynamic> getSummary(@Query('employeeId') String? employeeId);

  @GET('/api/v2/points/history')
  Future<dynamic> getHistory({
    @Query('employeeId') String? employeeId,
    @Query('index') int index = 0,
    @Query('itemCount') int itemCount = 50,
  });

  @GET('/api/v2/points/monthly-summary')
  Future<dynamic> getMonthlySummary({
    @Query('employeeId') String? employeeId,
    @Query('year') required int year,
    @Query('month') required int month,
  });
}
