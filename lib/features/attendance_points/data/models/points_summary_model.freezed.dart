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

PointsSummaryModel _$PointsSummaryModelFromJson(Map<String, dynamic> json) {
  return _PointsSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$PointsSummaryModel {
  int get green => throw _privateConstructorUsedError;
  int get red => throw _privateConstructorUsedError;
  int get black => throw _privateConstructorUsedError;
  int get availableGreen => throw _privateConstructorUsedError;
  int get availableRed => throw _privateConstructorUsedError;
  int get availableBlack => throw _privateConstructorUsedError;

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
    int green,
    int red,
    int black,
    int availableGreen,
    int availableRed,
    int availableBlack,
  });
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
    Object? green = null,
    Object? red = null,
    Object? black = null,
    Object? availableGreen = null,
    Object? availableRed = null,
    Object? availableBlack = null,
  }) {
    return _then(
      _value.copyWith(
            green: null == green
                ? _value.green
                : green // ignore: cast_nullable_to_non_nullable
                      as int,
            red: null == red
                ? _value.red
                : red // ignore: cast_nullable_to_non_nullable
                      as int,
            black: null == black
                ? _value.black
                : black // ignore: cast_nullable_to_non_nullable
                      as int,
            availableGreen: null == availableGreen
                ? _value.availableGreen
                : availableGreen // ignore: cast_nullable_to_non_nullable
                      as int,
            availableRed: null == availableRed
                ? _value.availableRed
                : availableRed // ignore: cast_nullable_to_non_nullable
                      as int,
            availableBlack: null == availableBlack
                ? _value.availableBlack
                : availableBlack // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
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
    int green,
    int red,
    int black,
    int availableGreen,
    int availableRed,
    int availableBlack,
  });
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
    Object? green = null,
    Object? red = null,
    Object? black = null,
    Object? availableGreen = null,
    Object? availableRed = null,
    Object? availableBlack = null,
  }) {
    return _then(
      _$PointsSummaryModelImpl(
        green: null == green
            ? _value.green
            : green // ignore: cast_nullable_to_non_nullable
                  as int,
        red: null == red
            ? _value.red
            : red // ignore: cast_nullable_to_non_nullable
                  as int,
        black: null == black
            ? _value.black
            : black // ignore: cast_nullable_to_non_nullable
                  as int,
        availableGreen: null == availableGreen
            ? _value.availableGreen
            : availableGreen // ignore: cast_nullable_to_non_nullable
                  as int,
        availableRed: null == availableRed
            ? _value.availableRed
            : availableRed // ignore: cast_nullable_to_non_nullable
                  as int,
        availableBlack: null == availableBlack
            ? _value.availableBlack
            : availableBlack // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsSummaryModelImpl implements _PointsSummaryModel {
  const _$PointsSummaryModelImpl({
    this.green = 0,
    this.red = 0,
    this.black = 0,
    this.availableGreen = 0,
    this.availableRed = 0,
    this.availableBlack = 0,
  });

  factory _$PointsSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsSummaryModelImplFromJson(json);

  @override
  @JsonKey()
  final int green;
  @override
  @JsonKey()
  final int red;
  @override
  @JsonKey()
  final int black;
  @override
  @JsonKey()
  final int availableGreen;
  @override
  @JsonKey()
  final int availableRed;
  @override
  @JsonKey()
  final int availableBlack;

  @override
  String toString() {
    return 'PointsSummaryModel(green: $green, red: $red, black: $black, availableGreen: $availableGreen, availableRed: $availableRed, availableBlack: $availableBlack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsSummaryModelImpl &&
            (identical(other.green, green) || other.green == green) &&
            (identical(other.red, red) || other.red == red) &&
            (identical(other.black, black) || other.black == black) &&
            (identical(other.availableGreen, availableGreen) ||
                other.availableGreen == availableGreen) &&
            (identical(other.availableRed, availableRed) ||
                other.availableRed == availableRed) &&
            (identical(other.availableBlack, availableBlack) ||
                other.availableBlack == availableBlack));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    green,
    red,
    black,
    availableGreen,
    availableRed,
    availableBlack,
  );

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
    final int green,
    final int red,
    final int black,
    final int availableGreen,
    final int availableRed,
    final int availableBlack,
  }) = _$PointsSummaryModelImpl;

  factory _PointsSummaryModel.fromJson(Map<String, dynamic> json) =
      _$PointsSummaryModelImpl.fromJson;

  @override
  int get green;
  @override
  int get red;
  @override
  int get black;
  @override
  int get availableGreen;
  @override
  int get availableRed;
  @override
  int get availableBlack;

  /// Create a copy of PointsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsSummaryModelImplCopyWith<_$PointsSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
