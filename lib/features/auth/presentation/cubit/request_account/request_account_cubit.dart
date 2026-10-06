import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/device_identity_provider.dart';
import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/tenant/tenant_storage.dart';
import 'package:check_point_v2/features/auth/data/models/account_request/account_request_model.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account/request_account_state.dart';

class RequestAccountCubit extends Cubit<RequestAccountState> {
  RequestAccountCubit({
    required this.authRepo,
    required this.deviceIdentityProvider,
    required this.authSessionStorage,
    this.tenantStorage,
  }) : super(const RequestAccountState.initial());

  final AuthRepo authRepo;
  final DeviceIdentityProvider deviceIdentityProvider;
  final AuthSessionStorage authSessionStorage;
  final TenantStorage? tenantStorage;

  Future<void> submit({
    required String name,
    String? accountType = 'Personal',
    String? siteId,
    String? nationalId,
    String? phone,
    String? notes,
  }) async {
    emit(const RequestAccountState.loading());

    final tenantSlug = await tenantStorage?.readTenantSlug() ??
        await tenantStorage?.readTenantCode();

    final rawOsVersion =
        '${Platform.operatingSystem} ${Platform.operatingSystemVersion}'.trim();
    final osVersion =
        rawOsVersion.length > 48 ? rawOsVersion.substring(0, 48) : rawOsVersion;

    final request = AccountRequestModel(
      name: name,
      fullName: name,
      mobileId: deviceIdentityProvider.mobileId,
      deviceId: deviceIdentityProvider.mobileId,
      deviceToken: deviceIdentityProvider.deviceToken,
      tenantSlug: tenantSlug,
      accountType: accountType,
      siteId: siteId,
      nationalId: nationalId,
      phone: phone,
      notes: notes,
      deviceModel: Platform.isAndroid ? 'Android Device' : 'iOS Device',
      osVersion: osVersion,
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
