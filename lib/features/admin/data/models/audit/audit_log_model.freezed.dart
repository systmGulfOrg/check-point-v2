// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuditLogModel _$AuditLogModelFromJson(Map<String, dynamic> json) {
  return _AuditLogModel.fromJson(json);
}

/// @nodoc
mixin _$AuditLogModel {
  String get id => throw _privateConstructorUsedError;
  String? get actorId => throw _privateConstructorUsedError;
  String? get actorName => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get before => throw _privateConstructorUsedError;
  Map<String, dynamic>? get after => throw _privateConstructorUsedError;

  /// Serializes this AuditLogModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuditLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuditLogModelCopyWith<AuditLogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditLogModelCopyWith<$Res> {
  factory $AuditLogModelCopyWith(
    AuditLogModel value,
    $Res Function(AuditLogModel) then,
  ) = _$AuditLogModelCopyWithImpl<$Res, AuditLogModel>;
  @useResult
  $Res call({
    String id,
    String? actorId,
    String? actorName,
    String action,
    DateTime createdAt,
    Map<String, dynamic>? before,
    Map<String, dynamic>? after,
  });
}

/// @nodoc
class _$AuditLogModelCopyWithImpl<$Res, $Val extends AuditLogModel>
    implements $AuditLogModelCopyWith<$Res> {
  _$AuditLogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuditLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? actorId = freezed,
    Object? actorName = freezed,
    Object? action = null,
    Object? createdAt = null,
    Object? before = freezed,
    Object? after = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            actorId: freezed == actorId
                ? _value.actorId
                : actorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            actorName: freezed == actorName
                ? _value.actorName
                : actorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            action: null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            before: freezed == before
                ? _value.before
                : before // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            after: freezed == after
                ? _value.after
                : after // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuditLogModelImplCopyWith<$Res>
    implements $AuditLogModelCopyWith<$Res> {
  factory _$$AuditLogModelImplCopyWith(
    _$AuditLogModelImpl value,
    $Res Function(_$AuditLogModelImpl) then,
  ) = __$$AuditLogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? actorId,
    String? actorName,
    String action,
    DateTime createdAt,
    Map<String, dynamic>? before,
    Map<String, dynamic>? after,
  });
}

/// @nodoc
class __$$AuditLogModelImplCopyWithImpl<$Res>
    extends _$AuditLogModelCopyWithImpl<$Res, _$AuditLogModelImpl>
    implements _$$AuditLogModelImplCopyWith<$Res> {
  __$$AuditLogModelImplCopyWithImpl(
    _$AuditLogModelImpl _value,
    $Res Function(_$AuditLogModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuditLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? actorId = freezed,
    Object? actorName = freezed,
    Object? action = null,
    Object? createdAt = null,
    Object? before = freezed,
    Object? after = freezed,
  }) {
    return _then(
      _$AuditLogModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        actorId: freezed == actorId
            ? _value.actorId
            : actorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        actorName: freezed == actorName
            ? _value.actorName
            : actorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        before: freezed == before
            ? _value._before
            : before // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        after: freezed == after
            ? _value._after
            : after // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuditLogModelImpl implements _AuditLogModel {
  const _$AuditLogModelImpl({
    required this.id,
    this.actorId,
    this.actorName,
    required this.action,
    required this.createdAt,
    final Map<String, dynamic>? before,
    final Map<String, dynamic>? after,
  }) : _before = before,
       _after = after;

  factory _$AuditLogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuditLogModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? actorId;
  @override
  final String? actorName;
  @override
  final String action;
  @override
  final DateTime createdAt;
  final Map<String, dynamic>? _before;
  @override
  Map<String, dynamic>? get before {
    final value = _before;
    if (value == null) return null;
    if (_before is EqualUnmodifiableMapView) return _before;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _after;
  @override
  Map<String, dynamic>? get after {
    final value = _after;
    if (value == null) return null;
    if (_after is EqualUnmodifiableMapView) return _after;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AuditLogModel(id: $id, actorId: $actorId, actorName: $actorName, action: $action, createdAt: $createdAt, before: $before, after: $after)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuditLogModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.actorId, actorId) || other.actorId == actorId) &&
            (identical(other.actorName, actorName) ||
                other.actorName == actorName) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._before, _before) &&
            const DeepCollectionEquality().equals(other._after, _after));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    actorId,
    actorName,
    action,
    createdAt,
    const DeepCollectionEquality().hash(_before),
    const DeepCollectionEquality().hash(_after),
  );

  /// Create a copy of AuditLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuditLogModelImplCopyWith<_$AuditLogModelImpl> get copyWith =>
      __$$AuditLogModelImplCopyWithImpl<_$AuditLogModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuditLogModelImplToJson(this);
  }
}

