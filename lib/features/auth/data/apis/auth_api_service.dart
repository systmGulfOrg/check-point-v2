import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:check_point_v2/core/network/api_constants.dart';
import 'package:check_point_v2/features/auth/data/models/account_request/account_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/account_request/account_request_status_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_result_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/result_model.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String? baseUrl}) = _AuthApiService;

  @POST(ApiConstants.login)
  Future<LoginResultModel> login(@Body() LoginRequestModel request);

  @POST("/api/Auth/DeviceTransferRequest")
  Future<ResultModel> requestDeviceTransfer(@Body() LoginRequestModel request);

  @POST(ApiConstants.accountRequest)
  Future<ResultModel> requestAccount(@Body() AccountRequestModel request);

  @GET('/api/AccountRequest/status')
  Future<AccountRequestStatusResponseModel> getAccountRequestStatus(
    @Query('mobileId') String mobileId,
  );
}
