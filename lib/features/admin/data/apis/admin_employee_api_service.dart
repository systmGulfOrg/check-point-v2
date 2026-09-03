import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/employees_response_model.dart';
import '../models/account_requests_response_model.dart';
import '../models/branch_response_model.dart';
import '../models/branch_request_model.dart';
import '../models/department_response_model.dart';
import '../models/department_request_model.dart';
import '../../../auth/data/models/result_model.dart';

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

  @GET(ApiConstants.accountRequests)
  Future<AccountRequestsResponseModel> getAccountRequests({
    @Query('itemCount') int itemCount = 20,
    @Query('index') int index = 0,
  });

  @DELETE(ApiConstants.accountRequests)
  Future<void> deleteAccountRequest(@Query('id') int id);

  @GET(ApiConstants.departments)
  Future<DepartmentResponseModel> getDepartments({
    @Query('itemCount') int itemCount = 50,
    @Query('index') int index = 0,
  });

  @GET('${ApiConstants.departments}/search/{searchKey}')
  Future<DepartmentResponseModel> searchDepartments(
    @Path('searchKey') String searchKey,
  );

  @POST(ApiConstants.departments)
  Future<ResultModel> addDepartment(@Body() DepartmentRequestModel request);

  @PUT('${ApiConstants.departments}/{id}')
  Future<ResultModel> editDepartment(
    @Path('id') int id,
    @Body() DepartmentRequestModel request,
  );

  @DELETE(ApiConstants.departments)
  Future<ResultModel> deleteDepartment(@Query('id') int id);

  @GET(ApiConstants.branches)
  Future<BranchResponseModel> getBranches();

  @POST(ApiConstants.branches)
  Future<ResultModel> addBranch(@Body() BranchRequestModel request);

  @PUT('${ApiConstants.branches}/{id}')
  Future<ResultModel> editBranch(
    @Path('id') int id,
    @Body() BranchRequestModel request,
  );

  @DELETE('${ApiConstants.branches}/{id}')
  Future<ResultModel> deleteBranch(@Path('id') int id);
}
