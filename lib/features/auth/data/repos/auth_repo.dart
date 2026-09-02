import '../../../../core/network/api_result.dart';
import '../models/account_request_model.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

abstract class AuthRepo {
  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request);

  Future<ApiResult<void>> requestAccount(AccountRequestModel request);
}
