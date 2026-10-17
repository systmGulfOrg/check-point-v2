import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/device_identity_provider.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo.dart';
import 'request_account_status_state.dart';

class RequestAccountStatusCubit extends SafeCubit<RequestAccountStatusState> {
  RequestAccountStatusCubit({
    required this.authRepo,
    required this.deviceIdentityProvider,
    required this.authSessionStorage,
  }) : super(const RequestAccountStatusState.initial());

  final AuthRepo authRepo;
  final DeviceIdentityProvider deviceIdentityProvider;
  final AuthSessionStorage authSessionStorage;

  Future<void> load() async {
    emit(const RequestAccountStatusState.loading());
    final result = await authRepo.getAccountRequestStatus(
      deviceIdentityProvider.mobileId,
    );
    await result.when(
      success: (request) async {
        final dismissedMobileId = await authSessionStorage
            .readAccountRequestDismissedMobileId();
        final visibleRequest =
            request?.status == 'Approved' &&
                dismissedMobileId == deviceIdentityProvider.mobileId
            ? null
            : request;
        safeEmit(RequestAccountStatusState.success(visibleRequest));
      },
      failure: (failure) async =>
          safeEmit(RequestAccountStatusState.error(failure.messageKey)),
    );
  }
}
