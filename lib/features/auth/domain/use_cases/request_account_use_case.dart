import '../../../../core/network/api_result.dart';
import '../../data/models/account_request_model.dart';
import '../repos/auth_repo.dart';

class RequestAccountUseCase {
  RequestAccountUseCase({required this.authRepo});

  final AuthRepo authRepo;

  Future<ApiResult<void>> call(AccountRequestModel request) =>
      authRepo.requestAccount(request);
}
