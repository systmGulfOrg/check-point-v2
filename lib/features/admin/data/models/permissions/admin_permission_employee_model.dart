import 'package:freezed_annotation/freezed_annotation.dart';

import 'admin_permission_user_model.dart';

part 'admin_permission_employee_model.freezed.dart';
part 'admin_permission_employee_model.g.dart';

@freezed
class AdminPermissionEmployeeModel with _$AdminPermissionEmployeeModel {
  const factory AdminPermissionEmployeeModel({
    required String id,
    required String name,
    String? email,
    String? employeeCode,
    String? imageUrl,
    required AdminPermissionUserModel user,
  }) = _AdminPermissionEmployeeModel;

  factory AdminPermissionEmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$AdminPermissionEmployeeModelFromJson(json);

  const AdminPermissionEmployeeModel._();

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    final value = parts
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();
    return value.isEmpty ? '?' : value;
  }
}
