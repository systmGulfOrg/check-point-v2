import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  const LoginResponseModel({
    this.id,
    this.userName,
    this.name,
    this.role,
    this.roles,
    this.token,
    this.branchId,
    this.branchName,
  });

  final String? id;
  final String? userName;
  final String? name;
  final String? role;
  final List<String>? roles;
  final String? token;
  final int? branchId;
  final String? branchName;

  List<String> get allRoles {
    final set = <String>{};
    if (role != null && role!.trim().isNotEmpty) {
      set.add(role!.trim());
    }
    if (roles != null) {
      for (final r in roles!) {
        if (r.trim().isNotEmpty) set.add(r.trim());
      }
    }
    return set.toList();
  }

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
