// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PointsHistoryItemModel _$PointsHistoryItemModelFromJson(
  Map<String, dynamic> json,
) {
  return _PointsHistoryItemModel.fromJson(json);
}

/// @nodoc
mixin _$PointsHistoryItemModel {
  String get id => throw _privateConstructorUsedError;
  String get pointType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  String get attendanceDate => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String? get cancelReason => throw _privateConstructorUsedError;
  String? get permissionId => throw _privateConstructorUsedError;
  String? get attendanceId => throw _privateConstructorUsedError;
  String? get expiresAt => throw _privateConstructorUsedError;
  String? get recomputedAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get computationSnapshot =>
      throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PointsHistoryItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsHistoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsHistoryItemModelCopyWith<PointsHistoryItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsHistoryItemModelCopyWith<$Res> {
  factory $PointsHistoryItemModelCopyWith(
    PointsHistoryItemModel value,
    $Res Function(PointsHistoryItemModel) then,
  ) = _$PointsHistoryItemModelCopyWithImpl<$Res, PointsHistoryItemModel>;
  @useResult
  $Res call({
    String id,
    String pointType,
    String status,
    String source,
    int points,
    String attendanceDate,
    String reason,
    String? cancelReason,
    String? permissionId,
    String? attendanceId,
    String? expiresAt,
    String? recomputedAt,
    Map<String, dynamic>? computationSnapshot,
    String createdAt,
  });
}

/// @nodoc
class _$PointsHistoryItemModelCopyWithImpl<
  $Res,
  $Val extends PointsHistoryItemModel
>
    implements $PointsHistoryItemModelCopyWith<$Res> {
  _$PointsHistoryItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsHistoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pointType = null,
    Object? status = null,
    Object? source = null,
    Object? points = null,
    Object? attendanceDate = null,
    Object? reason = null,
    Object? cancelReason = freezed,
    Object? permissionId = freezed,
    Object? attendanceId = freezed,
    Object? expiresAt = freezed,
    Object? recomputedAt = freezed,
    Object? computationSnapshot = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            pointType: null == pointType
                ? _value.pointType
                : pointType // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            attendanceDate: null == attendanceDate
                ? _value.attendanceDate
                : attendanceDate // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            cancelReason: freezed == cancelReason
                ? _value.cancelReason
                : cancelReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            permissionId: freezed == permissionId
                ? _value.permissionId
                : permissionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            attendanceId: freezed == attendanceId
                ? _value.attendanceId
                : attendanceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            recomputedAt: freezed == recomputedAt
                ? _value.recomputedAt
                : recomputedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            computationSnapshot: freezed == computationSnapshot
                ? _value.computationSnapshot
                : computationSnapshot // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointsHistoryItemModelImplCopyWith<$Res>
    implements $PointsHistoryItemModelCopyWith<$Res> {
  factory _$$PointsHistoryItemModelImplCopyWith(
    _$PointsHistoryItemModelImpl value,
    $Res Function(_$PointsHistoryItemModelImpl) then,
  ) = __$$PointsHistoryItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String pointType,
    String status,
    String source,
    int points,
    String attendanceDate,
    String reason,
    String? cancelReason,
    String? permissionId,
    String? attendanceId,
    String? expiresAt,
    String? recomputedAt,
    Map<String, dynamic>? computationSnapshot,
    String createdAt,
  });
}

