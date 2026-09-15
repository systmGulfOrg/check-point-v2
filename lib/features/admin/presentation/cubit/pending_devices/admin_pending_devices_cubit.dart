import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/api_result.dart';
import '../../../data/apis/admin_api_service.dart';
import 'admin_pending_devices_state.dart';
import '../../../../../core/network/api_failure_mapper.dart';

class AdminPendingDevicesCubit extends Cubit<AdminPendingDevicesState> {
  Future<void> rejectDevice(String employeeId, String deviceId) async {
    try {
      final response = await api.rejectDevice(employeeId, deviceId);
      if ((response.isSuccess ?? true) == true) {
        loadDevices();
      } else {
        emit(AdminPendingDevicesState.error('Reject failed'));
      }
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      emit(AdminPendingDevicesState.error(failure.messageKey));
    }
  }
  AdminPendingDevicesCubit({required this.api}) : super(const AdminPendingDevicesState.initial());

  final AdminApiService api;

  Future<void> loadDevices() async {
    emit(const AdminPendingDevicesState.loading());
    try {
      final response = await api.getPendingDevices();
      if ((response.isSuccess ?? true) == true) {
        emit(AdminPendingDevicesState.success(response.value));
      } else {
        emit(AdminPendingDevicesState.error('Failed to load pending devices'));
      }
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      emit(AdminPendingDevicesState.error(failure.messageKey));
    }
  }

  Future<void> approveDevice(String employeeId, String deviceId) async {
    try {
      final response = await api.approveDevice(employeeId, {
        'deviceId': deviceId,
        'isActive': true,
      });
      if ((response.isSuccess ?? true) == true) {
        loadDevices();
      } else {
        emit(AdminPendingDevicesState.error('Approval failed'));
      }
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      emit(AdminPendingDevicesState.error(failure.messageKey));
    }
  }
}
