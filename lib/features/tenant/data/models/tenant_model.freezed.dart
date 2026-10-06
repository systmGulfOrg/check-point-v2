// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TenantModel _$TenantModelFromJson(Map<String, dynamic> json) {
  return _TenantModel.fromJson(json);
}

/// @nodoc
mixin _$TenantModel {
  @JsonKey(name: 'tenantId')
  String? get tenantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tenantCode')
  String? get tenantCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug')
  String? get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'companyName')
  String? get companyName => throw _privateConstructorUsedError;
  @JsonKey(name: 'logoUrl')
  String? get logoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'baseUrl')
  String? get baseUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'isActive')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'roles')
  List<String>? get roles => throw _privateConstructorUsedError;
  @JsonKey(name: 'orgModel')
  String? get orgModel => throw _privateConstructorUsedError;
  @JsonKey(name: 'features')
  Map<String, dynamic>? get features => throw _privateConstructorUsedError;

  /// Serializes this TenantModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TenantModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TenantModelCopyWith<TenantModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantModelCopyWith<$Res> {
  factory $TenantModelCopyWith(
    TenantModel value,
    $Res Function(TenantModel) then,
  ) = _$TenantModelCopyWithImpl<$Res, TenantModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'tenantId') String? tenantId,
    @JsonKey(name: 'tenantCode') String? tenantCode,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'companyName') String? companyName,
    @JsonKey(name: 'logoUrl') String? logoUrl,
    @JsonKey(name: 'baseUrl') String? baseUrl,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'isActive') bool isActive,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'roles') List<String>? roles,
    @JsonKey(name: 'orgModel') String? orgModel,
    @JsonKey(name: 'features') Map<String, dynamic>? features,
  });
}

/// @nodoc
class _$TenantModelCopyWithImpl<$Res, $Val extends TenantModel>
    implements $TenantModelCopyWith<$Res> {
  _$TenantModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TenantModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenantId = freezed,
    Object? tenantCode = freezed,
    Object? slug = freezed,
    Object? name = freezed,
    Object? companyName = freezed,
    Object? logoUrl = freezed,
    Object? baseUrl = freezed,
    Object? status = freezed,
    Object? isActive = null,
    Object? description = freezed,
    Object? roles = freezed,
    Object? orgModel = freezed,
    Object? features = freezed,
  }) {
    return _then(
      _value.copyWith(
            tenantId: freezed == tenantId
                ? _value.tenantId
                : tenantId // ignore: cast_nullable_to_non_nullable
                      as String?,
            tenantCode: freezed == tenantCode
                ? _value.tenantCode
                : tenantCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            slug: freezed == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            companyName: freezed == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            baseUrl: freezed == baseUrl
                ? _value.baseUrl
                : baseUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            roles: freezed == roles
                ? _value.roles
                : roles // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            orgModel: freezed == orgModel
                ? _value.orgModel
                : orgModel // ignore: cast_nullable_to_non_nullable
                      as String?,
            features: freezed == features
                ? _value.features
                : features // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TenantModelImplCopyWith<$Res>
    implements $TenantModelCopyWith<$Res> {
  factory _$$TenantModelImplCopyWith(
    _$TenantModelImpl value,
    $Res Function(_$TenantModelImpl) then,
  ) = __$$TenantModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tenantId') String? tenantId,
    @JsonKey(name: 'tenantCode') String? tenantCode,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'companyName') String? companyName,
    @JsonKey(name: 'logoUrl') String? logoUrl,
    @JsonKey(name: 'baseUrl') String? baseUrl,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'isActive') bool isActive,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'roles') List<String>? roles,
    @JsonKey(name: 'orgModel') String? orgModel,
    @JsonKey(name: 'features') Map<String, dynamic>? features,
  });
}

