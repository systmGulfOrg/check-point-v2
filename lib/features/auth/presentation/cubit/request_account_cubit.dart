import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/account_request_model.dart';
import '../../domain/use_cases/request_account_use_case.dart';
import 'request_account_state.dart';

class RequestAccountCubit extends Cubit<RequestAccountState> {
  RequestAccountCubit({required this.requestAccountUseCase})
    : super(const RequestAccountState.initial());

  final RequestAccountUseCase requestAccountUseCase;

  Future<void> submit(AccountRequestModel request) async {
    emit(const RequestAccountState.loading());
    final result = await requestAccountUseCase(request);
    result.when(
      success: (_) => emit(const RequestAccountState.success()),
      failure: (failure) => emit(RequestAccountState.error(failure.messageKey)),
    );
  }
}
