import 'package:json_annotation/json_annotation.dart';

import 'login_response_model.dart';

part 'login_result_model.g.dart';

@JsonSerializable()
class LoginResultModel {
  const LoginResultModel({
    this.value,
    this.isSuccess,
    this.successMessage,
    this.errors,
  });

  final LoginResponseModel? value;
  final bool? isSuccess;
  final String? successMessage;
  final List<String>? errors;

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultModelToJson(this);
}