/// @nodoc
class __$$TenantModelImplCopyWithImpl<$Res>
    extends _$TenantModelCopyWithImpl<$Res, _$TenantModelImpl>
    implements _$$TenantModelImplCopyWith<$Res> {
  __$$TenantModelImplCopyWithImpl(
    _$TenantModelImpl _value,
    $Res Function(_$TenantModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TenantModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenantId = freezed,
    Object? tenantCode = freezed,
    Object? slug = freezed,
    Object? name = freezed,
    Object? companyName = freezed,
    Object? logoUrl = freezed,
    Object? baseUrl = freezed,
    Object? status = freezed,
    Object? isActive = null,
    Object? description = freezed,
    Object? roles = freezed,
    Object? orgModel = freezed,
    Object? features = freezed,
  }) {
    return _then(
      _$TenantModelImpl(
        tenantId: freezed == tenantId
            ? _value.tenantId
            : tenantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        tenantCode: freezed == tenantCode
            ? _value.tenantCode
            : tenantCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        slug: freezed == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyName: freezed == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        baseUrl: freezed == baseUrl
            ? _value.baseUrl
            : baseUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        roles: freezed == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        orgModel: freezed == orgModel
            ? _value.orgModel
            : orgModel // ignore: cast_nullable_to_non_nullable
                  as String?,
        features: freezed == features
            ? _value._features
            : features // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TenantModelImpl implements _TenantModel {
  const _$TenantModelImpl({
    @JsonKey(name: 'tenantId') this.tenantId,
    @JsonKey(name: 'tenantCode') this.tenantCode,
    @JsonKey(name: 'slug') this.slug,
    @JsonKey(name: 'name') this.name,
    @JsonKey(name: 'companyName') this.companyName,
    @JsonKey(name: 'logoUrl') this.logoUrl,
    @JsonKey(name: 'baseUrl') this.baseUrl,
    @JsonKey(name: 'status') this.status,
    @JsonKey(name: 'isActive') this.isActive = true,
    @JsonKey(name: 'description') this.description,
    @JsonKey(name: 'roles') final List<String>? roles,
    @JsonKey(name: 'orgModel') this.orgModel,
    @JsonKey(name: 'features') final Map<String, dynamic>? features,
  }) : _roles = roles,
       _features = features;

  factory _$TenantModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenantModelImplFromJson(json);

  @override
  @JsonKey(name: 'tenantId')
  final String? tenantId;
  @override
  @JsonKey(name: 'tenantCode')
  final String? tenantCode;
  @override
  @JsonKey(name: 'slug')
  final String? slug;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'companyName')
  final String? companyName;
  @override
  @JsonKey(name: 'logoUrl')
  final String? logoUrl;
  @override
  @JsonKey(name: 'baseUrl')
  final String? baseUrl;
  @override
  @JsonKey(name: 'status')
  final String? status;
  @override
  @JsonKey(name: 'isActive')
  final bool isActive;
  @override
  @JsonKey(name: 'description')
  final String? description;
  final List<String>? _roles;
  @override
  @JsonKey(name: 'roles')
  List<String>? get roles {
    final value = _roles;
    if (value == null) return null;
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'orgModel')
  final String? orgModel;
  final Map<String, dynamic>? _features;
  @override
  @JsonKey(name: 'features')
  Map<String, dynamic>? get features {
    final value = _features;
    if (value == null) return null;
    if (_features is EqualUnmodifiableMapView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'TenantModel(tenantId: $tenantId, tenantCode: $tenantCode, slug: $slug, name: $name, companyName: $companyName, logoUrl: $logoUrl, baseUrl: $baseUrl, status: $status, isActive: $isActive, description: $description, roles: $roles, orgModel: $orgModel, features: $features)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantModelImpl &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.tenantCode, tenantCode) ||
                other.tenantCode == tenantCode) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.orgModel, orgModel) ||
                other.orgModel == orgModel) &&
            const DeepCollectionEquality().equals(other._features, _features));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tenantId,
    tenantCode,
    slug,
    name,
    companyName,
    logoUrl,
    baseUrl,
    status,
    isActive,
    description,
    const DeepCollectionEquality().hash(_roles),
    orgModel,
    const DeepCollectionEquality().hash(_features),
  );

  /// Create a copy of TenantModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantModelImplCopyWith<_$TenantModelImpl> get copyWith =>
      __$$TenantModelImplCopyWithImpl<_$TenantModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TenantModelImplToJson(this);
  }
}