abstract class _AuditLogModel implements AuditLogModel {
  const factory _AuditLogModel({
    required final String id,
    final String? actorId,
    final String? actorName,
    required final String action,
    required final DateTime createdAt,
    final Map<String, dynamic>? before,
    final Map<String, dynamic>? after,
  }) = _$AuditLogModelImpl;

  factory _AuditLogModel.fromJson(Map<String, dynamic> json) =
      _$AuditLogModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get actorId;
  @override
  String? get actorName;
  @override
  String get action;
  @override
  DateTime get createdAt;
  @override
  Map<String, dynamic>? get before;
  @override
  Map<String, dynamic>? get after;

  /// Create a copy of AuditLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuditLogModelImplCopyWith<_$AuditLogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuditLogsResponseModel _$AuditLogsResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _AuditLogsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AuditLogsResponseModel {
  bool get isSuccess => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  AuditLogsResponseValue get value => throw _privateConstructorUsedError;

  /// Serializes this AuditLogsResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuditLogsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuditLogsResponseModelCopyWith<AuditLogsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditLogsResponseModelCopyWith<$Res> {
  factory $AuditLogsResponseModelCopyWith(
    AuditLogsResponseModel value,
    $Res Function(AuditLogsResponseModel) then,
  ) = _$AuditLogsResponseModelCopyWithImpl<$Res, AuditLogsResponseModel>;
  @useResult
  $Res call({bool isSuccess, int status, AuditLogsResponseValue value});

  $AuditLogsResponseValueCopyWith<$Res> get value;
}

/// @nodoc
class _$AuditLogsResponseModelCopyWithImpl<
  $Res,
  $Val extends AuditLogsResponseModel
>
    implements $AuditLogsResponseModelCopyWith<$Res> {
  _$AuditLogsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuditLogsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? status = null,
    Object? value = null,
  }) {
    return _then(
      _value.copyWith(
            isSuccess: null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as AuditLogsResponseValue,
          )
          as $Val,
    );
  }

  /// Create a copy of AuditLogsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuditLogsResponseValueCopyWith<$Res> get value {
    return $AuditLogsResponseValueCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuditLogsResponseModelImplCopyWith<$Res>
    implements $AuditLogsResponseModelCopyWith<$Res> {
  factory _$$AuditLogsResponseModelImplCopyWith(
    _$AuditLogsResponseModelImpl value,
    $Res Function(_$AuditLogsResponseModelImpl) then,
  ) = __$$AuditLogsResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isSuccess, int status, AuditLogsResponseValue value});

  @override
  $AuditLogsResponseValueCopyWith<$Res> get value;
}

