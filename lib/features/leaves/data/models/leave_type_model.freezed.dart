// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LeaveTypeModel _$LeaveTypeModelFromJson(Map<String, dynamic> json) {
  return _LeaveTypeModel.fromJson(json);
}

/// @nodoc
mixin _$LeaveTypeModel {
  String get id => throw _privateConstructorUsedError;
  String get typeName => throw _privateConstructorUsedError;
  bool get isPaid => throw _privateConstructorUsedError;
  bool get requiresAttachment => throw _privateConstructorUsedError;
  int? get maxDaysPerYear => throw _privateConstructorUsedError;
  bool? get isCasual => throw _privateConstructorUsedError;

  /// Serializes this LeaveTypeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveTypeModelCopyWith<LeaveTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveTypeModelCopyWith<$Res> {
  factory $LeaveTypeModelCopyWith(
    LeaveTypeModel value,
    $Res Function(LeaveTypeModel) then,
  ) = _$LeaveTypeModelCopyWithImpl<$Res, LeaveTypeModel>;
  @useResult
  $Res call({
    String id,
    String typeName,
    bool isPaid,
    bool requiresAttachment,
    int? maxDaysPerYear,
    bool? isCasual,
  });
}

/// @nodoc
class _$LeaveTypeModelCopyWithImpl<$Res, $Val extends LeaveTypeModel>
    implements $LeaveTypeModelCopyWith<$Res> {
  _$LeaveTypeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? typeName = null,
    Object? isPaid = null,
    Object? requiresAttachment = null,
    Object? maxDaysPerYear = freezed,
    Object? isCasual = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            typeName: null == typeName
                ? _value.typeName
                : typeName // ignore: cast_nullable_to_non_nullable
                      as String,
            isPaid: null == isPaid
                ? _value.isPaid
                : isPaid // ignore: cast_nullable_to_non_nullable
                      as bool,
            requiresAttachment: null == requiresAttachment
                ? _value.requiresAttachment
                : requiresAttachment // ignore: cast_nullable_to_non_nullable
                      as bool,
            maxDaysPerYear: freezed == maxDaysPerYear
                ? _value.maxDaysPerYear
                : maxDaysPerYear // ignore: cast_nullable_to_non_nullable
                      as int?,
            isCasual: freezed == isCasual
                ? _value.isCasual
                : isCasual // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaveTypeModelImplCopyWith<$Res>
    implements $LeaveTypeModelCopyWith<$Res> {
  factory _$$LeaveTypeModelImplCopyWith(
    _$LeaveTypeModelImpl value,
    $Res Function(_$LeaveTypeModelImpl) then,
  ) = __$$LeaveTypeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String typeName,
    bool isPaid,
    bool requiresAttachment,
    int? maxDaysPerYear,
    bool? isCasual,
  });
}

/// @nodoc
class __$$LeaveTypeModelImplCopyWithImpl<$Res>
    extends _$LeaveTypeModelCopyWithImpl<$Res, _$LeaveTypeModelImpl>
    implements _$$LeaveTypeModelImplCopyWith<$Res> {
  __$$LeaveTypeModelImplCopyWithImpl(
    _$LeaveTypeModelImpl _value,
    $Res Function(_$LeaveTypeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? typeName = null,
    Object? isPaid = null,
    Object? requiresAttachment = null,
    Object? maxDaysPerYear = freezed,
    Object? isCasual = freezed,
  }) {
    return _then(
      _$LeaveTypeModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        typeName: null == typeName
            ? _value.typeName
            : typeName // ignore: cast_nullable_to_non_nullable
                  as String,
        isPaid: null == isPaid
            ? _value.isPaid
            : isPaid // ignore: cast_nullable_to_non_nullable
                  as bool,
        requiresAttachment: null == requiresAttachment
            ? _value.requiresAttachment
            : requiresAttachment // ignore: cast_nullable_to_non_nullable
                  as bool,
        maxDaysPerYear: freezed == maxDaysPerYear
            ? _value.maxDaysPerYear
            : maxDaysPerYear // ignore: cast_nullable_to_non_nullable
                  as int?,
        isCasual: freezed == isCasual
            ? _value.isCasual
            : isCasual // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveTypeModelImpl implements _LeaveTypeModel {
  const _$LeaveTypeModelImpl({
    required this.id,
    required this.typeName,
    required this.isPaid,
    required this.requiresAttachment,
    this.maxDaysPerYear,
    this.isCasual,
  });

  factory _$LeaveTypeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveTypeModelImplFromJson(json);

  @override
  final String id;
  @override
  final String typeName;
  @override
  final bool isPaid;
  @override
  final bool requiresAttachment;
  @override
  final int? maxDaysPerYear;
  @override
  final bool? isCasual;

  @override
  String toString() {
    return 'LeaveTypeModel(id: $id, typeName: $typeName, isPaid: $isPaid, requiresAttachment: $requiresAttachment, maxDaysPerYear: $maxDaysPerYear, isCasual: $isCasual)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveTypeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.requiresAttachment, requiresAttachment) ||
                other.requiresAttachment == requiresAttachment) &&
            (identical(other.maxDaysPerYear, maxDaysPerYear) ||
                other.maxDaysPerYear == maxDaysPerYear) &&
            (identical(other.isCasual, isCasual) ||
                other.isCasual == isCasual));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    typeName,
    isPaid,
    requiresAttachment,
    maxDaysPerYear,
    isCasual,
  );

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveTypeModelImplCopyWith<_$LeaveTypeModelImpl> get copyWith =>
      __$$LeaveTypeModelImplCopyWithImpl<_$LeaveTypeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveTypeModelImplToJson(this);
  }
}

abstract class _LeaveTypeModel implements LeaveTypeModel {
  const factory _LeaveTypeModel({
    required final String id,
    required final String typeName,
    required final bool isPaid,
    required final bool requiresAttachment,
    final int? maxDaysPerYear,
    final bool? isCasual,
  }) = _$LeaveTypeModelImpl;

  factory _LeaveTypeModel.fromJson(Map<String, dynamic> json) =
      _$LeaveTypeModelImpl.fromJson;

  @override
  String get id;
  @override
  String get typeName;
  @override
  bool get isPaid;
  @override
  bool get requiresAttachment;
  @override
  int? get maxDaysPerYear;
  @override
  bool? get isCasual;

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveTypeModelImplCopyWith<_$LeaveTypeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
