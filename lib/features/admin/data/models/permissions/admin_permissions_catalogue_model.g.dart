// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_permissions_catalogue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminPermissionsCatalogueModelImpl
_$$AdminPermissionsCatalogueModelImplFromJson(Map<String, dynamic> json) =>
    _$AdminPermissionsCatalogueModelImpl(
      catalogue: (json['catalogue'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      roles: (json['roles'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$$AdminPermissionsCatalogueModelImplToJson(
  _$AdminPermissionsCatalogueModelImpl instance,
) => <String, dynamic>{
  'catalogue': instance.catalogue,
  'roles': instance.roles,
};
