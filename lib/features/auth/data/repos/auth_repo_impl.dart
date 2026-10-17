import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/auth/data/apis/auth_api_service.dart';
import 'package:check_point_v2/features/auth/data/models/account_request/account_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/account_request/account_request_status_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_response_model.dart';
import 'package:check_point_v2/features/auth/data/models/tenant/tenant_lookup_model.dart';
import 'package:check_point_v2/features/auth/data/models/trial_signup/trial_signup_model.dart';
import 'package:check_point_v2/features/auth/data/models/trial_signup/trial_signup_request_body.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({required this.api});

  final AuthApiService api;

  @override
  Future<ApiResult<bool>> requestDeviceTransfer(
    LoginRequestModel request,
  ) async {
    try {
      await api.requestDeviceTransfer(request);
      return const ApiResult.success(true);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request) async {
    try {
      final response = await api.login(request);
      final user = response.value;
      if (response.isSuccess != true || user == null) {
        return ApiResult.failure(
          ApiFailureMapper.fromMessages(
            response.errors,
            fallbackMessageKey: 'errors.invalidCredentials',
          ),
        );
      }
      final token = user.token;
      if (token == null || token.isEmpty) {
        return ApiResult.failure(
          const ApiFailure(messageKey: 'errors.invalidCredentials'),
        );
      }
      return ApiResult.success(user);
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }

  @override
  Future<ApiResult<void>> requestAccount(AccountRequestModel request) async {
    try {
      final response = await api.requestAccount(request);
      if (response.isSuccess != true) {
        return ApiResult.failure(
          const ApiFailure(messageKey: 'errors.accountRequestFailed'),
        );
      }
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }

  @override
  Future<ApiResult<AccountRequestStatusModel?>> getAccountRequestStatus(
    String mobileId,
  ) async {
    try {
      final response = await api.getAccountRequestStatus(mobileId);
      return ApiResult.success(response.value);
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }

  @override
  Future<ApiResult<TenantLookupModel>> verifyTenant(String tenantSlug) async {
    try {
      final response = await api.verifyTenant(tenantSlug);
      final tenant = response.value;
      if (tenant == null) {
        return const ApiResult.failure(
          ApiFailure(messageKey: 'errors.tenantNotFound'),
        );
      }
      if (tenant.valid != true) {
        return ApiResult.failure(
          ApiFailure(messageKey: _tenantReasonMessageKey(tenant.reason)),
        );
      }
      return ApiResult.success(tenant);
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }

  @override
  Future<ApiResult<TrialSignupModel>> createTrialSignup(
    TrialSignupRequestBody request,
  ) async {
    try {
      final response = await api.createTrialSignup(request);
      final signup = response.value;
      if (response.isSuccess != true || signup == null) {
        return ApiResult.failure(
          ApiFailureMapper.fromMessages(
            response.errors,
            fallbackMessageKey: 'errors.trialSignupFailed',
          ),
        );
      }
      return ApiResult.success(signup);
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }
}

String _tenantReasonMessageKey(String? reason) => switch (reason) {
  'SUSPENDED' => 'errors.tenantSuspended',
  'EXPIRED' => 'errors.tenantExpired',
  'ARCHIVED' => 'errors.tenantArchived',
  'PENDING_DELETION' => 'errors.tenantPendingDeletion',
  'TRIAL_EXPIRED' => 'errors.tenantTrialExpired',
  'DELETED' || 'TENANT_NOT_FOUND' => 'errors.tenantNotFound',
  _ => 'errors.tenantNotFound',
};
