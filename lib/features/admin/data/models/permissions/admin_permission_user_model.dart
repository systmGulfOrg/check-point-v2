import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_permission_user_model.freezed.dart';
part 'admin_permission_user_model.g.dart';

@freezed
class AdminPermissionUserModel with _$AdminPermissionUserModel {
  const factory AdminPermissionUserModel({
    required String id,
    String? role,
    @Default([]) List<String> roles,
    @Default(true) bool isActive,
    DateTime? lastLoginAt,
    @Default([]) List<String> customPermissions,
    @Default([]) List<String> permissions,
  }) = _AdminPermissionUserModel;

  factory AdminPermissionUserModel.fromJson(Map<String, dynamic> json) =>
      _$AdminPermissionUserModelFromJson(json);

  const AdminPermissionUserModel._();

  List<String> get allRoles =>
      {if (role != null && role!.isNotEmpty) role!, ...roles}.toList();
}
