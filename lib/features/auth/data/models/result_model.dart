import 'package:json_annotation/json_annotation.dart';

part 'result_model.g.dart';

@JsonSerializable()
class ResultModel {
  const ResultModel({this.isSuccess, this.successMessage, this.errors});

  final bool? isSuccess;
  final String? successMessage;
  final List<String>? errors;

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelToJson(this);
}
