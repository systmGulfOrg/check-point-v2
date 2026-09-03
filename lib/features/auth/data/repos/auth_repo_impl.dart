import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/network/api_failure.dart';
import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../apis/auth_api_service.dart';
import '../models/account_request_model.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({required this.api, required this.secureStorage});

  final AuthApiService api;
  final FlutterSecureStorage secureStorage;

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
      await secureStorage.write(key: 'auth_token', value: token);
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
}
