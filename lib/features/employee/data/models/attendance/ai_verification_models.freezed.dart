// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_verification_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AiFaceVerifyRequestBody _$AiFaceVerifyRequestBodyFromJson(
  Map<String, dynamic> json,
) {
  return _AiFaceVerifyRequestBody.fromJson(json);
}

/// @nodoc
mixin _$AiFaceVerifyRequestBody {
  String get employeeId => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;

  /// Serializes this AiFaceVerifyRequestBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiFaceVerifyRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiFaceVerifyRequestBodyCopyWith<AiFaceVerifyRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiFaceVerifyRequestBodyCopyWith<$Res> {
  factory $AiFaceVerifyRequestBodyCopyWith(
    AiFaceVerifyRequestBody value,
    $Res Function(AiFaceVerifyRequestBody) then,
  ) = _$AiFaceVerifyRequestBodyCopyWithImpl<$Res, AiFaceVerifyRequestBody>;
  @useResult
  $Res call({String employeeId, String photoUrl});
}

/// @nodoc
class _$AiFaceVerifyRequestBodyCopyWithImpl<
  $Res,
  $Val extends AiFaceVerifyRequestBody
>
    implements $AiFaceVerifyRequestBodyCopyWith<$Res> {
  _$AiFaceVerifyRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiFaceVerifyRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? employeeId = null, Object? photoUrl = null}) {
    return _then(
      _value.copyWith(
            employeeId: null == employeeId
                ? _value.employeeId
                : employeeId // ignore: cast_nullable_to_non_nullable
                      as String,
            photoUrl: null == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiFaceVerifyRequestBodyImplCopyWith<$Res>
    implements $AiFaceVerifyRequestBodyCopyWith<$Res> {
  factory _$$AiFaceVerifyRequestBodyImplCopyWith(
    _$AiFaceVerifyRequestBodyImpl value,
    $Res Function(_$AiFaceVerifyRequestBodyImpl) then,
  ) = __$$AiFaceVerifyRequestBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String employeeId, String photoUrl});
}

/// @nodoc
class __$$AiFaceVerifyRequestBodyImplCopyWithImpl<$Res>
    extends
        _$AiFaceVerifyRequestBodyCopyWithImpl<
          $Res,
          _$AiFaceVerifyRequestBodyImpl
        >
    implements _$$AiFaceVerifyRequestBodyImplCopyWith<$Res> {
  __$$AiFaceVerifyRequestBodyImplCopyWithImpl(
    _$AiFaceVerifyRequestBodyImpl _value,
    $Res Function(_$AiFaceVerifyRequestBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiFaceVerifyRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? employeeId = null, Object? photoUrl = null}) {
    return _then(
      _$AiFaceVerifyRequestBodyImpl(
        employeeId: null == employeeId
            ? _value.employeeId
            : employeeId // ignore: cast_nullable_to_non_nullable
                  as String,
        photoUrl: null == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiFaceVerifyRequestBodyImpl implements _AiFaceVerifyRequestBody {
  const _$AiFaceVerifyRequestBodyImpl({
    required this.employeeId,
    required this.photoUrl,
  });

  factory _$AiFaceVerifyRequestBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiFaceVerifyRequestBodyImplFromJson(json);

  @override
  final String employeeId;
  @override
  final String photoUrl;

  @override
  String toString() {
    return 'AiFaceVerifyRequestBody(employeeId: $employeeId, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiFaceVerifyRequestBodyImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, employeeId, photoUrl);

  /// Create a copy of AiFaceVerifyRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiFaceVerifyRequestBodyImplCopyWith<_$AiFaceVerifyRequestBodyImpl>
  get copyWith =>
      __$$AiFaceVerifyRequestBodyImplCopyWithImpl<
        _$AiFaceVerifyRequestBodyImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiFaceVerifyRequestBodyImplToJson(this);
  }
}

abstract class _AiFaceVerifyRequestBody implements AiFaceVerifyRequestBody {
  const factory _AiFaceVerifyRequestBody({
    required final String employeeId,
    required final String photoUrl,
  }) = _$AiFaceVerifyRequestBodyImpl;

  factory _AiFaceVerifyRequestBody.fromJson(Map<String, dynamic> json) =
      _$AiFaceVerifyRequestBodyImpl.fromJson;

  @override
  String get employeeId;
  @override
  String get photoUrl;

  /// Create a copy of AiFaceVerifyRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiFaceVerifyRequestBodyImplCopyWith<_$AiFaceVerifyRequestBodyImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AiFaceVerifyResultModel _$AiFaceVerifyResultModelFromJson(
  Map<String, dynamic> json,
) {
  return _AiFaceVerifyResultModel.fromJson(json);
}

/// @nodoc
mixin _$AiFaceVerifyResultModel {
  @JsonKey(name: 'decision')
  String get decision => throw _privateConstructorUsedError; // ACCEPT, REVIEW, REJECT
  @JsonKey(name: 'matchScore')
  double get matchScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'antiSpoofScore')
  double get antiSpoofScore => throw _privateConstructorUsedError;

  /// Serializes this AiFaceVerifyResultModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiFaceVerifyResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiFaceVerifyResultModelCopyWith<AiFaceVerifyResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiFaceVerifyResultModelCopyWith<$Res> {
  factory $AiFaceVerifyResultModelCopyWith(
    AiFaceVerifyResultModel value,
    $Res Function(AiFaceVerifyResultModel) then,
  ) = _$AiFaceVerifyResultModelCopyWithImpl<$Res, AiFaceVerifyResultModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'decision') String decision,
    @JsonKey(name: 'matchScore') double matchScore,
    @JsonKey(name: 'antiSpoofScore') double antiSpoofScore,
  });
}

/// @nodoc
class _$AiFaceVerifyResultModelCopyWithImpl<
  $Res,
  $Val extends AiFaceVerifyResultModel
>
    implements $AiFaceVerifyResultModelCopyWith<$Res> {
  _$AiFaceVerifyResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiFaceVerifyResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decision = null,
    Object? matchScore = null,
    Object? antiSpoofScore = null,
  }) {
    return _then(
      _value.copyWith(
            decision: null == decision
                ? _value.decision
                : decision // ignore: cast_nullable_to_non_nullable
                      as String,
            matchScore: null == matchScore
                ? _value.matchScore
                : matchScore // ignore: cast_nullable_to_non_nullable
                      as double,
            antiSpoofScore: null == antiSpoofScore
                ? _value.antiSpoofScore
                : antiSpoofScore // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiFaceVerifyResultModelImplCopyWith<$Res>
    implements $AiFaceVerifyResultModelCopyWith<$Res> {
  factory _$$AiFaceVerifyResultModelImplCopyWith(
    _$AiFaceVerifyResultModelImpl value,
    $Res Function(_$AiFaceVerifyResultModelImpl) then,
  ) = __$$AiFaceVerifyResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'decision') String decision,
    @JsonKey(name: 'matchScore') double matchScore,
    @JsonKey(name: 'antiSpoofScore') double antiSpoofScore,
  });
}

