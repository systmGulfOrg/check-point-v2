import '../../../../core/network/api_result.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';
import '../repos/auth_repo.dart';

class LoginUseCase {
  LoginUseCase({required this.authRepo});

  final AuthRepo authRepo;

  Future<ApiResult<LoginResponseModel>> call(LoginRequestModel request) =>
      authRepo.login(request);
}
