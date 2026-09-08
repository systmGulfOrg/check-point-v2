import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/auth/data/models/account_request/account_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_response_model.dart';

abstract class AuthRepo {
  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request);

  Future<ApiResult<void>> requestAccount(AccountRequestModel request);
}
