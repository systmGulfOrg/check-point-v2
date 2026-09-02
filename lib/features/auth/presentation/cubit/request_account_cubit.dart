import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/account_request_model.dart';
import '../../data/repos/auth_repo.dart';
import 'request_account_state.dart';

class RequestAccountCubit extends Cubit<RequestAccountState> {
  RequestAccountCubit({required this.authRepo})
    : super(const RequestAccountState.initial());

  final AuthRepo authRepo;

  Future<void> submit(AccountRequestModel request) async {
    emit(const RequestAccountState.loading());
    final result = await authRepo.requestAccount(request);
    result.when(
      success: (_) => emit(const RequestAccountState.success()),
      failure: (failure) => emit(RequestAccountState.error(failure.messageKey)),
    );
  }
}