/// @nodoc
class __$$PointsHistoryItemModelImplCopyWithImpl<$Res>
    extends
        _$PointsHistoryItemModelCopyWithImpl<$Res, _$PointsHistoryItemModelImpl>
    implements _$$PointsHistoryItemModelImplCopyWith<$Res> {
  __$$PointsHistoryItemModelImplCopyWithImpl(
    _$PointsHistoryItemModelImpl _value,
    $Res Function(_$PointsHistoryItemModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsHistoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pointType = null,
    Object? status = null,
    Object? source = null,
    Object? points = null,
    Object? attendanceDate = null,
    Object? reason = null,
    Object? cancelReason = freezed,
    Object? permissionId = freezed,
    Object? attendanceId = freezed,
    Object? expiresAt = freezed,
    Object? recomputedAt = freezed,
    Object? computationSnapshot = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$PointsHistoryItemModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        pointType: null == pointType
            ? _value.pointType
            : pointType // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        attendanceDate: null == attendanceDate
            ? _value.attendanceDate
            : attendanceDate // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        cancelReason: freezed == cancelReason
            ? _value.cancelReason
            : cancelReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        permissionId: freezed == permissionId
            ? _value.permissionId
            : permissionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        attendanceId: freezed == attendanceId
            ? _value.attendanceId
            : attendanceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        recomputedAt: freezed == recomputedAt
            ? _value.recomputedAt
            : recomputedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        computationSnapshot: freezed == computationSnapshot
            ? _value._computationSnapshot
            : computationSnapshot // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsHistoryItemModelImpl implements _PointsHistoryItemModel {
  const _$PointsHistoryItemModelImpl({
    required this.id,
    required this.pointType,
    required this.status,
    required this.source,
    this.points = 0,
    required this.attendanceDate,
    required this.reason,
    this.cancelReason,
    this.permissionId,
    this.attendanceId,
    this.expiresAt,
    this.recomputedAt,
    final Map<String, dynamic>? computationSnapshot,
    required this.createdAt,
  }) : _computationSnapshot = computationSnapshot;

  factory _$PointsHistoryItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsHistoryItemModelImplFromJson(json);

  @override
  final String id;
  @override
  final String pointType;
  @override
  final String status;
  @override
  final String source;
  @override
  @JsonKey()
  final int points;
  @override
  final String attendanceDate;
  @override
  final String reason;
  @override
  final String? cancelReason;
  @override
  final String? permissionId;
  @override
  final String? attendanceId;
  @override
  final String? expiresAt;
  @override
  final String? recomputedAt;
  final Map<String, dynamic>? _computationSnapshot;
  @override
  Map<String, dynamic>? get computationSnapshot {
    final value = _computationSnapshot;
    if (value == null) return null;
    if (_computationSnapshot is EqualUnmodifiableMapView)
      return _computationSnapshot;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String createdAt;

  @override
  String toString() {
    return 'PointsHistoryItemModel(id: $id, pointType: $pointType, status: $status, source: $source, points: $points, attendanceDate: $attendanceDate, reason: $reason, cancelReason: $cancelReason, permissionId: $permissionId, attendanceId: $attendanceId, expiresAt: $expiresAt, recomputedAt: $recomputedAt, computationSnapshot: $computationSnapshot, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsHistoryItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pointType, pointType) ||
                other.pointType == pointType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.attendanceDate, attendanceDate) ||
                other.attendanceDate == attendanceDate) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.cancelReason, cancelReason) ||
                other.cancelReason == cancelReason) &&
            (identical(other.permissionId, permissionId) ||
                other.permissionId == permissionId) &&
            (identical(other.attendanceId, attendanceId) ||
                other.attendanceId == attendanceId) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.recomputedAt, recomputedAt) ||
                other.recomputedAt == recomputedAt) &&
            const DeepCollectionEquality().equals(
              other._computationSnapshot,
              _computationSnapshot,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    pointType,
    status,
    source,
    points,
    attendanceDate,
    reason,
    cancelReason,
    permissionId,
    attendanceId,
    expiresAt,
    recomputedAt,
    const DeepCollectionEquality().hash(_computationSnapshot),
    createdAt,
  );

  /// Create a copy of PointsHistoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsHistoryItemModelImplCopyWith<_$PointsHistoryItemModelImpl>
  get copyWith =>
      __$$PointsHistoryItemModelImplCopyWithImpl<_$PointsHistoryItemModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsHistoryItemModelImplToJson(this);
  }
}

abstract class _PointsHistoryItemModel implements PointsHistoryItemModel {
  const factory _PointsHistoryItemModel({
    required final String id,
    required final String pointType,
    required final String status,
    required final String source,
    final int points,
    required final String attendanceDate,
    required final String reason,
    final String? cancelReason,
    final String? permissionId,
    final String? attendanceId,
    final String? expiresAt,
    final String? recomputedAt,
    final Map<String, dynamic>? computationSnapshot,
    required final String createdAt,
  }) = _$PointsHistoryItemModelImpl;