abstract class _TenantModel implements TenantModel {
  const factory _TenantModel({
    @JsonKey(name: 'tenantId') final String? tenantId,
    @JsonKey(name: 'tenantCode') final String? tenantCode,
    @JsonKey(name: 'slug') final String? slug,
    @JsonKey(name: 'name') final String? name,
    @JsonKey(name: 'companyName') final String? companyName,
    @JsonKey(name: 'logoUrl') final String? logoUrl,
    @JsonKey(name: 'baseUrl') final String? baseUrl,
    @JsonKey(name: 'status') final String? status,
    @JsonKey(name: 'isActive') final bool isActive,
    @JsonKey(name: 'description') final String? description,
    @JsonKey(name: 'roles') final List<String>? roles,
    @JsonKey(name: 'orgModel') final String? orgModel,
    @JsonKey(name: 'features') final Map<String, dynamic>? features,
  }) = _$TenantModelImpl;

  factory _TenantModel.fromJson(Map<String, dynamic> json) =
      _$TenantModelImpl.fromJson;

  @override
  @JsonKey(name: 'tenantId')
  String? get tenantId;
  @override
  @JsonKey(name: 'tenantCode')
  String? get tenantCode;
  @override
  @JsonKey(name: 'slug')
  String? get slug;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'companyName')
  String? get companyName;
  @override
  @JsonKey(name: 'logoUrl')
  String? get logoUrl;
  @override
  @JsonKey(name: 'baseUrl')
  String? get baseUrl;
  @override
  @JsonKey(name: 'status')
  String? get status;
  @override
  @JsonKey(name: 'isActive')
  bool get isActive;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'roles')
  List<String>? get roles;
  @override
  @JsonKey(name: 'orgModel')
  String? get orgModel;
  @override
  @JsonKey(name: 'features')
  Map<String, dynamic>? get features;

  /// Create a copy of TenantModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantModelImplCopyWith<_$TenantModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TenantLookupResponseModel _$TenantLookupResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _TenantLookupResponseModel.fromJson(json);
}

/// @nodoc
mixin _$TenantLookupResponseModel {
  @JsonKey(name: 'isSuccess')
  bool get isSuccess => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'value')
  TenantModel? get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'successMessage')
  String? get successMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'errors')
  List<dynamic> get errors => throw _privateConstructorUsedError;

  /// Serializes this TenantLookupResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TenantLookupResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TenantLookupResponseModelCopyWith<TenantLookupResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantLookupResponseModelCopyWith<$Res> {
  factory $TenantLookupResponseModelCopyWith(
    TenantLookupResponseModel value,
    $Res Function(TenantLookupResponseModel) then,
  ) = _$TenantLookupResponseModelCopyWithImpl<$Res, TenantLookupResponseModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'isSuccess') bool isSuccess,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'value') TenantModel? value,
    @JsonKey(name: 'successMessage') String? successMessage,
    @JsonKey(name: 'errors') List<dynamic> errors,
  });

  $TenantModelCopyWith<$Res>? get value;
}

/// @nodoc
class _$TenantLookupResponseModelCopyWithImpl<
  $Res,
  $Val extends TenantLookupResponseModel