/// @nodoc
class __$$AiFaceVerifyResultModelImplCopyWithImpl<$Res>
    extends
        _$AiFaceVerifyResultModelCopyWithImpl<
          $Res,
          _$AiFaceVerifyResultModelImpl
        >
    implements _$$AiFaceVerifyResultModelImplCopyWith<$Res> {
  __$$AiFaceVerifyResultModelImplCopyWithImpl(
    _$AiFaceVerifyResultModelImpl _value,
    $Res Function(_$AiFaceVerifyResultModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiFaceVerifyResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decision = null,
    Object? matchScore = null,
    Object? antiSpoofScore = null,
  }) {
    return _then(
      _$AiFaceVerifyResultModelImpl(
        decision: null == decision
            ? _value.decision
            : decision // ignore: cast_nullable_to_non_nullable
                  as String,
        matchScore: null == matchScore
            ? _value.matchScore
            : matchScore // ignore: cast_nullable_to_non_nullable
                  as double,
        antiSpoofScore: null == antiSpoofScore
            ? _value.antiSpoofScore
            : antiSpoofScore // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiFaceVerifyResultModelImpl implements _AiFaceVerifyResultModel {
  const _$AiFaceVerifyResultModelImpl({
    @JsonKey(name: 'decision') this.decision = 'REVIEW',
    @JsonKey(name: 'matchScore') this.matchScore = 0.0,
    @JsonKey(name: 'antiSpoofScore') this.antiSpoofScore = 0.0,
  });

  factory _$AiFaceVerifyResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiFaceVerifyResultModelImplFromJson(json);

  @override
  @JsonKey(name: 'decision')
  final String decision;
  // ACCEPT, REVIEW, REJECT
  @override
  @JsonKey(name: 'matchScore')
  final double matchScore;
  @override
  @JsonKey(name: 'antiSpoofScore')
  final double antiSpoofScore;

  @override
  String toString() {
    return 'AiFaceVerifyResultModel(decision: $decision, matchScore: $matchScore, antiSpoofScore: $antiSpoofScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiFaceVerifyResultModelImpl &&
            (identical(other.decision, decision) ||
                other.decision == decision) &&
            (identical(other.matchScore, matchScore) ||
                other.matchScore == matchScore) &&
            (identical(other.antiSpoofScore, antiSpoofScore) ||
                other.antiSpoofScore == antiSpoofScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, decision, matchScore, antiSpoofScore);

  /// Create a copy of AiFaceVerifyResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiFaceVerifyResultModelImplCopyWith<_$AiFaceVerifyResultModelImpl>
  get copyWith =>
      __$$AiFaceVerifyResultModelImplCopyWithImpl<
        _$AiFaceVerifyResultModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiFaceVerifyResultModelImplToJson(this);
  }
}

abstract class _AiFaceVerifyResultModel implements AiFaceVerifyResultModel {
  const factory _AiFaceVerifyResultModel({
    @JsonKey(name: 'decision') final String decision,
    @JsonKey(name: 'matchScore') final double matchScore,
    @JsonKey(name: 'antiSpoofScore') final double antiSpoofScore,
  }) = _$AiFaceVerifyResultModelImpl;

  factory _AiFaceVerifyResultModel.fromJson(Map<String, dynamic> json) =
      _$AiFaceVerifyResultModelImpl.fromJson;

  @override
  @JsonKey(name: 'decision')
  String get decision; // ACCEPT, REVIEW, REJECT
  @override
  @JsonKey(name: 'matchScore')
  double get matchScore;
  @override
  @JsonKey(name: 'antiSpoofScore')
  double get antiSpoofScore;

  /// Create a copy of AiFaceVerifyResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiFaceVerifyResultModelImplCopyWith<_$AiFaceVerifyResultModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AiFaceVerifyResponseModel _$AiFaceVerifyResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _AiFaceVerifyResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AiFaceVerifyResponseModel {
  @JsonKey(name: 'isSuccess')
  bool get isSuccess => throw _privateConstructorUsedError;
  @JsonKey(name: 'value')
  AiFaceVerifyResultModel? get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'errorMessage')
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this AiFaceVerifyResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiFaceVerifyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiFaceVerifyResponseModelCopyWith<AiFaceVerifyResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiFaceVerifyResponseModelCopyWith<$Res> {
  factory $AiFaceVerifyResponseModelCopyWith(
    AiFaceVerifyResponseModel value,
    $Res Function(AiFaceVerifyResponseModel) then,
  ) = _$AiFaceVerifyResponseModelCopyWithImpl<$Res, AiFaceVerifyResponseModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'isSuccess') bool isSuccess,
    @JsonKey(name: 'value') AiFaceVerifyResultModel? value,
    @JsonKey(name: 'errorMessage') String? errorMessage,
  });

  $AiFaceVerifyResultModelCopyWith<$Res>? get value;
}

