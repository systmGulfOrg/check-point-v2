// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_exchange_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointsExchangeRequestBodyImpl _$$PointsExchangeRequestBodyImplFromJson(
  Map<String, dynamic> json,
) => _$PointsExchangeRequestBodyImpl(
  target: json['target'] as String,
  quantity: (json['quantity'] as num).toInt(),
  idempotencyKey: json['idempotencyKey'] as String,
  employeeId: json['employeeId'] as String?,
);

Map<String, dynamic> _$$PointsExchangeRequestBodyImplToJson(
  _$PointsExchangeRequestBodyImpl instance,
) => <String, dynamic>{
  'target': instance.target,
  'quantity': instance.quantity,
  'idempotencyKey': instance.idempotencyKey,
  'employeeId': instance.employeeId,
};

_$PointsExchangeResultModelImpl _$$PointsExchangeResultModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsExchangeResultModelImpl(
  success: json['success'] as bool,
  exchangeId: json['exchangeId'] as String,
  amountIn: (json['amountIn'] as num).toInt(),
  amountOut: (json['amountOut'] as num).toInt(),
  rate: (json['rate'] as num).toDouble(),
  idempotentReplay: json['idempotentReplay'] as bool? ?? false,
);

Map<String, dynamic> _$$PointsExchangeResultModelImplToJson(
  _$PointsExchangeResultModelImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'exchangeId': instance.exchangeId,
  'amountIn': instance.amountIn,
  'amountOut': instance.amountOut,
  'rate': instance.rate,
  'idempotentReplay': instance.idempotentReplay,
};

_$PointsExchangeResponseModelImpl _$$PointsExchangeResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsExchangeResponseModelImpl(
  value: json['value'] == null
      ? null
      : PointsExchangeResultModel.fromJson(
          json['value'] as Map<String, dynamic>,
        ),
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$$PointsExchangeResponseModelImplToJson(
  _$PointsExchangeResponseModelImpl instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
  'errors': instance.errors,
};
