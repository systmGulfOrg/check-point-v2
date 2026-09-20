// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'official_holiday_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OfficialHolidayModel _$OfficialHolidayModelFromJson(Map<String, dynamic> json) {
  return _OfficialHolidayModel.fromJson(json);
}

/// @nodoc
mixin _$OfficialHolidayModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  bool get isRecurring => throw _privateConstructorUsedError;

  /// Serializes this OfficialHolidayModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OfficialHolidayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OfficialHolidayModelCopyWith<OfficialHolidayModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfficialHolidayModelCopyWith<$Res> {
  factory $OfficialHolidayModelCopyWith(
    OfficialHolidayModel value,
    $Res Function(OfficialHolidayModel) then,
  ) = _$OfficialHolidayModelCopyWithImpl<$Res, OfficialHolidayModel>;
  @useResult
  $Res call({String id, String name, DateTime date, bool isRecurring});
}

/// @nodoc
class _$OfficialHolidayModelCopyWithImpl<
  $Res,
  $Val extends OfficialHolidayModel
>
    implements $OfficialHolidayModelCopyWith<$Res> {
  _$OfficialHolidayModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OfficialHolidayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? date = null,
    Object? isRecurring = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isRecurring: null == isRecurring
                ? _value.isRecurring
                : isRecurring // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OfficialHolidayModelImplCopyWith<$Res>
    implements $OfficialHolidayModelCopyWith<$Res> {
  factory _$$OfficialHolidayModelImplCopyWith(
    _$OfficialHolidayModelImpl value,
    $Res Function(_$OfficialHolidayModelImpl) then,
  ) = __$$OfficialHolidayModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, DateTime date, bool isRecurring});
}

/// @nodoc
class __$$OfficialHolidayModelImplCopyWithImpl<$Res>
    extends _$OfficialHolidayModelCopyWithImpl<$Res, _$OfficialHolidayModelImpl>
    implements _$$OfficialHolidayModelImplCopyWith<$Res> {
  __$$OfficialHolidayModelImplCopyWithImpl(
    _$OfficialHolidayModelImpl _value,
    $Res Function(_$OfficialHolidayModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OfficialHolidayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? date = null,
    Object? isRecurring = null,
  }) {
    return _then(
      _$OfficialHolidayModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isRecurring: null == isRecurring
            ? _value.isRecurring
            : isRecurring // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OfficialHolidayModelImpl implements _OfficialHolidayModel {
  const _$OfficialHolidayModelImpl({
    required this.id,
    required this.name,
    required this.date,
    required this.isRecurring,
  });

  factory _$OfficialHolidayModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfficialHolidayModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime date;
  @override
  final bool isRecurring;

  @override
  String toString() {
    return 'OfficialHolidayModel(id: $id, name: $name, date: $date, isRecurring: $isRecurring)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfficialHolidayModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, date, isRecurring);

  /// Create a copy of OfficialHolidayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfficialHolidayModelImplCopyWith<_$OfficialHolidayModelImpl>
  get copyWith =>
      __$$OfficialHolidayModelImplCopyWithImpl<_$OfficialHolidayModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OfficialHolidayModelImplToJson(this);
  }
}

abstract class _OfficialHolidayModel implements OfficialHolidayModel {
  const factory _OfficialHolidayModel({
    required final String id,
    required final String name,
    required final DateTime date,
    required final bool isRecurring,
  }) = _$OfficialHolidayModelImpl;

  factory _OfficialHolidayModel.fromJson(Map<String, dynamic> json) =
      _$OfficialHolidayModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  DateTime get date;
  @override
  bool get isRecurring;

  /// Create a copy of OfficialHolidayModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfficialHolidayModelImplCopyWith<_$OfficialHolidayModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
