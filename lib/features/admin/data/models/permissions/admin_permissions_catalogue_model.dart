import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_permissions_catalogue_model.freezed.dart';
part 'admin_permissions_catalogue_model.g.dart';

@freezed
class AdminPermissionsCatalogueModel with _$AdminPermissionsCatalogueModel {
  const factory AdminPermissionsCatalogueModel({
    required List<String> catalogue,
    required Map<String, List<String>> roles,
  }) = _AdminPermissionsCatalogueModel;

  factory AdminPermissionsCatalogueModel.fromJson(Map<String, dynamic> json) =>
      _$AdminPermissionsCatalogueModelFromJson(json);
}