  factory _PointsHistoryItemModel.fromJson(Map<String, dynamic> json) =
      _$PointsHistoryItemModelImpl.fromJson;

  @override
  String get id;
  @override
  String get pointType;
  @override
  String get status;
  @override
  String get source;
  @override
  int get points;
  @override
  String get attendanceDate;
  @override
  String get reason;
  @override
  String? get cancelReason;
  @override
  String? get permissionId;
  @override
  String? get attendanceId;
  @override
  String? get expiresAt;
  @override
  String? get recomputedAt;
  @override
  Map<String, dynamic>? get computationSnapshot;
  @override
  String get createdAt;

  /// Create a copy of PointsHistoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsHistoryItemModelImplCopyWith<_$PointsHistoryItemModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PointsHistoryPageModel _$PointsHistoryPageModelFromJson(
  Map<String, dynamic> json,
) {
  return _PointsHistoryPageModel.fromJson(json);
}

/// @nodoc
mixin _$PointsHistoryPageModel {
  List<PointsHistoryItemModel> get items => throw _privateConstructorUsedError;
  int? get totalCount => throw _privateConstructorUsedError;
  int? get index => throw _privateConstructorUsedError;
  int? get itemCount => throw _privateConstructorUsedError;
  int? get totalPages => throw _privateConstructorUsedError;
  bool? get hasNext => throw _privateConstructorUsedError;
  bool? get hasPrevious => throw _privateConstructorUsedError;

  /// Serializes this PointsHistoryPageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsHistoryPageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsHistoryPageModelCopyWith<PointsHistoryPageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsHistoryPageModelCopyWith<$Res> {
  factory $PointsHistoryPageModelCopyWith(
    PointsHistoryPageModel value,
    $Res Function(PointsHistoryPageModel) then,
  ) = _$PointsHistoryPageModelCopyWithImpl<$Res, PointsHistoryPageModel>;
  @useResult
  $Res call({
    List<PointsHistoryItemModel> items,
    int? totalCount,
    int? index,
    int? itemCount,
    int? totalPages,
    bool? hasNext,
    bool? hasPrevious,
  });
}

/// @nodoc
class _$PointsHistoryPageModelCopyWithImpl<
  $Res,
  $Val extends PointsHistoryPageModel
>
    implements $PointsHistoryPageModelCopyWith<$Res> {
  _$PointsHistoryPageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsHistoryPageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalCount = freezed,
    Object? index = freezed,
    Object? itemCount = freezed,
    Object? totalPages = freezed,
    Object? hasNext = freezed,
    Object? hasPrevious = freezed,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<PointsHistoryItemModel>,
            totalCount: freezed == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            index: freezed == index
                ? _value.index
                : index // ignore: cast_nullable_to_non_nullable
                      as int?,
            itemCount: freezed == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalPages: freezed == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int?,
            hasNext: freezed == hasNext
                ? _value.hasNext
                : hasNext // ignore: cast_nullable_to_non_nullable
                      as bool?,
            hasPrevious: freezed == hasPrevious
                ? _value.hasPrevious
                : hasPrevious // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointsHistoryPageModelImplCopyWith<$Res>
    implements $PointsHistoryPageModelCopyWith<$Res> {
  factory _$$PointsHistoryPageModelImplCopyWith(
    _$PointsHistoryPageModelImpl value,
    $Res Function(_$PointsHistoryPageModelImpl) then,
  ) = __$$PointsHistoryPageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<PointsHistoryItemModel> items,
    int? totalCount,
    int? index,
    int? itemCount,
    int? totalPages,
    bool? hasNext,
    bool? hasPrevious,
  });
}

