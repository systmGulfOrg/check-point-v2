// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PointsBalancesModel _$PointsBalancesModelFromJson(Map<String, dynamic> json) {
  return _PointsBalancesModel.fromJson(json);
}

/// @nodoc
mixin _$PointsBalancesModel {
  int get greenConfirmed => throw _privateConstructorUsedError;
  int get greenPending => throw _privateConstructorUsedError;
  int get red => throw _privateConstructorUsedError;
  int get black => throw _privateConstructorUsedError;
  int get expiringSoonGreen => throw _privateConstructorUsedError;

  /// Serializes this PointsBalancesModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsBalancesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsBalancesModelCopyWith<PointsBalancesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsBalancesModelCopyWith<$Res> {
  factory $PointsBalancesModelCopyWith(
    PointsBalancesModel value,
    $Res Function(PointsBalancesModel) then,
  ) = _$PointsBalancesModelCopyWithImpl<$Res, PointsBalancesModel>;
  @useResult
  $Res call({
    int greenConfirmed,
    int greenPending,
    int red,
    int black,
    int expiringSoonGreen,
  });
}

/// @nodoc
class _$PointsBalancesModelCopyWithImpl<$Res, $Val extends PointsBalancesModel>
    implements $PointsBalancesModelCopyWith<$Res> {
  _$PointsBalancesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsBalancesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? greenConfirmed = null,
    Object? greenPending = null,
    Object? red = null,
    Object? black = null,
    Object? expiringSoonGreen = null,
  }) {
    return _then(
      _value.copyWith(
            greenConfirmed: null == greenConfirmed
                ? _value.greenConfirmed
                : greenConfirmed // ignore: cast_nullable_to_non_nullable
                      as int,
            greenPending: null == greenPending
                ? _value.greenPending
                : greenPending // ignore: cast_nullable_to_non_nullable
                      as int,
            red: null == red
                ? _value.red
                : red // ignore: cast_nullable_to_non_nullable
                      as int,
            black: null == black
                ? _value.black
                : black // ignore: cast_nullable_to_non_nullable
                      as int,
            expiringSoonGreen: null == expiringSoonGreen
                ? _value.expiringSoonGreen
                : expiringSoonGreen // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointsBalancesModelImplCopyWith<$Res>
    implements $PointsBalancesModelCopyWith<$Res> {
  factory _$$PointsBalancesModelImplCopyWith(
    _$PointsBalancesModelImpl value,
    $Res Function(_$PointsBalancesModelImpl) then,
  ) = __$$PointsBalancesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int greenConfirmed,
    int greenPending,
    int red,
    int black,
    int expiringSoonGreen,
  });
}

/// @nodoc
class __$$PointsBalancesModelImplCopyWithImpl<$Res>
    extends _$PointsBalancesModelCopyWithImpl<$Res, _$PointsBalancesModelImpl>
    implements _$$PointsBalancesModelImplCopyWith<$Res> {
  __$$PointsBalancesModelImplCopyWithImpl(
    _$PointsBalancesModelImpl _value,
    $Res Function(_$PointsBalancesModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsBalancesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? greenConfirmed = null,
    Object? greenPending = null,
    Object? red = null,
    Object? black = null,
    Object? expiringSoonGreen = null,
  }) {
    return _then(
      _$PointsBalancesModelImpl(
        greenConfirmed: null == greenConfirmed
            ? _value.greenConfirmed
            : greenConfirmed // ignore: cast_nullable_to_non_nullable
                  as int,
        greenPending: null == greenPending
            ? _value.greenPending
            : greenPending // ignore: cast_nullable_to_non_nullable
                  as int,
        red: null == red
            ? _value.red
            : red // ignore: cast_nullable_to_non_nullable
                  as int,
        black: null == black
            ? _value.black
            : black // ignore: cast_nullable_to_non_nullable
                  as int,
        expiringSoonGreen: null == expiringSoonGreen
            ? _value.expiringSoonGreen
            : expiringSoonGreen // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsBalancesModelImpl implements _PointsBalancesModel {
  const _$PointsBalancesModelImpl({
    this.greenConfirmed = 0,
    this.greenPending = 0,
    this.red = 0,
    this.black = 0,
    this.expiringSoonGreen = 0,
  });

  factory _$PointsBalancesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsBalancesModelImplFromJson(json);

  @override
  @JsonKey()
  final int greenConfirmed;
  @override
  @JsonKey()
  final int greenPending;
  @override
  @JsonKey()
  final int red;
  @override
  @JsonKey()
  final int black;
  @override
  @JsonKey()
  final int expiringSoonGreen;

  @override
  String toString() {
    return 'PointsBalancesModel(greenConfirmed: $greenConfirmed, greenPending: $greenPending, red: $red, black: $black, expiringSoonGreen: $expiringSoonGreen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsBalancesModelImpl &&
            (identical(other.greenConfirmed, greenConfirmed) ||
                other.greenConfirmed == greenConfirmed) &&
            (identical(other.greenPending, greenPending) ||
                other.greenPending == greenPending) &&
            (identical(other.red, red) || other.red == red) &&
            (identical(other.black, black) || other.black == black) &&
            (identical(other.expiringSoonGreen, expiringSoonGreen) ||
                other.expiringSoonGreen == expiringSoonGreen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    greenConfirmed,
    greenPending,
    red,
    black,
    expiringSoonGreen,
  );

  /// Create a copy of PointsBalancesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsBalancesModelImplCopyWith<_$PointsBalancesModelImpl> get copyWith =>
      __$$PointsBalancesModelImplCopyWithImpl<_$PointsBalancesModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsBalancesModelImplToJson(this);
  }
}

abstract class _PointsBalancesModel implements PointsBalancesModel {
  const factory _PointsBalancesModel({
    final int greenConfirmed,
    final int greenPending,
    final int red,
    final int black,
    final int expiringSoonGreen,
  }) = _$PointsBalancesModelImpl;

  factory _PointsBalancesModel.fromJson(Map<String, dynamic> json) =
      _$PointsBalancesModelImpl.fromJson;

  @override
  int get greenConfirmed;
  @override
  int get greenPending;
  @override
  int get red;
  @override
  int get black;
  @override
  int get expiringSoonGreen;

  /// Create a copy of PointsBalancesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsBalancesModelImplCopyWith<_$PointsBalancesModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PointsLevelModel _$PointsLevelModelFromJson(Map<String, dynamic> json) {
  return _PointsLevelModel.fromJson(json);
}

/// @nodoc
mixin _$PointsLevelModel {
  String get tier => throw _privateConstructorUsedError;
  int get currentPoints => throw _privateConstructorUsedError;
  int get nextLevelPoints => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;

  /// Serializes this PointsLevelModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsLevelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsLevelModelCopyWith<PointsLevelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsLevelModelCopyWith<$Res> {
  factory $PointsLevelModelCopyWith(
    PointsLevelModel value,
    $Res Function(PointsLevelModel) then,
  ) = _$PointsLevelModelCopyWithImpl<$Res, PointsLevelModel>;
  @useResult
  $Res call({
    String tier,
    int currentPoints,
    int nextLevelPoints,
    double progress,
  });
}

/// @nodoc
class _$PointsLevelModelCopyWithImpl<$Res, $Val extends PointsLevelModel>
    implements $PointsLevelModelCopyWith<$Res> {
  _$PointsLevelModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsLevelModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tier = null,
    Object? currentPoints = null,
    Object? nextLevelPoints = null,
    Object? progress = null,
  }) {
    return _then(
      _value.copyWith(
            tier: null == tier
                ? _value.tier
                : tier // ignore: cast_nullable_to_non_nullable
                      as String,
            currentPoints: null == currentPoints
                ? _value.currentPoints
                : currentPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            nextLevelPoints: null == nextLevelPoints
                ? _value.nextLevelPoints
                : nextLevelPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointsLevelModelImplCopyWith<$Res>
    implements $PointsLevelModelCopyWith<$Res> {
  factory _$$PointsLevelModelImplCopyWith(
    _$PointsLevelModelImpl value,
    $Res Function(_$PointsLevelModelImpl) then,
  ) = __$$PointsLevelModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String tier,
    int currentPoints,
    int nextLevelPoints,
    double progress,
  });
}

/// @nodoc
class __$$PointsLevelModelImplCopyWithImpl<$Res>
    extends _$PointsLevelModelCopyWithImpl<$Res, _$PointsLevelModelImpl>
    implements _$$PointsLevelModelImplCopyWith<$Res> {
  __$$PointsLevelModelImplCopyWithImpl(
    _$PointsLevelModelImpl _value,
    $Res Function(_$PointsLevelModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsLevelModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tier = null,
    Object? currentPoints = null,
    Object? nextLevelPoints = null,
    Object? progress = null,
  }) {
    return _then(
      _$PointsLevelModelImpl(
        tier: null == tier
            ? _value.tier
            : tier // ignore: cast_nullable_to_non_nullable
                  as String,
        currentPoints: null == currentPoints
            ? _value.currentPoints
            : currentPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        nextLevelPoints: null == nextLevelPoints
            ? _value.nextLevelPoints
            : nextLevelPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsLevelModelImpl implements _PointsLevelModel {
  const _$PointsLevelModelImpl({
    this.tier = 'Bronze',
    this.currentPoints = 0,
    this.nextLevelPoints = 101,
    this.progress = 0.0,
  });

  factory _$PointsLevelModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsLevelModelImplFromJson(json);

  @override
  @JsonKey()
  final String tier;
  @override
  @JsonKey()
  final int currentPoints;
  @override
  @JsonKey()
  final int nextLevelPoints;
  @override
  @JsonKey()
  final double progress;

  @override
  String toString() {
    return 'PointsLevelModel(tier: $tier, currentPoints: $currentPoints, nextLevelPoints: $nextLevelPoints, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsLevelModelImpl &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.currentPoints, currentPoints) ||
                other.currentPoints == currentPoints) &&
            (identical(other.nextLevelPoints, nextLevelPoints) ||
                other.nextLevelPoints == nextLevelPoints) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tier, currentPoints, nextLevelPoints, progress);

  /// Create a copy of PointsLevelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsLevelModelImplCopyWith<_$PointsLevelModelImpl> get copyWith =>
      __$$PointsLevelModelImplCopyWithImpl<_$PointsLevelModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsLevelModelImplToJson(this);
  }
}

abstract class _PointsLevelModel implements PointsLevelModel {
  const factory _PointsLevelModel({
    final String tier,
    final int currentPoints,
    final int nextLevelPoints,
    final double progress,
  }) = _$PointsLevelModelImpl;

  factory _PointsLevelModel.fromJson(Map<String, dynamic> json) =
      _$PointsLevelModelImpl.fromJson;

  @override
  String get tier;
  @override
  int get currentPoints;
  @override
  int get nextLevelPoints;
  @override
  double get progress;

  /// Create a copy of PointsLevelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsLevelModelImplCopyWith<_$PointsLevelModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PointsStreakModel _$PointsStreakModelFromJson(Map<String, dynamic> json) {
  return _PointsStreakModel.fromJson(json);
}

/// @nodoc
mixin _$PointsStreakModel {
  int get currentStreak => throw _privateConstructorUsedError;
  int get highestStreak => throw _privateConstructorUsedError;

  /// Serializes this PointsStreakModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsStreakModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsStreakModelCopyWith<PointsStreakModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsStreakModelCopyWith<$Res> {
  factory $PointsStreakModelCopyWith(
    PointsStreakModel value,
    $Res Function(PointsStreakModel) then,
  ) = _$PointsStreakModelCopyWithImpl<$Res, PointsStreakModel>;
  @useResult
  $Res call({int currentStreak, int highestStreak});
}

/// @nodoc
class _$PointsStreakModelCopyWithImpl<$Res, $Val extends PointsStreakModel>
    implements $PointsStreakModelCopyWith<$Res> {
  _$PointsStreakModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsStreakModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? currentStreak = null, Object? highestStreak = null}) {
    return _then(
      _value.copyWith(
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            highestStreak: null == highestStreak
                ? _value.highestStreak
                : highestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointsStreakModelImplCopyWith<$Res>
    implements $PointsStreakModelCopyWith<$Res> {
  factory _$$PointsStreakModelImplCopyWith(
    _$PointsStreakModelImpl value,
    $Res Function(_$PointsStreakModelImpl) then,
  ) = __$$PointsStreakModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int currentStreak, int highestStreak});
}

/// @nodoc
class __$$PointsStreakModelImplCopyWithImpl<$Res>
    extends _$PointsStreakModelCopyWithImpl<$Res, _$PointsStreakModelImpl>
    implements _$$PointsStreakModelImplCopyWith<$Res> {
  __$$PointsStreakModelImplCopyWithImpl(
    _$PointsStreakModelImpl _value,
    $Res Function(_$PointsStreakModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsStreakModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? currentStreak = null, Object? highestStreak = null}) {
    return _then(
      _$PointsStreakModelImpl(
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        highestStreak: null == highestStreak
            ? _value.highestStreak
            : highestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsStreakModelImpl implements _PointsStreakModel {
  const _$PointsStreakModelImpl({
    this.currentStreak = 0,
    this.highestStreak = 0,
  });

  factory _$PointsStreakModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsStreakModelImplFromJson(json);

  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int highestStreak;

  @override
  String toString() {
    return 'PointsStreakModel(currentStreak: $currentStreak, highestStreak: $highestStreak)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsStreakModelImpl &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.highestStreak, highestStreak) ||
                other.highestStreak == highestStreak));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentStreak, highestStreak);

  /// Create a copy of PointsStreakModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsStreakModelImplCopyWith<_$PointsStreakModelImpl> get copyWith =>
      __$$PointsStreakModelImplCopyWithImpl<_$PointsStreakModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsStreakModelImplToJson(this);
  }
}

abstract class _PointsStreakModel implements PointsStreakModel {
  const factory _PointsStreakModel({
    final int currentStreak,
    final int highestStreak,
  }) = _$PointsStreakModelImpl;

  factory _PointsStreakModel.fromJson(Map<String, dynamic> json) =
      _$PointsStreakModelImpl.fromJson;

  @override
  int get currentStreak;
  @override
  int get highestStreak;

  /// Create a copy of PointsStreakModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsStreakModelImplCopyWith<_$PointsStreakModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PointsSettingsModel _$PointsSettingsModelFromJson(Map<String, dynamic> json) {
  return _PointsSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$PointsSettingsModel {
  int get redExchangeRate => throw _privateConstructorUsedError;
  int get blackExchangeCost => throw _privateConstructorUsedError;
  bool get tieredRateEnabled => throw _privateConstructorUsedError;
  int get graceMinutes => throw _privateConstructorUsedError;

  /// Serializes this PointsSettingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsSettingsModelCopyWith<PointsSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsSettingsModelCopyWith<$Res> {
  factory $PointsSettingsModelCopyWith(
    PointsSettingsModel value,
    $Res Function(PointsSettingsModel) then,
  ) = _$PointsSettingsModelCopyWithImpl<$Res, PointsSettingsModel>;
  @useResult
  $Res call({
    int redExchangeRate,
    int blackExchangeCost,
    bool tieredRateEnabled,
    int graceMinutes,
  });
}

/// @nodoc
class _$PointsSettingsModelCopyWithImpl<$Res, $Val extends PointsSettingsModel>
    implements $PointsSettingsModelCopyWith<$Res> {
  _$PointsSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? redExchangeRate = null,
    Object? blackExchangeCost = null,
    Object? tieredRateEnabled = null,
    Object? graceMinutes = null,
  }) {
    return _then(
      _value.copyWith(
            redExchangeRate: null == redExchangeRate
                ? _value.redExchangeRate
                : redExchangeRate // ignore: cast_nullable_to_non_nullable
                      as int,
            blackExchangeCost: null == blackExchangeCost
                ? _value.blackExchangeCost
                : blackExchangeCost // ignore: cast_nullable_to_non_nullable
                      as int,
            tieredRateEnabled: null == tieredRateEnabled
                ? _value.tieredRateEnabled
                : tieredRateEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            graceMinutes: null == graceMinutes
                ? _value.graceMinutes
                : graceMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointsSettingsModelImplCopyWith<$Res>
    implements $PointsSettingsModelCopyWith<$Res> {
  factory _$$PointsSettingsModelImplCopyWith(
    _$PointsSettingsModelImpl value,
    $Res Function(_$PointsSettingsModelImpl) then,
  ) = __$$PointsSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int redExchangeRate,
    int blackExchangeCost,
    bool tieredRateEnabled,
    int graceMinutes,
  });
}

/// @nodoc
class __$$PointsSettingsModelImplCopyWithImpl<$Res>
    extends _$PointsSettingsModelCopyWithImpl<$Res, _$PointsSettingsModelImpl>
    implements _$$PointsSettingsModelImplCopyWith<$Res> {
  __$$PointsSettingsModelImplCopyWithImpl(
    _$PointsSettingsModelImpl _value,
    $Res Function(_$PointsSettingsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? redExchangeRate = null,
    Object? blackExchangeCost = null,
    Object? tieredRateEnabled = null,
    Object? graceMinutes = null,
  }) {
    return _then(
      _$PointsSettingsModelImpl(
        redExchangeRate: null == redExchangeRate
            ? _value.redExchangeRate
            : redExchangeRate // ignore: cast_nullable_to_non_nullable
                  as int,
        blackExchangeCost: null == blackExchangeCost
            ? _value.blackExchangeCost
            : blackExchangeCost // ignore: cast_nullable_to_non_nullable
                  as int,
        tieredRateEnabled: null == tieredRateEnabled
            ? _value.tieredRateEnabled
            : tieredRateEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        graceMinutes: null == graceMinutes
            ? _value.graceMinutes
            : graceMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsSettingsModelImpl implements _PointsSettingsModel {
  const _$PointsSettingsModelImpl({
    this.redExchangeRate = 1,
    this.blackExchangeCost = 30,
    this.tieredRateEnabled = false,
    this.graceMinutes = 10,
  });

  factory _$PointsSettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsSettingsModelImplFromJson(json);

  @override
  @JsonKey()
  final int redExchangeRate;
  @override
  @JsonKey()
  final int blackExchangeCost;
  @override
  @JsonKey()
  final bool tieredRateEnabled;
  @override
  @JsonKey()
  final int graceMinutes;

  @override
  String toString() {
    return 'PointsSettingsModel(redExchangeRate: $redExchangeRate, blackExchangeCost: $blackExchangeCost, tieredRateEnabled: $tieredRateEnabled, graceMinutes: $graceMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsSettingsModelImpl &&
            (identical(other.redExchangeRate, redExchangeRate) ||
                other.redExchangeRate == redExchangeRate) &&
            (identical(other.blackExchangeCost, blackExchangeCost) ||
                other.blackExchangeCost == blackExchangeCost) &&
            (identical(other.tieredRateEnabled, tieredRateEnabled) ||
                other.tieredRateEnabled == tieredRateEnabled) &&
            (identical(other.graceMinutes, graceMinutes) ||
                other.graceMinutes == graceMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    redExchangeRate,
    blackExchangeCost,
    tieredRateEnabled,
    graceMinutes,
  );

  /// Create a copy of PointsSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsSettingsModelImplCopyWith<_$PointsSettingsModelImpl> get copyWith =>
      __$$PointsSettingsModelImplCopyWithImpl<_$PointsSettingsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsSettingsModelImplToJson(this);
  }
}

abstract class _PointsSettingsModel implements PointsSettingsModel {
  const factory _PointsSettingsModel({
    final int redExchangeRate,
    final int blackExchangeCost,
    final bool tieredRateEnabled,
    final int graceMinutes,
  }) = _$PointsSettingsModelImpl;

  factory _PointsSettingsModel.fromJson(Map<String, dynamic> json) =
      _$PointsSettingsModelImpl.fromJson;

  @override
  int get redExchangeRate;
  @override
  int get blackExchangeCost;
  @override
  bool get tieredRateEnabled;
  @override
  int get graceMinutes;

  /// Create a copy of PointsSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsSettingsModelImplCopyWith<_$PointsSettingsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PointsSummaryModel _$PointsSummaryModelFromJson(Map<String, dynamic> json) {
  return _PointsSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$PointsSummaryModel {
  String? get employeeId => throw _privateConstructorUsedError;
  PointsBalancesModel get balances => throw _privateConstructorUsedError;
  PointsLevelModel get level => throw _privateConstructorUsedError;
  PointsStreakModel get streak => throw _privateConstructorUsedError;
  PointsSettingsModel get settings => throw _privateConstructorUsedError;

  /// Serializes this PointsSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsSummaryModelCopyWith<PointsSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsSummaryModelCopyWith<$Res> {
  factory $PointsSummaryModelCopyWith(
    PointsSummaryModel value,
    $Res Function(PointsSummaryModel) then,
  ) = _$PointsSummaryModelCopyWithImpl<$Res, PointsSummaryModel>;
  @useResult
  $Res call({
    String? employeeId,
    PointsBalancesModel balances,
    PointsLevelModel level,
    PointsStreakModel streak,
    PointsSettingsModel settings,
  });

  $PointsBalancesModelCopyWith<$Res> get balances;
  $PointsLevelModelCopyWith<$Res> get level;
  $PointsStreakModelCopyWith<$Res> get streak;
  $PointsSettingsModelCopyWith<$Res> get settings;
}

/// @nodoc
class _$PointsSummaryModelCopyWithImpl<$Res, $Val extends PointsSummaryModel>
    implements $PointsSummaryModelCopyWith<$Res> {
  _$PointsSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = freezed,
    Object? balances = null,
    Object? level = null,
    Object? streak = null,
    Object? settings = null,
  }) {
    return _then(
      _value.copyWith(
            employeeId: freezed == employeeId
                ? _value.employeeId
                : employeeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            balances: null == balances
                ? _value.balances
                : balances // ignore: cast_nullable_to_non_nullable
                      as PointsBalancesModel,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as PointsLevelModel,
            streak: null == streak
                ? _value.streak
                : streak // ignore: cast_nullable_to_non_nullable
                      as PointsStreakModel,
            settings: null == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as PointsSettingsModel,
          )
          as $Val,
    );
  }

  /// Create a copy of PointsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointsBalancesModelCopyWith<$Res> get balances {
    return $PointsBalancesModelCopyWith<$Res>(_value.balances, (value) {
      return _then(_value.copyWith(balances: value) as $Val);
    });
  }

  /// Create a copy of PointsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointsLevelModelCopyWith<$Res> get level {
    return $PointsLevelModelCopyWith<$Res>(_value.level, (value) {
      return _then(_value.copyWith(level: value) as $Val);
    });
  }

  /// Create a copy of PointsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointsStreakModelCopyWith<$Res> get streak {
    return $PointsStreakModelCopyWith<$Res>(_value.streak, (value) {
      return _then(_value.copyWith(streak: value) as $Val);
    });
  }

  /// Create a copy of PointsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointsSettingsModelCopyWith<$Res> get settings {
    return $PointsSettingsModelCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PointsSummaryModelImplCopyWith<$Res>
    implements $PointsSummaryModelCopyWith<$Res> {
  factory _$$PointsSummaryModelImplCopyWith(
    _$PointsSummaryModelImpl value,
    $Res Function(_$PointsSummaryModelImpl) then,
  ) = __$$PointsSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? employeeId,
    PointsBalancesModel balances,
    PointsLevelModel level,
    PointsStreakModel streak,
    PointsSettingsModel settings,
  });

  @override
  $PointsBalancesModelCopyWith<$Res> get balances;
  @override
  $PointsLevelModelCopyWith<$Res> get level;
  @override
  $PointsStreakModelCopyWith<$Res> get streak;
  @override
  $PointsSettingsModelCopyWith<$Res> get settings;
}

/// @nodoc
class __$$PointsSummaryModelImplCopyWithImpl<$Res>
    extends _$PointsSummaryModelCopyWithImpl<$Res, _$PointsSummaryModelImpl>
    implements _$$PointsSummaryModelImplCopyWith<$Res> {
  __$$PointsSummaryModelImplCopyWithImpl(
    _$PointsSummaryModelImpl _value,
    $Res Function(_$PointsSummaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = freezed,
    Object? balances = null,
    Object? level = null,
    Object? streak = null,
    Object? settings = null,
  }) {
    return _then(
      _$PointsSummaryModelImpl(
        employeeId: freezed == employeeId
            ? _value.employeeId
            : employeeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        balances: null == balances
            ? _value.balances
            : balances // ignore: cast_nullable_to_non_nullable
                  as PointsBalancesModel,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as PointsLevelModel,
        streak: null == streak
            ? _value.streak
            : streak // ignore: cast_nullable_to_non_nullable
                  as PointsStreakModel,
        settings: null == settings
            ? _value.settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as PointsSettingsModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsSummaryModelImpl implements _PointsSummaryModel {
  const _$PointsSummaryModelImpl({
    this.employeeId,
    this.balances = const PointsBalancesModel(),
    this.level = const PointsLevelModel(),
    this.streak = const PointsStreakModel(),
    this.settings = const PointsSettingsModel(),
  });

  factory _$PointsSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsSummaryModelImplFromJson(json);

  @override
  final String? employeeId;
  @override
  @JsonKey()
  final PointsBalancesModel balances;
  @override
  @JsonKey()
  final PointsLevelModel level;
  @override
  @JsonKey()
  final PointsStreakModel streak;
  @override
  @JsonKey()
  final PointsSettingsModel settings;

  @override
  String toString() {
    return 'PointsSummaryModel(employeeId: $employeeId, balances: $balances, level: $level, streak: $streak, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsSummaryModelImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.balances, balances) ||
                other.balances == balances) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.streak, streak) || other.streak == streak) &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, employeeId, balances, level, streak, settings);

  /// Create a copy of PointsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsSummaryModelImplCopyWith<_$PointsSummaryModelImpl> get copyWith =>
      __$$PointsSummaryModelImplCopyWithImpl<_$PointsSummaryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsSummaryModelImplToJson(this);
  }
}

abstract class _PointsSummaryModel implements PointsSummaryModel {
  const factory _PointsSummaryModel({
    final String? employeeId,
    final PointsBalancesModel balances,
    final PointsLevelModel level,
    final PointsStreakModel streak,
    final PointsSettingsModel settings,
  }) = _$PointsSummaryModelImpl;

  factory _PointsSummaryModel.fromJson(Map<String, dynamic> json) =
      _$PointsSummaryModelImpl.fromJson;

  @override
  String? get employeeId;
  @override
  PointsBalancesModel get balances;
  @override
  PointsLevelModel get level;
  @override
  PointsStreakModel get streak;
  @override
  PointsSettingsModel get settings;

  /// Create a copy of PointsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsSummaryModelImplCopyWith<_$PointsSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PointsSummaryResponseModel _$PointsSummaryResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _PointsSummaryResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PointsSummaryResponseModel {
  PointsSummaryModel? get value => throw _privateConstructorUsedError;
  bool? get isSuccess => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;

  /// Serializes this PointsSummaryResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsSummaryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsSummaryResponseModelCopyWith<PointsSummaryResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsSummaryResponseModelCopyWith<$Res> {
  factory $PointsSummaryResponseModelCopyWith(
    PointsSummaryResponseModel value,
    $Res Function(PointsSummaryResponseModel) then,
  ) =
      _$PointsSummaryResponseModelCopyWithImpl<
        $Res,
        PointsSummaryResponseModel
      >;
  @useResult
  $Res call({
    PointsSummaryModel? value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  });

  $PointsSummaryModelCopyWith<$Res>? get value;
}

/// @nodoc
class _$PointsSummaryResponseModelCopyWithImpl<
  $Res,
  $Val extends PointsSummaryResponseModel
>
    implements $PointsSummaryResponseModelCopyWith<$Res> {
  _$PointsSummaryResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsSummaryResponseModel
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
                      as PointsSummaryModel?,
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

  /// Create a copy of PointsSummaryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointsSummaryModelCopyWith<$Res>? get value {
    if (_value.value == null) {
      return null;
    }

    return $PointsSummaryModelCopyWith<$Res>(_value.value!, (value) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PointsSummaryResponseModelImplCopyWith<$Res>
    implements $PointsSummaryResponseModelCopyWith<$Res> {
  factory _$$PointsSummaryResponseModelImplCopyWith(
    _$PointsSummaryResponseModelImpl value,
    $Res Function(_$PointsSummaryResponseModelImpl) then,
  ) = __$$PointsSummaryResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PointsSummaryModel? value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  });

  @override
  $PointsSummaryModelCopyWith<$Res>? get value;
}

/// @nodoc
class __$$PointsSummaryResponseModelImplCopyWithImpl<$Res>
    extends
        _$PointsSummaryResponseModelCopyWithImpl<
          $Res,
          _$PointsSummaryResponseModelImpl
        >
    implements _$$PointsSummaryResponseModelImplCopyWith<$Res> {
  __$$PointsSummaryResponseModelImplCopyWithImpl(
    _$PointsSummaryResponseModelImpl _value,
    $Res Function(_$PointsSummaryResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsSummaryResponseModel
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
      _$PointsSummaryResponseModelImpl(
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as PointsSummaryModel?,
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
class _$PointsSummaryResponseModelImpl implements _PointsSummaryResponseModel {
  const _$PointsSummaryResponseModelImpl({
    this.value,
    this.isSuccess,
    this.successMessage,
    final List<String>? errors,
  }) : _errors = errors;

  factory _$PointsSummaryResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PointsSummaryResponseModelImplFromJson(json);

  @override
  final PointsSummaryModel? value;
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
    return 'PointsSummaryResponseModel(value: $value, isSuccess: $isSuccess, successMessage: $successMessage, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsSummaryResponseModelImpl &&
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

  /// Create a copy of PointsSummaryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsSummaryResponseModelImplCopyWith<_$PointsSummaryResponseModelImpl>
  get copyWith =>
      __$$PointsSummaryResponseModelImplCopyWithImpl<
        _$PointsSummaryResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsSummaryResponseModelImplToJson(this);
  }
}

abstract class _PointsSummaryResponseModel
    implements PointsSummaryResponseModel {
  const factory _PointsSummaryResponseModel({
    final PointsSummaryModel? value,
    final bool? isSuccess,
    final String? successMessage,
    final List<String>? errors,
  }) = _$PointsSummaryResponseModelImpl;

  factory _PointsSummaryResponseModel.fromJson(Map<String, dynamic> json) =
      _$PointsSummaryResponseModelImpl.fromJson;

  @override
  PointsSummaryModel? get value;
  @override
  bool? get isSuccess;
  @override
  String? get successMessage;
  @override
  List<String>? get errors;

  /// Create a copy of PointsSummaryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsSummaryResponseModelImplCopyWith<_$PointsSummaryResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
