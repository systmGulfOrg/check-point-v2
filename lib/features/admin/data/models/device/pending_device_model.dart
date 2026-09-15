import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_device_model.freezed.dart';
part 'pending_device_model.g.dart';

@freezed
class PendingDeviceModel with _$PendingDeviceModel {
  const factory PendingDeviceModel({
    required String id,
    required String deviceId,
    String? deviceModel,
    String? osVersion,
    required bool isActive,
    required String employeeId,
    String? employeeName,
    required DateTime createdAt,
  }) = _PendingDeviceModel;

  factory PendingDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$PendingDeviceModelFromJson(json);
}

@freezed
class PendingDevicesResponseModel with _$PendingDevicesResponseModel {
  const factory PendingDevicesResponseModel({
    required bool isSuccess,
    required int status,
    required List<PendingDeviceModel> value,
    required String correlationId,
  }) = _PendingDevicesResponseModel;

  factory PendingDevicesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PendingDevicesResponseModelFromJson(json);
}
