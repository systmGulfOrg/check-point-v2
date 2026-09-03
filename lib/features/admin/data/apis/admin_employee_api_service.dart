import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/employees_response_model.dart';

part 'admin_employee_api_service.g.dart';

@RestApi()
abstract class AdminEmployeeApiService {
  factory AdminEmployeeApiService(Dio dio, {String? baseUrl}) =
      _AdminEmployeeApiService;

  @GET(ApiConstants.employees)
  Future<EmployeesResponseModel> getEmployees({
    @Query('itemCount') int itemCount = 20,
    @Query('index') int index = 0,
  });

  @GET('${ApiConstants.employees}/search/{searchKey}')
  Future<EmployeesResponseModel> searchEmployees(
    @Path('searchKey') String searchKey,
  );
}
