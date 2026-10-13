// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points_exchange_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PointsExchangeRequestBody _$PointsExchangeRequestBodyFromJson(
  Map<String, dynamic> json,
) {
  return _PointsExchangeRequestBody.fromJson(json);
}

/// @nodoc
mixin _$PointsExchangeRequestBody {
  String get target => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get idempotencyKey => throw _privateConstructorUsedError;
  String? get employeeId => throw _privateConstructorUsedError;

  /// Serializes this PointsExchangeRequestBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsExchangeRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsExchangeRequestBodyCopyWith<PointsExchangeRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsExchangeRequestBodyCopyWith<$Res> {
  factory $PointsExchangeRequestBodyCopyWith(
    PointsExchangeRequestBody value,
    $Res Function(PointsExchangeRequestBody) then,
  ) = _$PointsExchangeRequestBodyCopyWithImpl<$Res, PointsExchangeRequestBody>;
  @useResult
  $Res call({
    String target,
    int quantity,
    String idempotencyKey,
    String? employeeId,
  });
}

/// @nodoc
class _$PointsExchangeRequestBodyCopyWithImpl<
  $Res,
  $Val extends PointsExchangeRequestBody
>
    implements $PointsExchangeRequestBodyCopyWith<$Res> {
  _$PointsExchangeRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsExchangeRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? target = null,
    Object? quantity = null,
    Object? idempotencyKey = null,
    Object? employeeId = freezed,
  }) {
    return _then(
      _value.copyWith(
            target: null == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            idempotencyKey: null == idempotencyKey
                ? _value.idempotencyKey
                : idempotencyKey // ignore: cast_nullable_to_non_nullable
                      as String,
            employeeId: freezed == employeeId
                ? _value.employeeId
                : employeeId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointsExchangeRequestBodyImplCopyWith<$Res>
    implements $PointsExchangeRequestBodyCopyWith<$Res> {
  factory _$$PointsExchangeRequestBodyImplCopyWith(
    _$PointsExchangeRequestBodyImpl value,
    $Res Function(_$PointsExchangeRequestBodyImpl) then,
  ) = __$$PointsExchangeRequestBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String target,
    int quantity,
    String idempotencyKey,
    String? employeeId,
  });
}

/// @nodoc
class __$$PointsExchangeRequestBodyImplCopyWithImpl<$Res>
    extends
        _$PointsExchangeRequestBodyCopyWithImpl<
          $Res,
          _$PointsExchangeRequestBodyImpl
        >
    implements _$$PointsExchangeRequestBodyImplCopyWith<$Res> {
  __$$PointsExchangeRequestBodyImplCopyWithImpl(
    _$PointsExchangeRequestBodyImpl _value,
    $Res Function(_$PointsExchangeRequestBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsExchangeRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? target = null,
    Object? quantity = null,
    Object? idempotencyKey = null,
    Object? employeeId = freezed,
  }) {
    return _then(
      _$PointsExchangeRequestBodyImpl(
        target: null == target
            ? _value.target
            : target // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        idempotencyKey: null == idempotencyKey
            ? _value.idempotencyKey
            : idempotencyKey // ignore: cast_nullable_to_non_nullable
                  as String,
        employeeId: freezed == employeeId
            ? _value.employeeId
            : employeeId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsExchangeRequestBodyImpl implements _PointsExchangeRequestBody {
  const _$PointsExchangeRequestBodyImpl({
    required this.target,
    required this.quantity,
    required this.idempotencyKey,
    this.employeeId,
  });

  factory _$PointsExchangeRequestBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsExchangeRequestBodyImplFromJson(json);

  @override
  final String target;
  @override
  final int quantity;
  @override
  final String idempotencyKey;
  @override
  final String? employeeId;

  @override
  String toString() {
    return 'PointsExchangeRequestBody(target: $target, quantity: $quantity, idempotencyKey: $idempotencyKey, employeeId: $employeeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsExchangeRequestBodyImpl &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                other.idempotencyKey == idempotencyKey) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, target, quantity, idempotencyKey, employeeId);

  /// Create a copy of PointsExchangeRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsExchangeRequestBodyImplCopyWith<_$PointsExchangeRequestBodyImpl>
  get copyWith =>
      __$$PointsExchangeRequestBodyImplCopyWithImpl<
        _$PointsExchangeRequestBodyImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsExchangeRequestBodyImplToJson(this);
  }
}

abstract class _PointsExchangeRequestBody implements PointsExchangeRequestBody {
  const factory _PointsExchangeRequestBody({
    required final String target,
    required final int quantity,
    required final String idempotencyKey,
    final String? employeeId,
  }) = _$PointsExchangeRequestBodyImpl;

  factory _PointsExchangeRequestBody.fromJson(Map<String, dynamic> json) =
      _$PointsExchangeRequestBodyImpl.fromJson;

  @override
  String get target;
  @override
  int get quantity;
  @override
  String get idempotencyKey;
  @override
  String? get employeeId;

  /// Create a copy of PointsExchangeRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsExchangeRequestBodyImplCopyWith<_$PointsExchangeRequestBodyImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PointsExchangeResultModel _$PointsExchangeResultModelFromJson(
  Map<String, dynamic> json,
) {
  return _PointsExchangeResultModel.fromJson(json);
}

/// @nodoc
mixin _$PointsExchangeResultModel {
  bool get success => throw _privateConstructorUsedError;
  String get exchangeId => throw _privateConstructorUsedError;
  int get amountIn => throw _privateConstructorUsedError;
  int get amountOut => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  bool get idempotentReplay => throw _privateConstructorUsedError;

  /// Serializes this PointsExchangeResultModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsExchangeResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsExchangeResultModelCopyWith<PointsExchangeResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsExchangeResultModelCopyWith<$Res> {
  factory $PointsExchangeResultModelCopyWith(
    PointsExchangeResultModel value,
    $Res Function(PointsExchangeResultModel) then,
  ) = _$PointsExchangeResultModelCopyWithImpl<$Res, PointsExchangeResultModel>;
  @useResult
  $Res call({
    bool success,
    String exchangeId,
    int amountIn,
    int amountOut,
    double rate,
    bool idempotentReplay,
  });
}

/// @nodoc
class _$PointsExchangeResultModelCopyWithImpl<
  $Res,
  $Val extends PointsExchangeResultModel
>
    implements $PointsExchangeResultModelCopyWith<$Res> {
  _$PointsExchangeResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsExchangeResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? exchangeId = null,
    Object? amountIn = null,
    Object? amountOut = null,
    Object? rate = null,
    Object? idempotentReplay = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            exchangeId: null == exchangeId
                ? _value.exchangeId
                : exchangeId // ignore: cast_nullable_to_non_nullable
                      as String,
            amountIn: null == amountIn
                ? _value.amountIn
                : amountIn // ignore: cast_nullable_to_non_nullable
                      as int,
            amountOut: null == amountOut
                ? _value.amountOut
                : amountOut // ignore: cast_nullable_to_non_nullable
                      as int,
            rate: null == rate
                ? _value.rate
                : rate // ignore: cast_nullable_to_non_nullable
                      as double,
            idempotentReplay: null == idempotentReplay
                ? _value.idempotentReplay
                : idempotentReplay // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointsExchangeResultModelImplCopyWith<$Res>
    implements $PointsExchangeResultModelCopyWith<$Res> {
  factory _$$PointsExchangeResultModelImplCopyWith(
    _$PointsExchangeResultModelImpl value,
    $Res Function(_$PointsExchangeResultModelImpl) then,
  ) = __$$PointsExchangeResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    String exchangeId,
    int amountIn,
    int amountOut,
    double rate,
    bool idempotentReplay,
  });
}

/// @nodoc
class __$$PointsExchangeResultModelImplCopyWithImpl<$Res>
    extends
        _$PointsExchangeResultModelCopyWithImpl<
          $Res,
          _$PointsExchangeResultModelImpl
        >
    implements _$$PointsExchangeResultModelImplCopyWith<$Res> {
  __$$PointsExchangeResultModelImplCopyWithImpl(
    _$PointsExchangeResultModelImpl _value,
    $Res Function(_$PointsExchangeResultModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsExchangeResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? exchangeId = null,
    Object? amountIn = null,
    Object? amountOut = null,
    Object? rate = null,
    Object? idempotentReplay = null,
  }) {
    return _then(
      _$PointsExchangeResultModelImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        exchangeId: null == exchangeId
            ? _value.exchangeId
            : exchangeId // ignore: cast_nullable_to_non_nullable
                  as String,
        amountIn: null == amountIn
            ? _value.amountIn
            : amountIn // ignore: cast_nullable_to_non_nullable
                  as int,
        amountOut: null == amountOut
            ? _value.amountOut
            : amountOut // ignore: cast_nullable_to_non_nullable
                  as int,
        rate: null == rate
            ? _value.rate
            : rate // ignore: cast_nullable_to_non_nullable
                  as double,
        idempotentReplay: null == idempotentReplay
            ? _value.idempotentReplay
            : idempotentReplay // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsExchangeResultModelImpl implements _PointsExchangeResultModel {
  const _$PointsExchangeResultModelImpl({
    required this.success,
    required this.exchangeId,
    required this.amountIn,
    required this.amountOut,
    required this.rate,
    this.idempotentReplay = false,
  });

  factory _$PointsExchangeResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsExchangeResultModelImplFromJson(json);

  @override
  final bool success;
  @override
  final String exchangeId;
  @override
  final int amountIn;
  @override
  final int amountOut;
  @override
  final double rate;
  @override
  @JsonKey()
  final bool idempotentReplay;

  @override
  String toString() {
    return 'PointsExchangeResultModel(success: $success, exchangeId: $exchangeId, amountIn: $amountIn, amountOut: $amountOut, rate: $rate, idempotentReplay: $idempotentReplay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsExchangeResultModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.exchangeId, exchangeId) ||
                other.exchangeId == exchangeId) &&
            (identical(other.amountIn, amountIn) ||
                other.amountIn == amountIn) &&
            (identical(other.amountOut, amountOut) ||
                other.amountOut == amountOut) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.idempotentReplay, idempotentReplay) ||
                other.idempotentReplay == idempotentReplay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    exchangeId,
    amountIn,
    amountOut,
    rate,
    idempotentReplay,
  );

  /// Create a copy of PointsExchangeResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsExchangeResultModelImplCopyWith<_$PointsExchangeResultModelImpl>
  get copyWith =>
      __$$PointsExchangeResultModelImplCopyWithImpl<
        _$PointsExchangeResultModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsExchangeResultModelImplToJson(this);
  }
}

abstract class _PointsExchangeResultModel implements PointsExchangeResultModel {
  const factory _PointsExchangeResultModel({
    required final bool success,
    required final String exchangeId,
    required final int amountIn,
    required final int amountOut,
    required final double rate,
    final bool idempotentReplay,
  }) = _$PointsExchangeResultModelImpl;

  factory _PointsExchangeResultModel.fromJson(Map<String, dynamic> json) =
      _$PointsExchangeResultModelImpl.fromJson;

  @override
  bool get success;
  @override
  String get exchangeId;
  @override
  int get amountIn;
  @override
  int get amountOut;
  @override
  double get rate;
  @override
  bool get idempotentReplay;

  /// Create a copy of PointsExchangeResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsExchangeResultModelImplCopyWith<_$PointsExchangeResultModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PointsExchangeResponseModel _$PointsExchangeResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _PointsExchangeResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PointsExchangeResponseModel {
  PointsExchangeResultModel? get value => throw _privateConstructorUsedError;
  bool? get isSuccess => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;

  /// Serializes this PointsExchangeResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsExchangeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsExchangeResponseModelCopyWith<PointsExchangeResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsExchangeResponseModelCopyWith<$Res> {
  factory $PointsExchangeResponseModelCopyWith(
    PointsExchangeResponseModel value,
    $Res Function(PointsExchangeResponseModel) then,
  ) =
      _$PointsExchangeResponseModelCopyWithImpl<
        $Res,
        PointsExchangeResponseModel
      >;
  @useResult
  $Res call({
    PointsExchangeResultModel? value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  });

  $PointsExchangeResultModelCopyWith<$Res>? get value;
}

/// @nodoc
class _$PointsExchangeResponseModelCopyWithImpl<
  $Res,
  $Val extends PointsExchangeResponseModel
>
    implements $PointsExchangeResponseModelCopyWith<$Res> {
  _$PointsExchangeResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsExchangeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? isSuccess = freezed,
    Object? successMessage = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _value.copyWith(
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as PointsExchangeResultModel?,
            isSuccess: freezed == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool?,
            successMessage: freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            errors: freezed == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }

  /// Create a copy of PointsExchangeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointsExchangeResultModelCopyWith<$Res>? get value {
    if (_value.value == null) {
      return null;
    }

    return $PointsExchangeResultModelCopyWith<$Res>(_value.value!, (value) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PointsExchangeResponseModelImplCopyWith<$Res>
    implements $PointsExchangeResponseModelCopyWith<$Res> {
  factory _$$PointsExchangeResponseModelImplCopyWith(
    _$PointsExchangeResponseModelImpl value,
    $Res Function(_$PointsExchangeResponseModelImpl) then,
  ) = __$$PointsExchangeResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PointsExchangeResultModel? value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  });

  @override
  $PointsExchangeResultModelCopyWith<$Res>? get value;
}

/// @nodoc
class __$$PointsExchangeResponseModelImplCopyWithImpl<$Res>
    extends
        _$PointsExchangeResponseModelCopyWithImpl<
          $Res,
          _$PointsExchangeResponseModelImpl
        >
    implements _$$PointsExchangeResponseModelImplCopyWith<$Res> {
  __$$PointsExchangeResponseModelImplCopyWithImpl(
    _$PointsExchangeResponseModelImpl _value,
    $Res Function(_$PointsExchangeResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsExchangeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? isSuccess = freezed,
    Object? successMessage = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _$PointsExchangeResponseModelImpl(
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as PointsExchangeResultModel?,
        isSuccess: freezed == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        errors: freezed == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsExchangeResponseModelImpl
    implements _PointsExchangeResponseModel {
  const _$PointsExchangeResponseModelImpl({
    this.value,
    this.isSuccess,
    this.successMessage,
    final List<String>? errors,
  }) : _errors = errors;

  factory _$PointsExchangeResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PointsExchangeResponseModelImplFromJson(json);

  @override
  final PointsExchangeResultModel? value;
  @override
  final bool? isSuccess;
  @override
  final String? successMessage;
  final List<String>? _errors;
  @override
  List<String>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PointsExchangeResponseModel(value: $value, isSuccess: $isSuccess, successMessage: $successMessage, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsExchangeResponseModelImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    value,
    isSuccess,
    successMessage,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of PointsExchangeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsExchangeResponseModelImplCopyWith<_$PointsExchangeResponseModelImpl>
  get copyWith =>
      __$$PointsExchangeResponseModelImplCopyWithImpl<
        _$PointsExchangeResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsExchangeResponseModelImplToJson(this);
  }
}

abstract class _PointsExchangeResponseModel
    implements PointsExchangeResponseModel {
  const factory _PointsExchangeResponseModel({
    final PointsExchangeResultModel? value,
    final bool? isSuccess,
    final String? successMessage,
    final List<String>? errors,
  }) = _$PointsExchangeResponseModelImpl;

  factory _PointsExchangeResponseModel.fromJson(Map<String, dynamic> json) =
      _$PointsExchangeResponseModelImpl.fromJson;

  @override
  PointsExchangeResultModel? get value;
  @override
  bool? get isSuccess;
  @override
  String? get successMessage;
  @override
  List<String>? get errors;

  /// Create a copy of PointsExchangeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsExchangeResponseModelImplCopyWith<_$PointsExchangeResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
