// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points_leaderboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PointsLeaderboardEntryModel _$PointsLeaderboardEntryModelFromJson(
  Map<String, dynamic> json,
) {
  return _PointsLeaderboardEntryModel.fromJson(json);
}

/// @nodoc
mixin _$PointsLeaderboardEntryModel {
  int get rank => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get departmentName => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  bool get isCurrentUser => throw _privateConstructorUsedError;

  /// Serializes this PointsLeaderboardEntryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsLeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsLeaderboardEntryModelCopyWith<PointsLeaderboardEntryModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsLeaderboardEntryModelCopyWith<$Res> {
  factory $PointsLeaderboardEntryModelCopyWith(
    PointsLeaderboardEntryModel value,
    $Res Function(PointsLeaderboardEntryModel) then,
  ) =
      _$PointsLeaderboardEntryModelCopyWithImpl<
        $Res,
        PointsLeaderboardEntryModel
      >;
  @useResult
  $Res call({
    int rank,
    String employeeId,
    String name,
    String? avatar,
    String? departmentName,
    int points,
    int currentStreak,
    String level,
    bool isCurrentUser,
  });
}

/// @nodoc
class _$PointsLeaderboardEntryModelCopyWithImpl<
  $Res,
  $Val extends PointsLeaderboardEntryModel
>
    implements $PointsLeaderboardEntryModelCopyWith<$Res> {
  _$PointsLeaderboardEntryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsLeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? employeeId = null,
    Object? name = null,
    Object? avatar = freezed,
    Object? departmentName = freezed,
    Object? points = null,
    Object? currentStreak = null,
    Object? level = null,
    Object? isCurrentUser = null,
  }) {
    return _then(
      _value.copyWith(
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            employeeId: null == employeeId
                ? _value.employeeId
                : employeeId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            avatar: freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            departmentName: freezed == departmentName
                ? _value.departmentName
                : departmentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as String,
            isCurrentUser: null == isCurrentUser
                ? _value.isCurrentUser
                : isCurrentUser // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointsLeaderboardEntryModelImplCopyWith<$Res>
    implements $PointsLeaderboardEntryModelCopyWith<$Res> {
  factory _$$PointsLeaderboardEntryModelImplCopyWith(
    _$PointsLeaderboardEntryModelImpl value,
    $Res Function(_$PointsLeaderboardEntryModelImpl) then,
  ) = __$$PointsLeaderboardEntryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int rank,
    String employeeId,
    String name,
    String? avatar,
    String? departmentName,
    int points,
    int currentStreak,
    String level,
    bool isCurrentUser,
  });
}

/// @nodoc
class __$$PointsLeaderboardEntryModelImplCopyWithImpl<$Res>
    extends
        _$PointsLeaderboardEntryModelCopyWithImpl<
          $Res,
          _$PointsLeaderboardEntryModelImpl
        >
    implements _$$PointsLeaderboardEntryModelImplCopyWith<$Res> {
  __$$PointsLeaderboardEntryModelImplCopyWithImpl(
    _$PointsLeaderboardEntryModelImpl _value,
    $Res Function(_$PointsLeaderboardEntryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsLeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? employeeId = null,
    Object? name = null,
    Object? avatar = freezed,
    Object? departmentName = freezed,
    Object? points = null,
    Object? currentStreak = null,
    Object? level = null,
    Object? isCurrentUser = null,
  }) {
    return _then(
      _$PointsLeaderboardEntryModelImpl(
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        employeeId: null == employeeId
            ? _value.employeeId
            : employeeId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        avatar: freezed == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        departmentName: freezed == departmentName
            ? _value.departmentName
            : departmentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String,
        isCurrentUser: null == isCurrentUser
            ? _value.isCurrentUser
            : isCurrentUser // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsLeaderboardEntryModelImpl
    implements _PointsLeaderboardEntryModel {
  const _$PointsLeaderboardEntryModelImpl({
    required this.rank,
    required this.employeeId,
    required this.name,
    this.avatar,
    this.departmentName,
    this.points = 0,
    this.currentStreak = 0,
    this.level = 'Bronze',
    this.isCurrentUser = false,
  });

  factory _$PointsLeaderboardEntryModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PointsLeaderboardEntryModelImplFromJson(json);

  @override
  final int rank;
  @override
  final String employeeId;
  @override
  final String name;
  @override
  final String? avatar;
  @override
  final String? departmentName;
  @override
  @JsonKey()
  final int points;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final String level;
  @override
  @JsonKey()
  final bool isCurrentUser;

  @override
  String toString() {
    return 'PointsLeaderboardEntryModel(rank: $rank, employeeId: $employeeId, name: $name, avatar: $avatar, departmentName: $departmentName, points: $points, currentStreak: $currentStreak, level: $level, isCurrentUser: $isCurrentUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsLeaderboardEntryModelImpl &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.departmentName, departmentName) ||
                other.departmentName == departmentName) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.isCurrentUser, isCurrentUser) ||
                other.isCurrentUser == isCurrentUser));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    rank,
    employeeId,
    name,
    avatar,
    departmentName,
    points,
    currentStreak,
    level,
    isCurrentUser,
  );

  /// Create a copy of PointsLeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsLeaderboardEntryModelImplCopyWith<_$PointsLeaderboardEntryModelImpl>
  get copyWith =>
      __$$PointsLeaderboardEntryModelImplCopyWithImpl<
        _$PointsLeaderboardEntryModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsLeaderboardEntryModelImplToJson(this);
  }
}