/// @nodoc
class __$$PointsHistoryPageModelImplCopyWithImpl<$Res>
    extends
        _$PointsHistoryPageModelCopyWithImpl<$Res, _$PointsHistoryPageModelImpl>
    implements _$$PointsHistoryPageModelImplCopyWith<$Res> {
  __$$PointsHistoryPageModelImplCopyWithImpl(
    _$PointsHistoryPageModelImpl _value,
    $Res Function(_$PointsHistoryPageModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsHistoryPageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalCount = freezed,
    Object? index = freezed,
    Object? itemCount = freezed,
    Object? totalPages = freezed,
    Object? hasNext = freezed,
    Object? hasPrevious = freezed,
  }) {
    return _then(
      _$PointsHistoryPageModelImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<PointsHistoryItemModel>,
        totalCount: freezed == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        index: freezed == index
            ? _value.index
            : index // ignore: cast_nullable_to_non_nullable
                  as int?,
        itemCount: freezed == itemCount
            ? _value.itemCount
            : itemCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalPages: freezed == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int?,
        hasNext: freezed == hasNext
            ? _value.hasNext
            : hasNext // ignore: cast_nullable_to_non_nullable
                  as bool?,
        hasPrevious: freezed == hasPrevious
            ? _value.hasPrevious
            : hasPrevious // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsHistoryPageModelImpl implements _PointsHistoryPageModel {
  const _$PointsHistoryPageModelImpl({
    final List<PointsHistoryItemModel> items = const <PointsHistoryItemModel>[],
    this.totalCount,
    this.index,
    this.itemCount,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
  }) : _items = items;

  factory _$PointsHistoryPageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsHistoryPageModelImplFromJson(json);

  final List<PointsHistoryItemModel> _items;
  @override
  @JsonKey()
  List<PointsHistoryItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int? totalCount;
  @override
  final int? index;
  @override
  final int? itemCount;
  @override
  final int? totalPages;
  @override
  final bool? hasNext;
  @override
  final bool? hasPrevious;

  @override
  String toString() {
    return 'PointsHistoryPageModel(items: $items, totalCount: $totalCount, index: $index, itemCount: $itemCount, totalPages: $totalPages, hasNext: $hasNext, hasPrevious: $hasPrevious)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsHistoryPageModelImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.hasPrevious, hasPrevious) ||
                other.hasPrevious == hasPrevious));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    totalCount,
    index,
    itemCount,
    totalPages,
    hasNext,
    hasPrevious,
  );

  /// Create a copy of PointsHistoryPageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsHistoryPageModelImplCopyWith<_$PointsHistoryPageModelImpl>
  get copyWith =>
      __$$PointsHistoryPageModelImplCopyWithImpl<_$PointsHistoryPageModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsHistoryPageModelImplToJson(this);
  }
}

abstract class _PointsHistoryPageModel implements PointsHistoryPageModel {
  const factory _PointsHistoryPageModel({
    final List<PointsHistoryItemModel> items,
    final int? totalCount,
    final int? index,
    final int? itemCount,
    final int? totalPages,
    final bool? hasNext,
    final bool? hasPrevious,
  }) = _$PointsHistoryPageModelImpl;

  factory _PointsHistoryPageModel.fromJson(Map<String, dynamic> json) =
      _$PointsHistoryPageModelImpl.fromJson;

  @override
  List<PointsHistoryItemModel> get items;
  @override
  int? get totalCount;
  @override
  int? get index;
  @override
  int? get itemCount;
  @override
  int? get totalPages;
  @override
  bool? get hasNext;
  @override
  bool? get hasPrevious;

  /// Create a copy of PointsHistoryPageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsHistoryPageModelImplCopyWith<_$PointsHistoryPageModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PointsHistoryResponseModel _$PointsHistoryResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _PointsHistoryResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PointsHistoryResponseModel {
  PointsHistoryPageModel? get value => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  int? get limit => throw _privateConstructorUsedError;
  bool? get isSuccess => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;

  /// Serializes this PointsHistoryResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsHistoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsHistoryResponseModelCopyWith<PointsHistoryResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsHistoryResponseModelCopyWith<$Res> {
  factory $PointsHistoryResponseModelCopyWith(
    PointsHistoryResponseModel value,
    $Res Function(PointsHistoryResponseModel) then,
  ) =
      _$PointsHistoryResponseModelCopyWithImpl<
        $Res,
        PointsHistoryResponseModel
      >;
  @useResult
  $Res call({
    PointsHistoryPageModel? value,
    int? total,
    int? page,
    int? limit,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  });

  $PointsHistoryPageModelCopyWith<$Res>? get value;
}

