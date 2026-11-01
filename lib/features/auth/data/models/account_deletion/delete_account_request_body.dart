import 'package:json_annotation/json_annotation.dart';

part 'delete_account_request_body.g.dart';

@JsonSerializable(createFactory: false)
class DeleteAccountRequestBody {
  const DeleteAccountRequestBody({required this.password});

  final String password;

  Map<String, dynamic> toJson() => _$DeleteAccountRequestBodyToJson(this);
}
