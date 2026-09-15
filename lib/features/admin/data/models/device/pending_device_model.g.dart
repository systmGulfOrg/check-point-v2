// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PendingDeviceModelImpl _$$PendingDeviceModelImplFromJson(
  Map<String, dynamic> json,
) => _$PendingDeviceModelImpl(
  id: json['id'] as String,
  deviceId: json['deviceId'] as String,
  deviceModel: json['deviceModel'] as String?,
  osVersion: json['osVersion'] as String?,
  isActive: json['isActive'] as bool,
  employeeId: json['employeeId'] as String,
  employeeName: json['employeeName'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$PendingDeviceModelImplToJson(
  _$PendingDeviceModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'deviceId': instance.deviceId,
  'deviceModel': instance.deviceModel,
  'osVersion': instance.osVersion,
  'isActive': instance.isActive,
  'employeeId': instance.employeeId,
  'employeeName': instance.employeeName,
  'createdAt': instance.createdAt.toIso8601String(),
};

_$PendingDevicesResponseModelImpl _$$PendingDevicesResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$PendingDevicesResponseModelImpl(
  isSuccess: json['isSuccess'] as bool,
  status: (json['status'] as num).toInt(),
  value: (json['value'] as List<dynamic>)
      .map((e) => PendingDeviceModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  correlationId: json['correlationId'] as String,
);

Map<String, dynamic> _$$PendingDevicesResponseModelImplToJson(
  _$PendingDevicesResponseModelImpl instance,
) => <String, dynamic>{
  'isSuccess': instance.isSuccess,
  'status': instance.status,
  'value': instance.value,
  'correlationId': instance.correlationId,
};
