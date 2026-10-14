import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import '../../../data/apis/admin_api_service.dart';
import 'admin_pending_devices_state.dart';
import '../../../../../core/network/api_failure_mapper.dart';

class AdminPendingDevicesCubit extends SafeCubit<AdminPendingDevicesState> {
  Future<void> rejectDevice(String employeeId, String deviceId) async {
    emit(const AdminPendingDevicesState.loading());
    try {
      final response = await api.rejectDevice(employeeId, deviceId);
      if ((response.isSuccess ?? true) == true) {
        await loadDevices();
      } else {
        safeEmit(
          const AdminPendingDevicesState.error('admin.devices.rejectFailed'),
        );
      }
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      safeEmit(AdminPendingDevicesState.error(failure.messageKey));
    }
  }

  AdminPendingDevicesCubit({required this.api})
    : super(const AdminPendingDevicesState.initial());

  final AdminApiService api;

  Future<void> loadDevices() async {
    emit(const AdminPendingDevicesState.loading());
    try {
      final response = await api.getPendingDevices();
      if (response.isSuccess == true) {
        safeEmit(AdminPendingDevicesState.success(response.value));
      } else {
        safeEmit(
          const AdminPendingDevicesState.error('admin.devices.loadFailed'),
        );
      }
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      safeEmit(AdminPendingDevicesState.error(failure.messageKey));
    }
  }

  Future<void> approveDevice(String employeeId, String deviceId) async {
    emit(const AdminPendingDevicesState.loading());
    try {
      final response = await api.approveDevice(employeeId, {
        'deviceId': deviceId,
        'isActive': true,
      });
      if ((response.isSuccess ?? true) == true) {
        await loadDevices();
      } else {
        safeEmit(
          const AdminPendingDevicesState.error('admin.devices.approveFailed'),
        );
      }
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      safeEmit(AdminPendingDevicesState.error(failure.messageKey));
    }
  }
}
