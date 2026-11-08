import 'dart:io';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/data/models/account_request/account_request_model.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account/request_account_state.dart';

class RequestAccountCubit extends SafeCubit<RequestAccountState> {
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

    String? effectivePhoto = photoPath;
    if (photoPath != null &&
        photoPath.isNotEmpty &&
        !photoPath.startsWith('http') &&
        !photoPath.startsWith('data:image')) {
      final file = File(photoPath);
      final bytes = await file.exists() ? await file.readAsBytes() : null;
      effectivePhoto = bytes == null
          ? null
          : await AppImageCompressor.compressAndEncodeBase64(bytes);
      if (effectivePhoto == null) {
        safeEmit(const RequestAccountState.error('errors.imageProcessing'));
        return;
      }
    }

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
      // Sent once: the server reads imageUrl first; photoPath doubled the body.
      imageUrl: effectivePhoto,
    );
    final result = await authRepo.requestAccount(request);
    result.when(
      success: (_) async {
        await authSessionStorage.clearAccountRequestDismissal();
        safeEmit(const RequestAccountState.success());
      },
      failure: (failure) =>
          safeEmit(RequestAccountState.error(failure.messageKey)),
    );
  }
}
