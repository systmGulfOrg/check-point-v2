import 'package:json_annotation/json_annotation.dart';

part 'feedback_statuses_response_model.g.dart';

@JsonSerializable()
class FeedbackStatusesResponseModel {
  const FeedbackStatusesResponseModel({
    this.value,
    this.isSuccess,
    this.successMessage,
  });

  final List<String>? value;
  final bool? isSuccess;
  final String? successMessage;

  factory FeedbackStatusesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackStatusesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackStatusesResponseModelToJson(this);
}
