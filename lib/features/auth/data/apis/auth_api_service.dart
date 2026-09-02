import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/account_request_model.dart';
import '../models/login_request_model.dart';
import '../models/login_result_model.dart';
import '../models/result_model.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String? baseUrl}) = _AuthApiService;

  @POST(ApiConstants.login)
  Future<LoginResultModel> login(@Body() LoginRequestModel request);

  @POST(ApiConstants.accountRequest)
  Future<ResultModel> requestAccount(@Body() AccountRequestModel request);
}
