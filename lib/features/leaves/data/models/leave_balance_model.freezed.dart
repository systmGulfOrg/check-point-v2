// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_balance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LeaveBalanceModel _$LeaveBalanceModelFromJson(Map<String, dynamic> json) {
  return _LeaveBalanceModel.fromJson(json);
}

/// @nodoc
mixin _$LeaveBalanceModel {
  String get id => throw _privateConstructorUsedError;
  String get leaveTypeId => throw _privateConstructorUsedError;
  String get leaveTypeName => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get totalAllocated => throw _privateConstructorUsedError;
  int get usedBalance => throw _privateConstructorUsedError;
  int get remainingBalance => throw _privateConstructorUsedError;
  int get carriedOver => throw _privateConstructorUsedError;

  /// Serializes this LeaveBalanceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveBalanceModelCopyWith<LeaveBalanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveBalanceModelCopyWith<$Res> {
  factory $LeaveBalanceModelCopyWith(
    LeaveBalanceModel value,
    $Res Function(LeaveBalanceModel) then,
  ) = _$LeaveBalanceModelCopyWithImpl<$Res, LeaveBalanceModel>;
  @useResult
  $Res call({
    String id,
    String leaveTypeId,
    String leaveTypeName,
    int year,
    int totalAllocated,
    int usedBalance,
    int remainingBalance,
    int carriedOver,
  });
}

/// @nodoc
class _$LeaveBalanceModelCopyWithImpl<$Res, $Val extends LeaveBalanceModel>
    implements $LeaveBalanceModelCopyWith<$Res> {
  _$LeaveBalanceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? leaveTypeId = null,
    Object? leaveTypeName = null,
    Object? year = null,
    Object? totalAllocated = null,
    Object? usedBalance = null,
    Object? remainingBalance = null,
    Object? carriedOver = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            leaveTypeId: null == leaveTypeId
                ? _value.leaveTypeId
                : leaveTypeId // ignore: cast_nullable_to_non_nullable
                      as String,
            leaveTypeName: null == leaveTypeName
                ? _value.leaveTypeName
                : leaveTypeName // ignore: cast_nullable_to_non_nullable
                      as String,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAllocated: null == totalAllocated
                ? _value.totalAllocated
                : totalAllocated // ignore: cast_nullable_to_non_nullable
                      as int,
            usedBalance: null == usedBalance
                ? _value.usedBalance
                : usedBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            remainingBalance: null == remainingBalance
                ? _value.remainingBalance
                : remainingBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            carriedOver: null == carriedOver
                ? _value.carriedOver
                : carriedOver // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaveBalanceModelImplCopyWith<$Res>
    implements $LeaveBalanceModelCopyWith<$Res> {
  factory _$$LeaveBalanceModelImplCopyWith(
    _$LeaveBalanceModelImpl value,
    $Res Function(_$LeaveBalanceModelImpl) then,
  ) = __$$LeaveBalanceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String leaveTypeId,
    String leaveTypeName,
    int year,
    int totalAllocated,
    int usedBalance,
    int remainingBalance,
    int carriedOver,
  });
}

/// @nodoc
class __$$LeaveBalanceModelImplCopyWithImpl<$Res>
    extends _$LeaveBalanceModelCopyWithImpl<$Res, _$LeaveBalanceModelImpl>
    implements _$$LeaveBalanceModelImplCopyWith<$Res> {
  __$$LeaveBalanceModelImplCopyWithImpl(
    _$LeaveBalanceModelImpl _value,
    $Res Function(_$LeaveBalanceModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? leaveTypeId = null,
    Object? leaveTypeName = null,
    Object? year = null,
    Object? totalAllocated = null,
    Object? usedBalance = null,
    Object? remainingBalance = null,
    Object? carriedOver = null,
  }) {
    return _then(
      _$LeaveBalanceModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        leaveTypeId: null == leaveTypeId
            ? _value.leaveTypeId
            : leaveTypeId // ignore: cast_nullable_to_non_nullable
                  as String,
        leaveTypeName: null == leaveTypeName
            ? _value.leaveTypeName
            : leaveTypeName // ignore: cast_nullable_to_non_nullable
                  as String,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAllocated: null == totalAllocated
            ? _value.totalAllocated
            : totalAllocated // ignore: cast_nullable_to_non_nullable
                  as int,
        usedBalance: null == usedBalance
            ? _value.usedBalance
            : usedBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        remainingBalance: null == remainingBalance
            ? _value.remainingBalance
            : remainingBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        carriedOver: null == carriedOver
            ? _value.carriedOver
            : carriedOver // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveBalanceModelImpl implements _LeaveBalanceModel {
  const _$LeaveBalanceModelImpl({
    required this.id,
    required this.leaveTypeId,
    required this.leaveTypeName,
    required this.year,
    required this.totalAllocated,
    required this.usedBalance,
    required this.remainingBalance,
    required this.carriedOver,
  });

  factory _$LeaveBalanceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveBalanceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String leaveTypeId;
  @override
  final String leaveTypeName;
  @override
  final int year;
  @override
  final int totalAllocated;
  @override
  final int usedBalance;
  @override
  final int remainingBalance;
  @override
  final int carriedOver;

  @override
  String toString() {
    return 'LeaveBalanceModel(id: $id, leaveTypeId: $leaveTypeId, leaveTypeName: $leaveTypeName, year: $year, totalAllocated: $totalAllocated, usedBalance: $usedBalance, remainingBalance: $remainingBalance, carriedOver: $carriedOver)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveBalanceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.leaveTypeName, leaveTypeName) ||
                other.leaveTypeName == leaveTypeName) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.totalAllocated, totalAllocated) ||
                other.totalAllocated == totalAllocated) &&
            (identical(other.usedBalance, usedBalance) ||
                other.usedBalance == usedBalance) &&
            (identical(other.remainingBalance, remainingBalance) ||
                other.remainingBalance == remainingBalance) &&
            (identical(other.carriedOver, carriedOver) ||
                other.carriedOver == carriedOver));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    leaveTypeId,
    leaveTypeName,
    year,
    totalAllocated,
    usedBalance,
    remainingBalance,
    carriedOver,
  );

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveBalanceModelImplCopyWith<_$LeaveBalanceModelImpl> get copyWith =>
      __$$LeaveBalanceModelImplCopyWithImpl<_$LeaveBalanceModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveBalanceModelImplToJson(this);
  }
}

abstract class _LeaveBalanceModel implements LeaveBalanceModel {
  const factory _LeaveBalanceModel({
    required final String id,
    required final String leaveTypeId,
    required final String leaveTypeName,
    required final int year,
    required final int totalAllocated,
    required final int usedBalance,
    required final int remainingBalance,
    required final int carriedOver,
  }) = _$LeaveBalanceModelImpl;

  factory _LeaveBalanceModel.fromJson(Map<String, dynamic> json) =
      _$LeaveBalanceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get leaveTypeId;
  @override
  String get leaveTypeName;
  @override
  int get year;
  @override
  int get totalAllocated;
  @override
  int get usedBalance;
  @override
  int get remainingBalance;
  @override
  int get carriedOver;

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveBalanceModelImplCopyWith<_$LeaveBalanceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
