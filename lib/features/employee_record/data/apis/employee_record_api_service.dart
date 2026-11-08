import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:check_point_v2/core/network/api_constants.dart';
import '../models/employee_record_model.dart';

part 'employee_record_api_service.g.dart';

@RestApi()
abstract class EmployeeRecordApiService {
  factory EmployeeRecordApiService(Dio dio, {String? baseUrl}) =
      _EmployeeRecordApiService;

  @GET(ApiConstants.employeeRecord)
  Future<EmployeeRecordResponseModel> getRecord(
    @Path('id') String employeeId, {
    @Query('from') required String from,
    @Query('to') required String to,
  });
}
