import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/login_request_model.dart';
import '../../data/repos/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepo}) : super(const LoginState.initial());

  final AuthRepo authRepo;

  Future<void> login(LoginRequestModel request) async {
    emit(const LoginState.loading());
    final result = await authRepo.login(request);
    result.when(
      success: (user) => emit(LoginState.success(user)),
      failure: (failure) => emit(LoginState.error(failure.messageKey)),
    );
  }
}