/// @nodoc
class _$AiFaceVerifyResponseModelCopyWithImpl<
  $Res,
  $Val extends AiFaceVerifyResponseModel
>
    implements $AiFaceVerifyResponseModelCopyWith<$Res> {
  _$AiFaceVerifyResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiFaceVerifyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? value = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isSuccess: null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as AiFaceVerifyResultModel?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of AiFaceVerifyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AiFaceVerifyResultModelCopyWith<$Res>? get value {
    if (_value.value == null) {
      return null;
    }

    return $AiFaceVerifyResultModelCopyWith<$Res>(_value.value!, (value) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AiFaceVerifyResponseModelImplCopyWith<$Res>
    implements $AiFaceVerifyResponseModelCopyWith<$Res> {
  factory _$$AiFaceVerifyResponseModelImplCopyWith(
    _$AiFaceVerifyResponseModelImpl value,
    $Res Function(_$AiFaceVerifyResponseModelImpl) then,
  ) = __$$AiFaceVerifyResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'isSuccess') bool isSuccess,
    @JsonKey(name: 'value') AiFaceVerifyResultModel? value,
    @JsonKey(name: 'errorMessage') String? errorMessage,
  });

  @override
  $AiFaceVerifyResultModelCopyWith<$Res>? get value;
}

/// @nodoc
class __$$AiFaceVerifyResponseModelImplCopyWithImpl<$Res>
    extends
        _$AiFaceVerifyResponseModelCopyWithImpl<
          $Res,
          _$AiFaceVerifyResponseModelImpl
        >
    implements _$$AiFaceVerifyResponseModelImplCopyWith<$Res> {
  __$$AiFaceVerifyResponseModelImplCopyWithImpl(
    _$AiFaceVerifyResponseModelImpl _value,
    $Res Function(_$AiFaceVerifyResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiFaceVerifyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? value = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$AiFaceVerifyResponseModelImpl(
        isSuccess: null == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as AiFaceVerifyResultModel?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiFaceVerifyResponseModelImpl implements _AiFaceVerifyResponseModel {
  const _$AiFaceVerifyResponseModelImpl({
    @JsonKey(name: 'isSuccess') this.isSuccess = false,
    @JsonKey(name: 'value') this.value,
    @JsonKey(name: 'errorMessage') this.errorMessage,
  });

  factory _$AiFaceVerifyResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiFaceVerifyResponseModelImplFromJson(json);

  @override
  @JsonKey(name: 'isSuccess')
  final bool isSuccess;
  @override
  @JsonKey(name: 'value')
  final AiFaceVerifyResultModel? value;
  @override
  @JsonKey(name: 'errorMessage')
  final String? errorMessage;

  @override
  String toString() {
    return 'AiFaceVerifyResponseModel(isSuccess: $isSuccess, value: $value, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiFaceVerifyResponseModelImpl &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isSuccess, value, errorMessage);

  /// Create a copy of AiFaceVerifyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiFaceVerifyResponseModelImplCopyWith<_$AiFaceVerifyResponseModelImpl>
  get copyWith =>
      __$$AiFaceVerifyResponseModelImplCopyWithImpl<
        _$AiFaceVerifyResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiFaceVerifyResponseModelImplToJson(this);
  }
}

abstract class _AiFaceVerifyResponseModel implements AiFaceVerifyResponseModel {
  const factory _AiFaceVerifyResponseModel({
    @JsonKey(name: 'isSuccess') final bool isSuccess,
    @JsonKey(name: 'value') final AiFaceVerifyResultModel? value,
    @JsonKey(name: 'errorMessage') final String? errorMessage,
  }) = _$AiFaceVerifyResponseModelImpl;

  factory _AiFaceVerifyResponseModel.fromJson(Map<String, dynamic> json) =
      _$AiFaceVerifyResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'isSuccess')
  bool get isSuccess;
  @override
  @JsonKey(name: 'value')
  AiFaceVerifyResultModel? get value;
  @override
  @JsonKey(name: 'errorMessage')
  String? get errorMessage;

  /// Create a copy of AiFaceVerifyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiFaceVerifyResponseModelImplCopyWith<_$AiFaceVerifyResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AiGpsRiskRequestBody _$AiGpsRiskRequestBodyFromJson(Map<String, dynamic> json) {
  return _AiGpsRiskRequestBody.fromJson(json);
}

/// @nodoc
mixin _$AiGpsRiskRequestBody {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get accuracyM => throw _privateConstructorUsedError;
  @JsonKey(name: 'isMockLocation')
  bool get isMockLocation => throw _privateConstructorUsedError;

  /// Serializes this AiGpsRiskRequestBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiGpsRiskRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiGpsRiskRequestBodyCopyWith<AiGpsRiskRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiGpsRiskRequestBodyCopyWith<$Res> {
  factory $AiGpsRiskRequestBodyCopyWith(
    AiGpsRiskRequestBody value,
    $Res Function(AiGpsRiskRequestBody) then,
  ) = _$AiGpsRiskRequestBodyCopyWithImpl<$Res, AiGpsRiskRequestBody>;
  @useResult
  $Res call({
    double latitude,
    double longitude,
    double accuracyM,
    @JsonKey(name: 'isMockLocation') bool isMockLocation,
  });
}

/// @nodoc
class _$AiGpsRiskRequestBodyCopyWithImpl<
  $Res,
  $Val extends AiGpsRiskRequestBody
>
    implements $AiGpsRiskRequestBodyCopyWith<$Res> {
  _$AiGpsRiskRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiGpsRiskRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracyM = null,
    Object? isMockLocation = null,
  }) {
    return _then(
      _value.copyWith(
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            accuracyM: null == accuracyM
                ? _value.accuracyM
                : accuracyM // ignore: cast_nullable_to_non_nullable
                      as double,
            isMockLocation: null == isMockLocation
                ? _value.isMockLocation
                : isMockLocation // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiGpsRiskRequestBodyImplCopyWith<$Res>
    implements $AiGpsRiskRequestBodyCopyWith<$Res> {
  factory _$$AiGpsRiskRequestBodyImplCopyWith(
    _$AiGpsRiskRequestBodyImpl value,
    $Res Function(_$AiGpsRiskRequestBodyImpl) then,
  ) = __$$AiGpsRiskRequestBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double latitude,
    double longitude,
    double accuracyM,
    @JsonKey(name: 'isMockLocation') bool isMockLocation,
  });
}

/// @nodoc
class __$$AiGpsRiskRequestBodyImplCopyWithImpl<$Res>
    extends _$AiGpsRiskRequestBodyCopyWithImpl<$Res, _$AiGpsRiskRequestBodyImpl>
    implements _$$AiGpsRiskRequestBodyImplCopyWith<$Res> {
  __$$AiGpsRiskRequestBodyImplCopyWithImpl(
    _$AiGpsRiskRequestBodyImpl _value,
    $Res Function(_$AiGpsRiskRequestBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiGpsRiskRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracyM = null,
    Object? isMockLocation = null,
  }) {
    return _then(
      _$AiGpsRiskRequestBodyImpl(
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        accuracyM: null == accuracyM
            ? _value.accuracyM
            : accuracyM // ignore: cast_nullable_to_non_nullable
                  as double,
        isMockLocation: null == isMockLocation
            ? _value.isMockLocation
            : isMockLocation // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiGpsRiskRequestBodyImpl implements _AiGpsRiskRequestBody {
  const _$AiGpsRiskRequestBodyImpl({
    required this.latitude,
    required this.longitude,
    required this.accuracyM,
    @JsonKey(name: 'isMockLocation') this.isMockLocation = false,
  });

  factory _$AiGpsRiskRequestBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiGpsRiskRequestBodyImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double accuracyM;
  @override
  @JsonKey(name: 'isMockLocation')
  final bool isMockLocation;

  @override
  String toString() {
    return 'AiGpsRiskRequestBody(latitude: $latitude, longitude: $longitude, accuracyM: $accuracyM, isMockLocation: $isMockLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiGpsRiskRequestBodyImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracyM, accuracyM) ||
                other.accuracyM == accuracyM) &&
            (identical(other.isMockLocation, isMockLocation) ||
                other.isMockLocation == isMockLocation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, accuracyM, isMockLocation);

  /// Create a copy of AiGpsRiskRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiGpsRiskRequestBodyImplCopyWith<_$AiGpsRiskRequestBodyImpl>
  get copyWith =>
      __$$AiGpsRiskRequestBodyImplCopyWithImpl<_$AiGpsRiskRequestBodyImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AiGpsRiskRequestBodyImplToJson(this);
  }
}

abstract class _AiGpsRiskRequestBody implements AiGpsRiskRequestBody {
  const factory _AiGpsRiskRequestBody({
    required final double latitude,
    required final double longitude,
    required final double accuracyM,
    @JsonKey(name: 'isMockLocation') final bool isMockLocation,
  }) = _$AiGpsRiskRequestBodyImpl;

  factory _AiGpsRiskRequestBody.fromJson(Map<String, dynamic> json) =
      _$AiGpsRiskRequestBodyImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get accuracyM;
  @override
  @JsonKey(name: 'isMockLocation')
  bool get isMockLocation;

  /// Create a copy of AiGpsRiskRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiGpsRiskRequestBodyImplCopyWith<_$AiGpsRiskRequestBodyImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AiGpsRiskResultModel _$AiGpsRiskResultModelFromJson(Map<String, dynamic> json) {
  return _AiGpsRiskResultModel.fromJson(json);
}

/// @nodoc
mixin _$AiGpsRiskResultModel {
  @JsonKey(name: 'riskLevel')
  String get riskLevel => throw _privateConstructorUsedError; // LOW, MEDIUM, HIGH
  @JsonKey(name: 'riskScore')
  double get riskScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'isMockDetected')
  bool get isMockDetected => throw _privateConstructorUsedError;

  /// Serializes this AiGpsRiskResultModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiGpsRiskResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiGpsRiskResultModelCopyWith<AiGpsRiskResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiGpsRiskResultModelCopyWith<$Res> {
  factory $AiGpsRiskResultModelCopyWith(
    AiGpsRiskResultModel value,
    $Res Function(AiGpsRiskResultModel) then,
  ) = _$AiGpsRiskResultModelCopyWithImpl<$Res, AiGpsRiskResultModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'riskLevel') String riskLevel,
    @JsonKey(name: 'riskScore') double riskScore,
    @JsonKey(name: 'isMockDetected') bool isMockDetected,
  });
}

/// @nodoc
class _$AiGpsRiskResultModelCopyWithImpl<
  $Res,
  $Val extends AiGpsRiskResultModel
>
    implements $AiGpsRiskResultModelCopyWith<$Res> {
  _$AiGpsRiskResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiGpsRiskResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? riskLevel = null,
    Object? riskScore = null,
    Object? isMockDetected = null,
  }) {
    return _then(
      _value.copyWith(
            riskLevel: null == riskLevel
                ? _value.riskLevel
                : riskLevel // ignore: cast_nullable_to_non_nullable
                      as String,
            riskScore: null == riskScore
                ? _value.riskScore
                : riskScore // ignore: cast_nullable_to_non_nullable
                      as double,
            isMockDetected: null == isMockDetected
                ? _value.isMockDetected
                : isMockDetected // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiGpsRiskResultModelImplCopyWith<$Res>
    implements $AiGpsRiskResultModelCopyWith<$Res> {
  factory _$$AiGpsRiskResultModelImplCopyWith(
    _$AiGpsRiskResultModelImpl value,
    $Res Function(_$AiGpsRiskResultModelImpl) then,
  ) = __$$AiGpsRiskResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'riskLevel') String riskLevel,
    @JsonKey(name: 'riskScore') double riskScore,
    @JsonKey(name: 'isMockDetected') bool isMockDetected,
  });
}

