import 'package:freezed_annotation/freezed_annotation.dart';

part 'points_exchange_model.freezed.dart';
part 'points_exchange_model.g.dart';

@freezed
class PointsExchangeRequestBody with _$PointsExchangeRequestBody {
  const factory PointsExchangeRequestBody({
    required String target,
    required int quantity,
    required String idempotencyKey,
    String? employeeId,
  }) = _PointsExchangeRequestBody;

  factory PointsExchangeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PointsExchangeRequestBodyFromJson(json);
}

@freezed
class PointsExchangeResultModel with _$PointsExchangeResultModel {
  const factory PointsExchangeResultModel({
    required bool success,
    required String exchangeId,
    required int amountIn,
    required int amountOut,
    required double rate,
    @Default(false) bool idempotentReplay,
  }) = _PointsExchangeResultModel;

  factory PointsExchangeResultModel.fromJson(Map<String, dynamic> json) =>
      _$PointsExchangeResultModelFromJson(json);
}

@freezed
class PointsExchangeResponseModel with _$PointsExchangeResponseModel {
  const factory PointsExchangeResponseModel({
    PointsExchangeResultModel? value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  }) = _PointsExchangeResponseModel;

  factory PointsExchangeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PointsExchangeResponseModelFromJson(json);
}
