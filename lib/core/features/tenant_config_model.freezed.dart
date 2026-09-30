// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenant_config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TenantConfigModel _$TenantConfigModelFromJson(Map<String, dynamic> json) {
  return _TenantConfigModel.fromJson(json);
}

/// @nodoc
mixin _$TenantConfigModel {
  String get tenantId => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  List<String> get enabledFeatures => throw _privateConstructorUsedError;
  String? get orgModel => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  String? get locale => throw _privateConstructorUsedError;

  /// Serializes this TenantConfigModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TenantConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TenantConfigModelCopyWith<TenantConfigModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantConfigModelCopyWith<$Res> {
  factory $TenantConfigModelCopyWith(
    TenantConfigModel value,
    $Res Function(TenantConfigModel) then,
  ) = _$TenantConfigModelCopyWithImpl<$Res, TenantConfigModel>;
  @useResult
  $Res call({
    String tenantId,
    String companyName,
    List<String> enabledFeatures,
    String? orgModel,
    String? timezone,
    String? locale,
  });
}

/// @nodoc
class _$TenantConfigModelCopyWithImpl<$Res, $Val extends TenantConfigModel>
    implements $TenantConfigModelCopyWith<$Res> {
  _$TenantConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TenantConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenantId = null,
    Object? companyName = null,
    Object? enabledFeatures = null,
    Object? orgModel = freezed,
    Object? timezone = freezed,
    Object? locale = freezed,
  }) {
    return _then(
      _value.copyWith(
            tenantId: null == tenantId
                ? _value.tenantId
                : tenantId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyName: null == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String,
            enabledFeatures: null == enabledFeatures
                ? _value.enabledFeatures
                : enabledFeatures // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            orgModel: freezed == orgModel
                ? _value.orgModel
                : orgModel // ignore: cast_nullable_to_non_nullable
                      as String?,
            timezone: freezed == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String?,
            locale: freezed == locale
                ? _value.locale
                : locale // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TenantConfigModelImplCopyWith<$Res>
    implements $TenantConfigModelCopyWith<$Res> {
  factory _$$TenantConfigModelImplCopyWith(
    _$TenantConfigModelImpl value,
    $Res Function(_$TenantConfigModelImpl) then,
  ) = __$$TenantConfigModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String tenantId,
    String companyName,
    List<String> enabledFeatures,
    String? orgModel,
    String? timezone,
    String? locale,
  });
}

/// @nodoc
class __$$TenantConfigModelImplCopyWithImpl<$Res>
    extends _$TenantConfigModelCopyWithImpl<$Res, _$TenantConfigModelImpl>
    implements _$$TenantConfigModelImplCopyWith<$Res> {
  __$$TenantConfigModelImplCopyWithImpl(
    _$TenantConfigModelImpl _value,
    $Res Function(_$TenantConfigModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TenantConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenantId = null,
    Object? companyName = null,
    Object? enabledFeatures = null,
    Object? orgModel = freezed,
    Object? timezone = freezed,
    Object? locale = freezed,
  }) {
    return _then(
      _$TenantConfigModelImpl(
        tenantId: null == tenantId
            ? _value.tenantId
            : tenantId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyName: null == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String,
        enabledFeatures: null == enabledFeatures
            ? _value._enabledFeatures
            : enabledFeatures // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        orgModel: freezed == orgModel
            ? _value.orgModel
            : orgModel // ignore: cast_nullable_to_non_nullable
                  as String?,
        timezone: freezed == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String?,
        locale: freezed == locale
            ? _value.locale
            : locale // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TenantConfigModelImpl implements _TenantConfigModel {
  const _$TenantConfigModelImpl({
    required this.tenantId,
    required this.companyName,
    required final List<String> enabledFeatures,
    this.orgModel,
    this.timezone,
    this.locale,
  }) : _enabledFeatures = enabledFeatures;

  factory _$TenantConfigModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenantConfigModelImplFromJson(json);

  @override
  final String tenantId;
  @override
  final String companyName;
  final List<String> _enabledFeatures;
  @override
  List<String> get enabledFeatures {
    if (_enabledFeatures is EqualUnmodifiableListView) return _enabledFeatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_enabledFeatures);
  }

  @override
  final String? orgModel;
  @override
  final String? timezone;
  @override
  final String? locale;

  @override
  String toString() {
    return 'TenantConfigModel(tenantId: $tenantId, companyName: $companyName, enabledFeatures: $enabledFeatures, orgModel: $orgModel, timezone: $timezone, locale: $locale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantConfigModelImpl &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            const DeepCollectionEquality().equals(
              other._enabledFeatures,
              _enabledFeatures,
            ) &&
            (identical(other.orgModel, orgModel) ||
                other.orgModel == orgModel) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.locale, locale) || other.locale == locale));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tenantId,
    companyName,
    const DeepCollectionEquality().hash(_enabledFeatures),
    orgModel,
    timezone,
    locale,
  );

  /// Create a copy of TenantConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantConfigModelImplCopyWith<_$TenantConfigModelImpl> get copyWith =>
      __$$TenantConfigModelImplCopyWithImpl<_$TenantConfigModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TenantConfigModelImplToJson(this);
  }
}

abstract class _TenantConfigModel implements TenantConfigModel {
  const factory _TenantConfigModel({
    required final String tenantId,
    required final String companyName,
    required final List<String> enabledFeatures,
    final String? orgModel,
    final String? timezone,
    final String? locale,
  }) = _$TenantConfigModelImpl;

  factory _TenantConfigModel.fromJson(Map<String, dynamic> json) =
      _$TenantConfigModelImpl.fromJson;