/// @nodoc
class __$$AiGpsRiskResultModelImplCopyWithImpl<$Res>
    extends _$AiGpsRiskResultModelCopyWithImpl<$Res, _$AiGpsRiskResultModelImpl>
    implements _$$AiGpsRiskResultModelImplCopyWith<$Res> {
  __$$AiGpsRiskResultModelImplCopyWithImpl(
    _$AiGpsRiskResultModelImpl _value,
    $Res Function(_$AiGpsRiskResultModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiGpsRiskResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? riskLevel = null,
    Object? riskScore = null,
    Object? isMockDetected = null,
  }) {
    return _then(
      _$AiGpsRiskResultModelImpl(
        riskLevel: null == riskLevel
            ? _value.riskLevel
            : riskLevel // ignore: cast_nullable_to_non_nullable
                  as String,
        riskScore: null == riskScore
            ? _value.riskScore
            : riskScore // ignore: cast_nullable_to_non_nullable
                  as double,
        isMockDetected: null == isMockDetected
            ? _value.isMockDetected
            : isMockDetected // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiGpsRiskResultModelImpl implements _AiGpsRiskResultModel {
  const _$AiGpsRiskResultModelImpl({
    @JsonKey(name: 'riskLevel') this.riskLevel = 'LOW',
    @JsonKey(name: 'riskScore') this.riskScore = 0.0,
    @JsonKey(name: 'isMockDetected') this.isMockDetected = false,
  });

  factory _$AiGpsRiskResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiGpsRiskResultModelImplFromJson(json);

  @override
  @JsonKey(name: 'riskLevel')
  final String riskLevel;
  // LOW, MEDIUM, HIGH
  @override
  @JsonKey(name: 'riskScore')
  final double riskScore;
  @override
  @JsonKey(name: 'isMockDetected')
  final bool isMockDetected;

  @override
  String toString() {
    return 'AiGpsRiskResultModel(riskLevel: $riskLevel, riskScore: $riskScore, isMockDetected: $isMockDetected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiGpsRiskResultModelImpl &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.isMockDetected, isMockDetected) ||
                other.isMockDetected == isMockDetected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, riskLevel, riskScore, isMockDetected);

  /// Create a copy of AiGpsRiskResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiGpsRiskResultModelImplCopyWith<_$AiGpsRiskResultModelImpl>
  get copyWith =>
      __$$AiGpsRiskResultModelImplCopyWithImpl<_$AiGpsRiskResultModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AiGpsRiskResultModelImplToJson(this);
  }
}

abstract class _AiGpsRiskResultModel implements AiGpsRiskResultModel {
  const factory _AiGpsRiskResultModel({
    @JsonKey(name: 'riskLevel') final String riskLevel,
    @JsonKey(name: 'riskScore') final double riskScore,
    @JsonKey(name: 'isMockDetected') final bool isMockDetected,
  }) = _$AiGpsRiskResultModelImpl;

  factory _AiGpsRiskResultModel.fromJson(Map<String, dynamic> json) =
      _$AiGpsRiskResultModelImpl.fromJson;

  @override
  @JsonKey(name: 'riskLevel')
  String get riskLevel; // LOW, MEDIUM, HIGH
  @override
  @JsonKey(name: 'riskScore')
  double get riskScore;
  @override
  @JsonKey(name: 'isMockDetected')
  bool get isMockDetected;

  /// Create a copy of AiGpsRiskResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiGpsRiskResultModelImplCopyWith<_$AiGpsRiskResultModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AiGpsRiskResponseModel _$AiGpsRiskResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _AiGpsRiskResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AiGpsRiskResponseModel {
  @JsonKey(name: 'isSuccess')
  bool get isSuccess => throw _privateConstructorUsedError;
  @JsonKey(name: 'value')
  AiGpsRiskResultModel? get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'errorMessage')
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this AiGpsRiskResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiGpsRiskResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiGpsRiskResponseModelCopyWith<AiGpsRiskResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiGpsRiskResponseModelCopyWith<$Res> {
  factory $AiGpsRiskResponseModelCopyWith(
    AiGpsRiskResponseModel value,
    $Res Function(AiGpsRiskResponseModel) then,
  ) = _$AiGpsRiskResponseModelCopyWithImpl<$Res, AiGpsRiskResponseModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'isSuccess') bool isSuccess,
    @JsonKey(name: 'value') AiGpsRiskResultModel? value,
    @JsonKey(name: 'errorMessage') String? errorMessage,
  });

  $AiGpsRiskResultModelCopyWith<$Res>? get value;
}