abstract class _PointsLeaderboardEntryModel
    implements PointsLeaderboardEntryModel {
  const factory _PointsLeaderboardEntryModel({
    required final int rank,
    required final String employeeId,
    required final String name,
    final String? avatar,
    final String? departmentName,
    final int points,
    final int currentStreak,
    final String level,
    final bool isCurrentUser,
  }) = _$PointsLeaderboardEntryModelImpl;

  factory _PointsLeaderboardEntryModel.fromJson(Map<String, dynamic> json) =
      _$PointsLeaderboardEntryModelImpl.fromJson;

  @override
  int get rank;
  @override
  String get employeeId;
  @override
  String get name;
  @override
  String? get avatar;
  @override
  String? get departmentName;
  @override
  int get points;
  @override
  int get currentStreak;
  @override
  String get level;
  @override
  bool get isCurrentUser;

  /// Create a copy of PointsLeaderboardEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsLeaderboardEntryModelImplCopyWith<_$PointsLeaderboardEntryModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PointsLeaderboardResponseModel _$PointsLeaderboardResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _PointsLeaderboardResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PointsLeaderboardResponseModel {
  List<PointsLeaderboardEntryModel> get value =>
      throw _privateConstructorUsedError;
  bool? get isSuccess => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;

  /// Serializes this PointsLeaderboardResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsLeaderboardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsLeaderboardResponseModelCopyWith<PointsLeaderboardResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsLeaderboardResponseModelCopyWith<$Res> {
  factory $PointsLeaderboardResponseModelCopyWith(
    PointsLeaderboardResponseModel value,
    $Res Function(PointsLeaderboardResponseModel) then,
  ) =
      _$PointsLeaderboardResponseModelCopyWithImpl<
        $Res,
        PointsLeaderboardResponseModel
      >;
  @useResult
  $Res call({
    List<PointsLeaderboardEntryModel> value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  });
}

/// @nodoc
class _$PointsLeaderboardResponseModelCopyWithImpl<
  $Res,
  $Val extends PointsLeaderboardResponseModel
>
    implements $PointsLeaderboardResponseModelCopyWith<$Res> {
  _$PointsLeaderboardResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsLeaderboardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? isSuccess = freezed,
    Object? successMessage = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _value.copyWith(
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as List<PointsLeaderboardEntryModel>,
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
}

/// @nodoc
abstract class _$$PointsLeaderboardResponseModelImplCopyWith<$Res>
    implements $PointsLeaderboardResponseModelCopyWith<$Res> {
  factory _$$PointsLeaderboardResponseModelImplCopyWith(
    _$PointsLeaderboardResponseModelImpl value,
    $Res Function(_$PointsLeaderboardResponseModelImpl) then,
  ) = __$$PointsLeaderboardResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<PointsLeaderboardEntryModel> value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  });
}

/// @nodoc
class __$$PointsLeaderboardResponseModelImplCopyWithImpl<$Res>
    extends
        _$PointsLeaderboardResponseModelCopyWithImpl<
          $Res,
          _$PointsLeaderboardResponseModelImpl
        >
    implements _$$PointsLeaderboardResponseModelImplCopyWith<$Res> {
  __$$PointsLeaderboardResponseModelImplCopyWithImpl(
    _$PointsLeaderboardResponseModelImpl _value,
    $Res Function(_$PointsLeaderboardResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsLeaderboardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? isSuccess = freezed,
    Object? successMessage = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _$PointsLeaderboardResponseModelImpl(
        value: null == value
            ? _value._value
            : value // ignore: cast_nullable_to_non_nullable
                  as List<PointsLeaderboardEntryModel>,
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
class _$PointsLeaderboardResponseModelImpl
    implements _PointsLeaderboardResponseModel {
  const _$PointsLeaderboardResponseModelImpl({
    final List<PointsLeaderboardEntryModel> value =
        const <PointsLeaderboardEntryModel>[],
    this.isSuccess,
    this.successMessage,
    final List<String>? errors,
  }) : _value = value,
       _errors = errors;

  factory _$PointsLeaderboardResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PointsLeaderboardResponseModelImplFromJson(json);

  final List<PointsLeaderboardEntryModel> _value;
  @override
  @JsonKey()
  List<PointsLeaderboardEntryModel> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

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
    return 'PointsLeaderboardResponseModel(value: $value, isSuccess: $isSuccess, successMessage: $successMessage, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsLeaderboardResponseModelImpl &&
            const DeepCollectionEquality().equals(other._value, _value) &&
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
    const DeepCollectionEquality().hash(_value),
    isSuccess,
    successMessage,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of PointsLeaderboardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsLeaderboardResponseModelImplCopyWith<
    _$PointsLeaderboardResponseModelImpl
  >
  get copyWith =>
      __$$PointsLeaderboardResponseModelImplCopyWithImpl<
        _$PointsLeaderboardResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsLeaderboardResponseModelImplToJson(this);
  }
}

abstract class _PointsLeaderboardResponseModel
    implements PointsLeaderboardResponseModel {
  const factory _PointsLeaderboardResponseModel({
    final List<PointsLeaderboardEntryModel> value,
    final bool? isSuccess,
    final String? successMessage,
    final List<String>? errors,
  }) = _$PointsLeaderboardResponseModelImpl;

  factory _PointsLeaderboardResponseModel.fromJson(Map<String, dynamic> json) =
      _$PointsLeaderboardResponseModelImpl.fromJson;

  @override
  List<PointsLeaderboardEntryModel> get value;
  @override
  bool? get isSuccess;
  @override
  String? get successMessage;
  @override
  List<String>? get errors;

  /// Create a copy of PointsLeaderboardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsLeaderboardResponseModelImplCopyWith<
    _$PointsLeaderboardResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