/// @nodoc
class _$PointsHistoryResponseModelCopyWithImpl<
  $Res,
  $Val extends PointsHistoryResponseModel
>
    implements $PointsHistoryResponseModelCopyWith<$Res> {
  _$PointsHistoryResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsHistoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? total = freezed,
    Object? page = freezed,
    Object? limit = freezed,
    Object? isSuccess = freezed,
    Object? successMessage = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _value.copyWith(
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as PointsHistoryPageModel?,
            total: freezed == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int?,
            page: freezed == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int?,
            limit: freezed == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int?,
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

  /// Create a copy of PointsHistoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointsHistoryPageModelCopyWith<$Res>? get value {
    if (_value.value == null) {
      return null;
    }

    return $PointsHistoryPageModelCopyWith<$Res>(_value.value!, (value) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PointsHistoryResponseModelImplCopyWith<$Res>
    implements $PointsHistoryResponseModelCopyWith<$Res> {
  factory _$$PointsHistoryResponseModelImplCopyWith(
    _$PointsHistoryResponseModelImpl value,
    $Res Function(_$PointsHistoryResponseModelImpl) then,
  ) = __$$PointsHistoryResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PointsHistoryPageModel? value,
    int? total,
    int? page,
    int? limit,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  });

  @override
  $PointsHistoryPageModelCopyWith<$Res>? get value;
}

/// @nodoc
class __$$PointsHistoryResponseModelImplCopyWithImpl<$Res>
    extends
        _$PointsHistoryResponseModelCopyWithImpl<
          $Res,
          _$PointsHistoryResponseModelImpl
        >
    implements _$$PointsHistoryResponseModelImplCopyWith<$Res> {
  __$$PointsHistoryResponseModelImplCopyWithImpl(
    _$PointsHistoryResponseModelImpl _value,
    $Res Function(_$PointsHistoryResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsHistoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? total = freezed,
    Object? page = freezed,
    Object? limit = freezed,
    Object? isSuccess = freezed,
    Object? successMessage = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _$PointsHistoryResponseModelImpl(
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as PointsHistoryPageModel?,
        total: freezed == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int?,
        page: freezed == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int?,
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$PointsHistoryResponseModelImpl implements _PointsHistoryResponseModel {
  const _$PointsHistoryResponseModelImpl({
    this.value,
    this.total,
    this.page,
    this.limit,
    this.isSuccess,
    this.successMessage,
    final List<String>? errors,
  }) : _errors = errors;

  factory _$PointsHistoryResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PointsHistoryResponseModelImplFromJson(json);

  @override
  final PointsHistoryPageModel? value;
  @override
  final int? total;
  @override
  final int? page;
  @override
  final int? limit;
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
    return 'PointsHistoryResponseModel(value: $value, total: $total, page: $page, limit: $limit, isSuccess: $isSuccess, successMessage: $successMessage, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsHistoryResponseModelImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
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
    total,
    page,
    limit,
    isSuccess,
    successMessage,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of PointsHistoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsHistoryResponseModelImplCopyWith<_$PointsHistoryResponseModelImpl>
  get copyWith =>
      __$$PointsHistoryResponseModelImplCopyWithImpl<
        _$PointsHistoryResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsHistoryResponseModelImplToJson(this);
  }
}

abstract class _PointsHistoryResponseModel
    implements PointsHistoryResponseModel {
  const factory _PointsHistoryResponseModel({
    final PointsHistoryPageModel? value,
    final int? total,
    final int? page,
    final int? limit,
    final bool? isSuccess,
    final String? successMessage,
    final List<String>? errors,
  }) = _$PointsHistoryResponseModelImpl;

  factory _PointsHistoryResponseModel.fromJson(Map<String, dynamic> json) =
      _$PointsHistoryResponseModelImpl.fromJson;

  @override
  PointsHistoryPageModel? get value;
  @override
  int? get total;
  @override
  int? get page;
  @override
  int? get limit;
  @override
  bool? get isSuccess;
  @override
  String? get successMessage;
  @override
  List<String>? get errors;

  /// Create a copy of PointsHistoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsHistoryResponseModelImplCopyWith<_$PointsHistoryResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
