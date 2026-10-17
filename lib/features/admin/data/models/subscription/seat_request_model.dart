import 'package:json_annotation/json_annotation.dart';

part 'seat_request_model.g.dart';

@JsonSerializable()
class SeatRequestModel {
  const SeatRequestModel({
    this.id,
    this.requestedByName,
    this.currentLimit,
    this.requestedLimit,
    this.approvedLimit,
    this.reason,
    this.status,
    this.reviewNote,
    this.reviewedAt,
    this.createdAt,
  });

  final String? id;
  final String? requestedByName;
  final int? currentLimit;
  final int? requestedLimit;
  final int? approvedLimit;
  final String? reason;
  final String? status;
  final String? reviewNote;
  final DateTime? reviewedAt;
  final DateTime? createdAt;

  factory SeatRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SeatRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatRequestModelToJson(this);
}

@JsonSerializable()
class SeatRequestResultModel {
  const SeatRequestResultModel({this.value, this.isSuccess, this.errors});

  final SeatRequestModel? value;
  final bool? isSuccess;
  final List<String>? errors;

  factory SeatRequestResultModel.fromJson(Map<String, dynamic> json) =>
      _$SeatRequestResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatRequestResultModelToJson(this);
}

@JsonSerializable()
class CreateSeatRequestBody {
  const CreateSeatRequestBody({required this.requestedLimit, this.reason});

  final int requestedLimit;
  final String? reason;

  factory CreateSeatRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateSeatRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSeatRequestBodyToJson(this);
}