/// @nodoc
class _$AiGpsRiskResponseModelCopyWithImpl<
  $Res,
  $Val extends AiGpsRiskResponseModel
>
    implements $AiGpsRiskResponseModelCopyWith<$Res> {
  _$AiGpsRiskResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiGpsRiskResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? value = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isSuccess: null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as AiGpsRiskResultModel?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of AiGpsRiskResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AiGpsRiskResultModelCopyWith<$Res>? get value {
    if (_value.value == null) {
      return null;
    }

    return $AiGpsRiskResultModelCopyWith<$Res>(_value.value!, (value) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AiGpsRiskResponseModelImplCopyWith<$Res>
    implements $AiGpsRiskResponseModelCopyWith<$Res> {
  factory _$$AiGpsRiskResponseModelImplCopyWith(
    _$AiGpsRiskResponseModelImpl value,
    $Res Function(_$AiGpsRiskResponseModelImpl) then,
  ) = __$$AiGpsRiskResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'isSuccess') bool isSuccess,
    @JsonKey(name: 'value') AiGpsRiskResultModel? value,
    @JsonKey(name: 'errorMessage') String? errorMessage,
  });

  @override
  $AiGpsRiskResultModelCopyWith<$Res>? get value;
}

/// @nodoc
class __$$AiGpsRiskResponseModelImplCopyWithImpl<$Res>
    extends
        _$AiGpsRiskResponseModelCopyWithImpl<$Res, _$AiGpsRiskResponseModelImpl>
    implements _$$AiGpsRiskResponseModelImplCopyWith<$Res> {
  __$$AiGpsRiskResponseModelImplCopyWithImpl(
    _$AiGpsRiskResponseModelImpl _value,
    $Res Function(_$AiGpsRiskResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiGpsRiskResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? value = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$AiGpsRiskResponseModelImpl(
        isSuccess: null == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as AiGpsRiskResultModel?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiGpsRiskResponseModelImpl implements _AiGpsRiskResponseModel {
  const _$AiGpsRiskResponseModelImpl({
    @JsonKey(name: 'isSuccess') this.isSuccess = false,
    @JsonKey(name: 'value') this.value,
    @JsonKey(name: 'errorMessage') this.errorMessage,
  });

  factory _$AiGpsRiskResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiGpsRiskResponseModelImplFromJson(json);

  @override
  @JsonKey(name: 'isSuccess')
  final bool isSuccess;
  @override
  @JsonKey(name: 'value')
  final AiGpsRiskResultModel? value;
  @override
  @JsonKey(name: 'errorMessage')
  final String? errorMessage;

  @override
  String toString() {
    return 'AiGpsRiskResponseModel(isSuccess: $isSuccess, value: $value, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiGpsRiskResponseModelImpl &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isSuccess, value, errorMessage);

  /// Create a copy of AiGpsRiskResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiGpsRiskResponseModelImplCopyWith<_$AiGpsRiskResponseModelImpl>
  get copyWith =>
      __$$AiGpsRiskResponseModelImplCopyWithImpl<_$AiGpsRiskResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AiGpsRiskResponseModelImplToJson(this);
  }
}

abstract class _AiGpsRiskResponseModel implements AiGpsRiskResponseModel {
  const factory _AiGpsRiskResponseModel({
    @JsonKey(name: 'isSuccess') final bool isSuccess,
    @JsonKey(name: 'value') final AiGpsRiskResultModel? value,
    @JsonKey(name: 'errorMessage') final String? errorMessage,
  }) = _$AiGpsRiskResponseModelImpl;

  factory _AiGpsRiskResponseModel.fromJson(Map<String, dynamic> json) =
      _$AiGpsRiskResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'isSuccess')
  bool get isSuccess;
  @override
  @JsonKey(name: 'value')
  AiGpsRiskResultModel? get value;
  @override
  @JsonKey(name: 'errorMessage')
  String? get errorMessage;

  /// Create a copy of AiGpsRiskResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiGpsRiskResponseModelImplCopyWith<_$AiGpsRiskResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AttendanceClockResultModel _$AttendanceClockResultModelFromJson(
  Map<String, dynamic> json,
) {
  return _AttendanceClockResultModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceClockResultModel {
  @JsonKey(name: 'attendanceId')
  String? get attendanceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'clockInTime')
  String? get clockInTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'clockOutTime')
  String? get clockOutTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'isLate')
  bool get isLate => throw _privateConstructorUsedError;
  @JsonKey(name: 'lateMinutes')
  int get lateMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'earnedPoints')
  int get earnedPoints => throw _privateConstructorUsedError;
  @JsonKey(name: 'pointType')
  String? get pointType => throw _privateConstructorUsedError;
  @JsonKey(name: 'isInsideGeofence')
  bool get isInsideGeofence => throw _privateConstructorUsedError;

  /// Serializes this AttendanceClockResultModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceClockResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceClockResultModelCopyWith<AttendanceClockResultModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceClockResultModelCopyWith<$Res> {
  factory $AttendanceClockResultModelCopyWith(
    AttendanceClockResultModel value,
    $Res Function(AttendanceClockResultModel) then,
  ) =
      _$AttendanceClockResultModelCopyWithImpl<
        $Res,
        AttendanceClockResultModel
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'attendanceId') String? attendanceId,
    @JsonKey(name: 'clockInTime') String? clockInTime,
    @JsonKey(name: 'clockOutTime') String? clockOutTime,
    @JsonKey(name: 'isLate') bool isLate,
    @JsonKey(name: 'lateMinutes') int lateMinutes,
    @JsonKey(name: 'earnedPoints') int earnedPoints,
    @JsonKey(name: 'pointType') String? pointType,
    @JsonKey(name: 'isInsideGeofence') bool isInsideGeofence,
  });
}

