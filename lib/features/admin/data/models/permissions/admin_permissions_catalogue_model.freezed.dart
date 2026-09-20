// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_permissions_catalogue_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AdminPermissionsCatalogueModel _$AdminPermissionsCatalogueModelFromJson(
  Map<String, dynamic> json,
) {
  return _AdminPermissionsCatalogueModel.fromJson(json);
}

/// @nodoc
mixin _$AdminPermissionsCatalogueModel {
  List<String> get catalogue => throw _privateConstructorUsedError;
  Map<String, List<String>> get roles => throw _privateConstructorUsedError;

  /// Serializes this AdminPermissionsCatalogueModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminPermissionsCatalogueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminPermissionsCatalogueModelCopyWith<AdminPermissionsCatalogueModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminPermissionsCatalogueModelCopyWith<$Res> {
  factory $AdminPermissionsCatalogueModelCopyWith(
    AdminPermissionsCatalogueModel value,
    $Res Function(AdminPermissionsCatalogueModel) then,
  ) =
      _$AdminPermissionsCatalogueModelCopyWithImpl<
        $Res,
        AdminPermissionsCatalogueModel
      >;
  @useResult
  $Res call({List<String> catalogue, Map<String, List<String>> roles});
}

/// @nodoc
class _$AdminPermissionsCatalogueModelCopyWithImpl<
  $Res,
  $Val extends AdminPermissionsCatalogueModel
>
    implements $AdminPermissionsCatalogueModelCopyWith<$Res> {
  _$AdminPermissionsCatalogueModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminPermissionsCatalogueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? catalogue = null, Object? roles = null}) {
    return _then(
      _value.copyWith(
            catalogue: null == catalogue
                ? _value.catalogue
                : catalogue // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            roles: null == roles
                ? _value.roles
                : roles // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminPermissionsCatalogueModelImplCopyWith<$Res>
    implements $AdminPermissionsCatalogueModelCopyWith<$Res> {
  factory _$$AdminPermissionsCatalogueModelImplCopyWith(
    _$AdminPermissionsCatalogueModelImpl value,
    $Res Function(_$AdminPermissionsCatalogueModelImpl) then,
  ) = __$$AdminPermissionsCatalogueModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> catalogue, Map<String, List<String>> roles});
}

/// @nodoc
class __$$AdminPermissionsCatalogueModelImplCopyWithImpl<$Res>
    extends
        _$AdminPermissionsCatalogueModelCopyWithImpl<
          $Res,
          _$AdminPermissionsCatalogueModelImpl
        >
    implements _$$AdminPermissionsCatalogueModelImplCopyWith<$Res> {
  __$$AdminPermissionsCatalogueModelImplCopyWithImpl(
    _$AdminPermissionsCatalogueModelImpl _value,
    $Res Function(_$AdminPermissionsCatalogueModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminPermissionsCatalogueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? catalogue = null, Object? roles = null}) {
    return _then(
      _$AdminPermissionsCatalogueModelImpl(
        catalogue: null == catalogue
            ? _value._catalogue
            : catalogue // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        roles: null == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminPermissionsCatalogueModelImpl
    implements _AdminPermissionsCatalogueModel {
  const _$AdminPermissionsCatalogueModelImpl({
    required final List<String> catalogue,
    required final Map<String, List<String>> roles,
  }) : _catalogue = catalogue,
       _roles = roles;

  factory _$AdminPermissionsCatalogueModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AdminPermissionsCatalogueModelImplFromJson(json);

  final List<String> _catalogue;
  @override
  List<String> get catalogue {
    if (_catalogue is EqualUnmodifiableListView) return _catalogue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_catalogue);
  }

  final Map<String, List<String>> _roles;
  @override
  Map<String, List<String>> get roles {
    if (_roles is EqualUnmodifiableMapView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_roles);
  }

  @override
  String toString() {
    return 'AdminPermissionsCatalogueModel(catalogue: $catalogue, roles: $roles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminPermissionsCatalogueModelImpl &&
            const DeepCollectionEquality().equals(
              other._catalogue,
              _catalogue,
            ) &&
            const DeepCollectionEquality().equals(other._roles, _roles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_catalogue),
    const DeepCollectionEquality().hash(_roles),
  );

  /// Create a copy of AdminPermissionsCatalogueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminPermissionsCatalogueModelImplCopyWith<
    _$AdminPermissionsCatalogueModelImpl
  >
  get copyWith =>
      __$$AdminPermissionsCatalogueModelImplCopyWithImpl<
        _$AdminPermissionsCatalogueModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminPermissionsCatalogueModelImplToJson(this);
  }
}

abstract class _AdminPermissionsCatalogueModel
    implements AdminPermissionsCatalogueModel {
  const factory _AdminPermissionsCatalogueModel({
    required final List<String> catalogue,
    required final Map<String, List<String>> roles,
  }) = _$AdminPermissionsCatalogueModelImpl;

  factory _AdminPermissionsCatalogueModel.fromJson(Map<String, dynamic> json) =
      _$AdminPermissionsCatalogueModelImpl.fromJson;

  @override
  List<String> get catalogue;
  @override
  Map<String, List<String>> get roles;

  /// Create a copy of AdminPermissionsCatalogueModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminPermissionsCatalogueModelImplCopyWith<
    _$AdminPermissionsCatalogueModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
