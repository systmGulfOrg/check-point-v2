import 'package:json_annotation/json_annotation.dart';

part 'reject_account_request_body.g.dart';

@JsonSerializable()
class RejectAccountRequestBody {
  const RejectAccountRequestBody({
    required this.rejectReason,
    this.status = 'Rejected',
  });

  final String status;
  final String rejectReason;

  factory RejectAccountRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RejectAccountRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RejectAccountRequestBodyToJson(this);
}