/// @nodoc
class _$AttendanceClockResultModelCopyWithImpl<
  $Res,
  $Val extends AttendanceClockResultModel
>
    implements $AttendanceClockResultModelCopyWith<$Res> {
  _$AttendanceClockResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceClockResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attendanceId = freezed,
    Object? clockInTime = freezed,
    Object? clockOutTime = freezed,
    Object? isLate = null,
    Object? lateMinutes = null,
    Object? earnedPoints = null,
    Object? pointType = freezed,
    Object? isInsideGeofence = null,
  }) {
    return _then(
      _value.copyWith(
            attendanceId: freezed == attendanceId
                ? _value.attendanceId
                : attendanceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            clockInTime: freezed == clockInTime
                ? _value.clockInTime
                : clockInTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            clockOutTime: freezed == clockOutTime
                ? _value.clockOutTime
                : clockOutTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLate: null == isLate
                ? _value.isLate
                : isLate // ignore: cast_nullable_to_non_nullable
                      as bool,
            lateMinutes: null == lateMinutes
                ? _value.lateMinutes
                : lateMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            earnedPoints: null == earnedPoints
                ? _value.earnedPoints
                : earnedPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            pointType: freezed == pointType
                ? _value.pointType
                : pointType // ignore: cast_nullable_to_non_nullable
                      as String?,
            isInsideGeofence: null == isInsideGeofence
                ? _value.isInsideGeofence
                : isInsideGeofence // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttendanceClockResultModelImplCopyWith<$Res>
    implements $AttendanceClockResultModelCopyWith<$Res> {
  factory _$$AttendanceClockResultModelImplCopyWith(
    _$AttendanceClockResultModelImpl value,
    $Res Function(_$AttendanceClockResultModelImpl) then,
  ) = __$$AttendanceClockResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'attendanceId') String? attendanceId,
    @JsonKey(name: 'clockInTime') String? clockInTime,
    @JsonKey(name: 'clockOutTime') String? clockOutTime,
    @JsonKey(name: 'isLate') bool isLate,
    @JsonKey(name: 'lateMinutes') int lateMinutes,
    @JsonKey(name: 'earnedPoints') int earnedPoints,
    @JsonKey(name: 'pointType') String? pointType,
    @JsonKey(name: 'isInsideGeofence') bool isInsideGeofence,
  });
}

