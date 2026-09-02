import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/login_request_model.dart';
import '../../domain/use_cases/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUseCase}) : super(const LoginState.initial());

  final LoginUseCase loginUseCase;

  Future<void> login(LoginRequestModel request) async {
    emit(const LoginState.loading());
    final result = await loginUseCase(request);
    result.when(
      success: (user) => emit(LoginState.success(user)),
      failure: (failure) => emit(LoginState.error(failure.messageKey)),
    );
  }
}
