import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/auth/data/models/account_request/account_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/account_request/account_request_status_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_response_model.dart';
import 'package:check_point_v2/features/auth/data/models/tenant/tenant_lookup_model.dart';
import 'package:check_point_v2/features/auth/data/models/trial_signup/trial_signup_model.dart';
import 'package:check_point_v2/features/auth/data/models/trial_signup/trial_signup_request_body.dart';

abstract class AuthRepo {
  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request);
  Future<ApiResult<bool>> requestDeviceTransfer(LoginRequestModel request);

  Future<ApiResult<void>> requestAccount(AccountRequestModel request);
  Future<ApiResult<AccountRequestStatusModel?>> getAccountRequestStatus(
    String mobileId,
  );
  Future<ApiResult<TenantLookupModel>> verifyTenant(String tenantSlug);
  Future<ApiResult<TrialSignupModel>> createTrialSignup(
    TrialSignupRequestBody request,
  );
}