  @override
  String get tenantId;
  @override
  String get companyName;
  @override
  List<String> get enabledFeatures;
  @override
  String? get orgModel;
  @override
  String? get timezone;
  @override
  String? get locale;

  /// Create a copy of TenantConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantConfigModelImplCopyWith<_$TenantConfigModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TenantConfigApiResponse _$TenantConfigApiResponseFromJson(
  Map<String, dynamic> json,
) {
  return _TenantConfigApiResponse.fromJson(json);
}

/// @nodoc
mixin _$TenantConfigApiResponse {
  @JsonKey(name: 'isSuccess')
  bool get isSuccess => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'value')
  TenantConfigModel? get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'successMessage')
  String? get successMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'errors')
  List<dynamic> get errors => throw _privateConstructorUsedError;

  /// Serializes this TenantConfigApiResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TenantConfigApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TenantConfigApiResponseCopyWith<TenantConfigApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantConfigApiResponseCopyWith<$Res> {
  factory $TenantConfigApiResponseCopyWith(
    TenantConfigApiResponse value,
    $Res Function(TenantConfigApiResponse) then,
  ) = _$TenantConfigApiResponseCopyWithImpl<$Res, TenantConfigApiResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'isSuccess') bool isSuccess,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'value') TenantConfigModel? value,
    @JsonKey(name: 'successMessage') String? successMessage,
    @JsonKey(name: 'errors') List<dynamic> errors,
  });

  $TenantConfigModelCopyWith<$Res>? get value;
}

/// @nodoc
class _$TenantConfigApiResponseCopyWithImpl<
  $Res,
  $Val extends TenantConfigApiResponse
>
    implements $TenantConfigApiResponseCopyWith<$Res> {
  _$TenantConfigApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TenantConfigApiResponse
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
                      as TenantConfigModel?,
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

  /// Create a copy of TenantConfigApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TenantConfigModelCopyWith<$Res>? get value {
    if (_value.value == null) {
      return null;
    }

    return $TenantConfigModelCopyWith<$Res>(_value.value!, (value) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TenantConfigApiResponseImplCopyWith<$Res>
    implements $TenantConfigApiResponseCopyWith<$Res> {
  factory _$$TenantConfigApiResponseImplCopyWith(
    _$TenantConfigApiResponseImpl value,
    $Res Function(_$TenantConfigApiResponseImpl) then,
  ) = __$$TenantConfigApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'isSuccess') bool isSuccess,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'value') TenantConfigModel? value,
    @JsonKey(name: 'successMessage') String? successMessage,
    @JsonKey(name: 'errors') List<dynamic> errors,
  });

  @override
  $TenantConfigModelCopyWith<$Res>? get value;
}

/// @nodoc
class __$$TenantConfigApiResponseImplCopyWithImpl<$Res>
    extends
        _$TenantConfigApiResponseCopyWithImpl<
          $Res,
          _$TenantConfigApiResponseImpl
        >
    implements _$$TenantConfigApiResponseImplCopyWith<$Res> {
  __$$TenantConfigApiResponseImplCopyWithImpl(
    _$TenantConfigApiResponseImpl _value,
    $Res Function(_$TenantConfigApiResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TenantConfigApiResponse
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
      _$TenantConfigApiResponseImpl(
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
                  as TenantConfigModel?,
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
class _$TenantConfigApiResponseImpl implements _TenantConfigApiResponse {
  const _$TenantConfigApiResponseImpl({
    @JsonKey(name: 'isSuccess') this.isSuccess = false,
    @JsonKey(name: 'status') this.status,
    @JsonKey(name: 'value') this.value,
    @JsonKey(name: 'successMessage') this.successMessage,
    @JsonKey(name: 'errors') final List<dynamic> errors = const [],
  }) : _errors = errors;

  factory _$TenantConfigApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenantConfigApiResponseImplFromJson(json);

  @override
  @JsonKey(name: 'isSuccess')
  final bool isSuccess;
  @override
  @JsonKey(name: 'status')
  final int? status;
  @override
  @JsonKey(name: 'value')
  final TenantConfigModel? value;
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
    return 'TenantConfigApiResponse(isSuccess: $isSuccess, status: $status, value: $value, successMessage: $successMessage, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantConfigApiResponseImpl &&
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

  /// Create a copy of TenantConfigApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantConfigApiResponseImplCopyWith<_$TenantConfigApiResponseImpl>
  get copyWith =>
      __$$TenantConfigApiResponseImplCopyWithImpl<
        _$TenantConfigApiResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TenantConfigApiResponseImplToJson(this);
  }
}

abstract class _TenantConfigApiResponse implements TenantConfigApiResponse {
  const factory _TenantConfigApiResponse({
    @JsonKey(name: 'isSuccess') final bool isSuccess,
    @JsonKey(name: 'status') final int? status,
    @JsonKey(name: 'value') final TenantConfigModel? value,
    @JsonKey(name: 'successMessage') final String? successMessage,
    @JsonKey(name: 'errors') final List<dynamic> errors,
  }) = _$TenantConfigApiResponseImpl;

  factory _TenantConfigApiResponse.fromJson(Map<String, dynamic> json) =
      _$TenantConfigApiResponseImpl.fromJson;

  @override
  @JsonKey(name: 'isSuccess')
  bool get isSuccess;
  @override
  @JsonKey(name: 'status')
  int? get status;
  @override
  @JsonKey(name: 'value')
  TenantConfigModel? get value;
  @override
  @JsonKey(name: 'successMessage')
  String? get successMessage;
  @override
  @JsonKey(name: 'errors')
  List<dynamic> get errors;

  /// Create a copy of TenantConfigApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantConfigApiResponseImplCopyWith<_$TenantConfigApiResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
