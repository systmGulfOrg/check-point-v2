import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/device/pending_device_model.dart';

part 'admin_pending_devices_state.freezed.dart';

@freezed
class AdminPendingDevicesState with _$AdminPendingDevicesState {
  const factory AdminPendingDevicesState.initial() = _Initial;
  const factory AdminPendingDevicesState.loading() = _Loading;
  const factory AdminPendingDevicesState.success(
    List<PendingDeviceModel> devices,
  ) = _Success;
  const factory AdminPendingDevicesState.error(String message) = _Error;
}
