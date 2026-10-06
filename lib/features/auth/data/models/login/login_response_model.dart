// ignore_for_file: invalid_annotation_target
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class AuthUserModel {
  const AuthUserModel({
    this.id,
    this.userName,
    this.role,
    this.roles,
    this.employeeId,
    this.branchId,
    this.permissions,
  });

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'userName')
  final String? userName;

  @JsonKey(name: 'role')
  final String? role;

  @JsonKey(name: 'roles')
  final List<String>? roles;

  @JsonKey(name: 'employeeId')
  final String? employeeId;

  @JsonKey(name: 'branchId')
  final dynamic branchId;

  @JsonKey(name: 'permissions')
  final List<String>? permissions;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserModelToJson(this);
}

@JsonSerializable()
class LoginResponseModel {
  const LoginResponseModel({
    this.id,
    this.userName,
    this.name,
    this.role,
    this.roles,
    this.permissions,
    this.token,
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.user,
    this.branchId,
    this.branchName,
    this.employeeId,
  });

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'employeeId')
  final String? employeeId;

  @JsonKey(name: 'userName')
  final String? userName;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'role')
  final String? role;

  @JsonKey(name: 'roles')
  final List<String>? roles;

  @JsonKey(name: 'permissions')
  final List<String>? permissions;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'accessToken')
  final String? accessToken;

  @JsonKey(name: 'refreshToken')
  final String? refreshToken;

  @JsonKey(name: 'expiresIn')
  final dynamic expiresIn;

  @JsonKey(name: 'user')
  final AuthUserModel? user;

  @JsonKey(name: 'branchId')
  final dynamic branchId;

  @JsonKey(name: 'branchName')
  final String? branchName;

  String? get effectiveToken => accessToken ?? token;

  String? get effectiveRefreshToken => refreshToken;

  String? get effectiveUserId => user?.id ?? id;

  String? get effectiveEmployeeId => user?.employeeId ?? employeeId;

  String? get effectiveUserName => user?.userName ?? userName ?? name;

  List<String> get allRoles {
    final set = <String>{};
    final effectiveRole = user?.role ?? role;
    if (effectiveRole != null && effectiveRole.trim().isNotEmpty) {
      set.add(effectiveRole.trim());
    }
    final effectiveRoles = user?.roles ?? roles;
    if (effectiveRoles != null) {
      for (final r in effectiveRoles) {
        if (r.trim().isNotEmpty) set.add(r.trim());
      }
    }
    return set.toList();
  }

  List<String> get allPermissions => user?.permissions ?? permissions ?? const [];

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