/// @nodoc
class __$$AttendanceClockResultModelImplCopyWithImpl<$Res>
    extends
        _$AttendanceClockResultModelCopyWithImpl<
          $Res,
          _$AttendanceClockResultModelImpl
        >
    implements _$$AttendanceClockResultModelImplCopyWith<$Res> {
  __$$AttendanceClockResultModelImplCopyWithImpl(
    _$AttendanceClockResultModelImpl _value,
    $Res Function(_$AttendanceClockResultModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceClockResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attendanceId = freezed,
    Object? clockInTime = freezed,
    Object? clockOutTime = freezed,
    Object? isLate = null,
    Object? lateMinutes = null,
    Object? earnedPoints = null,
    Object? pointType = freezed,
    Object? isInsideGeofence = null,
  }) {
    return _then(
      _$AttendanceClockResultModelImpl(
        attendanceId: freezed == attendanceId
            ? _value.attendanceId
            : attendanceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        clockInTime: freezed == clockInTime
            ? _value.clockInTime
            : clockInTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        clockOutTime: freezed == clockOutTime
            ? _value.clockOutTime
            : clockOutTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLate: null == isLate
            ? _value.isLate
            : isLate // ignore: cast_nullable_to_non_nullable
                  as bool,
        lateMinutes: null == lateMinutes
            ? _value.lateMinutes
            : lateMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        earnedPoints: null == earnedPoints
            ? _value.earnedPoints
            : earnedPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        pointType: freezed == pointType
            ? _value.pointType
            : pointType // ignore: cast_nullable_to_non_nullable
                  as String?,
        isInsideGeofence: null == isInsideGeofence
            ? _value.isInsideGeofence
            : isInsideGeofence // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceClockResultModelImpl implements _AttendanceClockResultModel {
  const _$AttendanceClockResultModelImpl({
    @JsonKey(name: 'attendanceId') this.attendanceId,
    @JsonKey(name: 'clockInTime') this.clockInTime,
    @JsonKey(name: 'clockOutTime') this.clockOutTime,
    @JsonKey(name: 'isLate') this.isLate = false,
    @JsonKey(name: 'lateMinutes') this.lateMinutes = 0,
    @JsonKey(name: 'earnedPoints') this.earnedPoints = 0,
    @JsonKey(name: 'pointType') this.pointType,
    @JsonKey(name: 'isInsideGeofence') this.isInsideGeofence = true,
  });

  factory _$AttendanceClockResultModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AttendanceClockResultModelImplFromJson(json);

  @override
  @JsonKey(name: 'attendanceId')
  final String? attendanceId;
  @override
  @JsonKey(name: 'clockInTime')
  final String? clockInTime;
  @override
  @JsonKey(name: 'clockOutTime')
  final String? clockOutTime;
  @override
  @JsonKey(name: 'isLate')
  final bool isLate;
  @override
  @JsonKey(name: 'lateMinutes')
  final int lateMinutes;
  @override
  @JsonKey(name: 'earnedPoints')
  final int earnedPoints;
  @override
  @JsonKey(name: 'pointType')
  final String? pointType;
  @override
  @JsonKey(name: 'isInsideGeofence')
  final bool isInsideGeofence;

  @override
  String toString() {
    return 'AttendanceClockResultModel(attendanceId: $attendanceId, clockInTime: $clockInTime, clockOutTime: $clockOutTime, isLate: $isLate, lateMinutes: $lateMinutes, earnedPoints: $earnedPoints, pointType: $pointType, isInsideGeofence: $isInsideGeofence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceClockResultModelImpl &&
            (identical(other.attendanceId, attendanceId) ||
                other.attendanceId == attendanceId) &&
            (identical(other.clockInTime, clockInTime) ||
                other.clockInTime == clockInTime) &&
            (identical(other.clockOutTime, clockOutTime) ||
                other.clockOutTime == clockOutTime) &&
            (identical(other.isLate, isLate) || other.isLate == isLate) &&
            (identical(other.lateMinutes, lateMinutes) ||
                other.lateMinutes == lateMinutes) &&
            (identical(other.earnedPoints, earnedPoints) ||
                other.earnedPoints == earnedPoints) &&
            (identical(other.pointType, pointType) ||
                other.pointType == pointType) &&
            (identical(other.isInsideGeofence, isInsideGeofence) ||
                other.isInsideGeofence == isInsideGeofence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    attendanceId,
    clockInTime,
    clockOutTime,
    isLate,
    lateMinutes,
    earnedPoints,
    pointType,
    isInsideGeofence,
  );

  /// Create a copy of AttendanceClockResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceClockResultModelImplCopyWith<_$AttendanceClockResultModelImpl>
  get copyWith =>
      __$$AttendanceClockResultModelImplCopyWithImpl<
        _$AttendanceClockResultModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceClockResultModelImplToJson(this);
  }
}

abstract class _AttendanceClockResultModel
    implements AttendanceClockResultModel {
  const factory _AttendanceClockResultModel({
    @JsonKey(name: 'attendanceId') final String? attendanceId,
    @JsonKey(name: 'clockInTime') final String? clockInTime,
    @JsonKey(name: 'clockOutTime') final String? clockOutTime,
    @JsonKey(name: 'isLate') final bool isLate,
    @JsonKey(name: 'lateMinutes') final int lateMinutes,
    @JsonKey(name: 'earnedPoints') final int earnedPoints,
    @JsonKey(name: 'pointType') final String? pointType,
    @JsonKey(name: 'isInsideGeofence') final bool isInsideGeofence,
  }) = _$AttendanceClockResultModelImpl;

  factory _AttendanceClockResultModel.fromJson(Map<String, dynamic> json) =
      _$AttendanceClockResultModelImpl.fromJson;

  @override
  @JsonKey(name: 'attendanceId')
  String? get attendanceId;
  @override
  @JsonKey(name: 'clockInTime')
  String? get clockInTime;
  @override
  @JsonKey(name: 'clockOutTime')
  String? get clockOutTime;
  @override
  @JsonKey(name: 'isLate')
  bool get isLate;
  @override
  @JsonKey(name: 'lateMinutes')
  int get lateMinutes;
  @override
  @JsonKey(name: 'earnedPoints')
  int get earnedPoints;
  @override
  @JsonKey(name: 'pointType')
  String? get pointType;
  @override
  @JsonKey(name: 'isInsideGeofence')
  bool get isInsideGeofence;

  /// Create a copy of AttendanceClockResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceClockResultModelImplCopyWith<_$AttendanceClockResultModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
