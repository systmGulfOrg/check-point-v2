import 'package:json_annotation/json_annotation.dart';

import 'trial_signup_model.dart';

part 'trial_signup_result_model.g.dart';

@JsonSerializable()
class TrialSignupResultModel {
  const TrialSignupResultModel({
    this.value,
    this.isSuccess,
    this.successMessage,
    this.errors,
  });

  final TrialSignupModel? value;
  final bool? isSuccess;
  final String? successMessage;
  final List<String>? errors;

  factory TrialSignupResultModel.fromJson(Map<String, dynamic> json) =>
      _$TrialSignupResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrialSignupResultModelToJson(this);
}