/// @nodoc
class __$$AuditLogsResponseModelImplCopyWithImpl<$Res>
    extends
        _$AuditLogsResponseModelCopyWithImpl<$Res, _$AuditLogsResponseModelImpl>
    implements _$$AuditLogsResponseModelImplCopyWith<$Res> {
  __$$AuditLogsResponseModelImplCopyWithImpl(
    _$AuditLogsResponseModelImpl _value,
    $Res Function(_$AuditLogsResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuditLogsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? status = null,
    Object? value = null,
  }) {
    return _then(
      _$AuditLogsResponseModelImpl(
        isSuccess: null == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as AuditLogsResponseValue,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuditLogsResponseModelImpl implements _AuditLogsResponseModel {
  const _$AuditLogsResponseModelImpl({
    required this.isSuccess,
    required this.status,
    required this.value,
  });

  factory _$AuditLogsResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuditLogsResponseModelImplFromJson(json);

  @override
  final bool isSuccess;
  @override
  final int status;
  @override
  final AuditLogsResponseValue value;

  @override
  String toString() {
    return 'AuditLogsResponseModel(isSuccess: $isSuccess, status: $status, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuditLogsResponseModelImpl &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isSuccess, status, value);

  /// Create a copy of AuditLogsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuditLogsResponseModelImplCopyWith<_$AuditLogsResponseModelImpl>
  get copyWith =>
      __$$AuditLogsResponseModelImplCopyWithImpl<_$AuditLogsResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AuditLogsResponseModelImplToJson(this);
  }
}

abstract class _AuditLogsResponseModel implements AuditLogsResponseModel {
  const factory _AuditLogsResponseModel({
    required final bool isSuccess,
    required final int status,
    required final AuditLogsResponseValue value,
  }) = _$AuditLogsResponseModelImpl;

  factory _AuditLogsResponseModel.fromJson(Map<String, dynamic> json) =
      _$AuditLogsResponseModelImpl.fromJson;

  @override
  bool get isSuccess;
  @override
  int get status;
  @override
  AuditLogsResponseValue get value;

  /// Create a copy of AuditLogsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuditLogsResponseModelImplCopyWith<_$AuditLogsResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AuditLogsResponseValue _$AuditLogsResponseValueFromJson(
  Map<String, dynamic> json,
) {
  return _AuditLogsResponseValue.fromJson(json);
}

/// @nodoc
mixin _$AuditLogsResponseValue {
  List<AuditLogModel> get items => throw _privateConstructorUsedError;
  int? get totalCount => throw _privateConstructorUsedError;

  /// Serializes this AuditLogsResponseValue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuditLogsResponseValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuditLogsResponseValueCopyWith<AuditLogsResponseValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditLogsResponseValueCopyWith<$Res> {
  factory $AuditLogsResponseValueCopyWith(
    AuditLogsResponseValue value,
    $Res Function(AuditLogsResponseValue) then,
  ) = _$AuditLogsResponseValueCopyWithImpl<$Res, AuditLogsResponseValue>;
  @useResult
  $Res call({List<AuditLogModel> items, int? totalCount});
}

/// @nodoc
class _$AuditLogsResponseValueCopyWithImpl<
  $Res,
  $Val extends AuditLogsResponseValue
>
    implements $AuditLogsResponseValueCopyWith<$Res> {
  _$AuditLogsResponseValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuditLogsResponseValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? totalCount = freezed}) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<AuditLogModel>,
            totalCount: freezed == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuditLogsResponseValueImplCopyWith<$Res>
    implements $AuditLogsResponseValueCopyWith<$Res> {
  factory _$$AuditLogsResponseValueImplCopyWith(
    _$AuditLogsResponseValueImpl value,
    $Res Function(_$AuditLogsResponseValueImpl) then,
  ) = __$$AuditLogsResponseValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AuditLogModel> items, int? totalCount});
}

/// @nodoc
class __$$AuditLogsResponseValueImplCopyWithImpl<$Res>
    extends
        _$AuditLogsResponseValueCopyWithImpl<$Res, _$AuditLogsResponseValueImpl>
    implements _$$AuditLogsResponseValueImplCopyWith<$Res> {
  __$$AuditLogsResponseValueImplCopyWithImpl(
    _$AuditLogsResponseValueImpl _value,
    $Res Function(_$AuditLogsResponseValueImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuditLogsResponseValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? totalCount = freezed}) {
    return _then(
      _$AuditLogsResponseValueImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<AuditLogModel>,
        totalCount: freezed == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuditLogsResponseValueImpl implements _AuditLogsResponseValue {
  const _$AuditLogsResponseValueImpl({
    required final List<AuditLogModel> items,
    this.totalCount,
  }) : _items = items;

  factory _$AuditLogsResponseValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuditLogsResponseValueImplFromJson(json);

  final List<AuditLogModel> _items;
  @override
  List<AuditLogModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int? totalCount;

  @override
  String toString() {
    return 'AuditLogsResponseValue(items: $items, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuditLogsResponseValueImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    totalCount,
  );

  /// Create a copy of AuditLogsResponseValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuditLogsResponseValueImplCopyWith<_$AuditLogsResponseValueImpl>
  get copyWith =>
      __$$AuditLogsResponseValueImplCopyWithImpl<_$AuditLogsResponseValueImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AuditLogsResponseValueImplToJson(this);
  }
}

abstract class _AuditLogsResponseValue implements AuditLogsResponseValue {
  const factory _AuditLogsResponseValue({
    required final List<AuditLogModel> items,
    final int? totalCount,
  }) = _$AuditLogsResponseValueImpl;

  factory _AuditLogsResponseValue.fromJson(Map<String, dynamic> json) =
      _$AuditLogsResponseValueImpl.fromJson;

  @override
  List<AuditLogModel> get items;
  @override
  int? get totalCount;

  /// Create a copy of AuditLogsResponseValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuditLogsResponseValueImplCopyWith<_$AuditLogsResponseValueImpl>
  get copyWith => throw _privateConstructorUsedError;
}