>
    implements $TenantLookupResponseModelCopyWith<$Res> {
  _$TenantLookupResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TenantLookupResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? status = freezed,
    Object? value = freezed,
    Object? successMessage = freezed,
    Object? errors = null,
  }) {
    return _then(
      _value.copyWith(
            isSuccess: null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int?,
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as TenantModel?,
            successMessage: freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            errors: null == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
          )
          as $Val,
    );
  }

  /// Create a copy of TenantLookupResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TenantModelCopyWith<$Res>? get value {
    if (_value.value == null) {
      return null;
    }

    return $TenantModelCopyWith<$Res>(_value.value!, (value) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TenantLookupResponseModelImplCopyWith<$Res>
    implements $TenantLookupResponseModelCopyWith<$Res> {
  factory _$$TenantLookupResponseModelImplCopyWith(
    _$TenantLookupResponseModelImpl value,
    $Res Function(_$TenantLookupResponseModelImpl) then,
  ) = __$$TenantLookupResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'isSuccess') bool isSuccess,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'value') TenantModel? value,
    @JsonKey(name: 'successMessage') String? successMessage,
    @JsonKey(name: 'errors') List<dynamic> errors,
  });

  @override
  $TenantModelCopyWith<$Res>? get value;
}

/// @nodoc
class __$$TenantLookupResponseModelImplCopyWithImpl<$Res>
    extends
        _$TenantLookupResponseModelCopyWithImpl<
          $Res,
          _$TenantLookupResponseModelImpl
        >
    implements _$$TenantLookupResponseModelImplCopyWith<$Res> {
  __$$TenantLookupResponseModelImplCopyWithImpl(
    _$TenantLookupResponseModelImpl _value,
    $Res Function(_$TenantLookupResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TenantLookupResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? status = freezed,
    Object? value = freezed,
    Object? successMessage = freezed,
    Object? errors = null,
  }) {
    return _then(
      _$TenantLookupResponseModelImpl(
        isSuccess: null == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int?,
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as TenantModel?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        errors: null == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TenantLookupResponseModelImpl implements _TenantLookupResponseModel {
  const _$TenantLookupResponseModelImpl({
    @JsonKey(name: 'isSuccess') this.isSuccess = false,
    @JsonKey(name: 'status') this.status,
    @JsonKey(name: 'value') this.value,
    @JsonKey(name: 'successMessage') this.successMessage,
    @JsonKey(name: 'errors') final List<dynamic> errors = const [],
  }) : _errors = errors;

  factory _$TenantLookupResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenantLookupResponseModelImplFromJson(json);

  @override
  @JsonKey(name: 'isSuccess')
  final bool isSuccess;
  @override
  @JsonKey(name: 'status')
  final int? status;
  @override
  @JsonKey(name: 'value')
  final TenantModel? value;
  @override
  @JsonKey(name: 'successMessage')
  final String? successMessage;
  final List<dynamic> _errors;
  @override
  @JsonKey(name: 'errors')
  List<dynamic> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString() {
    return 'TenantLookupResponseModel(isSuccess: $isSuccess, status: $status, value: $value, successMessage: $successMessage, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantLookupResponseModelImpl &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    isSuccess,
    status,
    value,
    successMessage,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of TenantLookupResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantLookupResponseModelImplCopyWith<_$TenantLookupResponseModelImpl>
  get copyWith =>
      __$$TenantLookupResponseModelImplCopyWithImpl<
        _$TenantLookupResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TenantLookupResponseModelImplToJson(this);
  }
}

abstract class _TenantLookupResponseModel implements TenantLookupResponseModel {
  const factory _TenantLookupResponseModel({
    @JsonKey(name: 'isSuccess') final bool isSuccess,
    @JsonKey(name: 'status') final int? status,
    @JsonKey(name: 'value') final TenantModel? value,
    @JsonKey(name: 'successMessage') final String? successMessage,
    @JsonKey(name: 'errors') final List<dynamic> errors,
  }) = _$TenantLookupResponseModelImpl;

  factory _TenantLookupResponseModel.fromJson(Map<String, dynamic> json) =
      _$TenantLookupResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'isSuccess')
  bool get isSuccess;
  @override
  @JsonKey(name: 'status')
  int? get status;
  @override
  @JsonKey(name: 'value')
  TenantModel? get value;
  @override
  @JsonKey(name: 'successMessage')
  String? get successMessage;
  @override
  @JsonKey(name: 'errors')
  List<dynamic> get errors;

  /// Create a copy of TenantLookupResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantLookupResponseModelImplCopyWith<_$TenantLookupResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
