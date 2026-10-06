import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/device_identity_provider.dart';
import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/features/auth/data/models/account_request/account_request_model.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account/request_account_state.dart';

class RequestAccountCubit extends Cubit<RequestAccountState> {
  RequestAccountCubit({
    required this.authRepo,
    required this.deviceIdentityProvider,
    required this.authSessionStorage,
  }) : super(const RequestAccountState.initial());

  final AuthRepo authRepo;
  final DeviceIdentityProvider deviceIdentityProvider;
  final AuthSessionStorage authSessionStorage;

  Future<void> submit({
    required String name,
    String? nationalId,
    String? phone,
    String? accountType,
    String? siteId,
    String? notes,
    String? photoPath,
  }) async {
    emit(const RequestAccountState.loading());
    final request = AccountRequestModel(
      name: name,
      fullName: name,
      mobileId: deviceIdentityProvider.mobileId,
      deviceId: deviceIdentityProvider.mobileId,
      deviceToken: deviceIdentityProvider.deviceToken,
      nationalId: nationalId,
      phone: phone,
      accountType: accountType,
      siteId: siteId,
      notes: notes,
      photoPath: photoPath,
    );
    final result = await authRepo.requestAccount(request);
    result.when(
      success: (_) async {
        await authSessionStorage.clearAccountRequestDismissal();
        emit(const RequestAccountState.success());
      },
      failure: (failure) => emit(RequestAccountState.error(failure.messageKey)),
    );
  }
}
