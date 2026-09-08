import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  const LoginResponseModel({
    this.id,
    this.userName,
    this.name,
    this.roles,
    this.token,
    this.branchId,
    this.branchName,
  });

  final String? id;
  final String? userName;
  final String? name;
  final List<String>? roles;
  final String? token;
  final int? branchId;
  final String? branchName;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
