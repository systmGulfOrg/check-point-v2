// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lat_lng_point_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LatLngPointModel _$LatLngPointModelFromJson(Map<String, dynamic> json) {
  return _LatLngPointModel.fromJson(json);
}

/// @nodoc
mixin _$LatLngPointModel {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;

  /// Serializes this LatLngPointModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LatLngPointModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LatLngPointModelCopyWith<LatLngPointModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatLngPointModelCopyWith<$Res> {
  factory $LatLngPointModelCopyWith(
    LatLngPointModel value,
    $Res Function(LatLngPointModel) then,
  ) = _$LatLngPointModelCopyWithImpl<$Res, LatLngPointModel>;
  @useResult
  $Res call({double lat, double lng});
}

/// @nodoc
class _$LatLngPointModelCopyWithImpl<$Res, $Val extends LatLngPointModel>
    implements $LatLngPointModelCopyWith<$Res> {
  _$LatLngPointModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LatLngPointModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = null, Object? lng = null}) {
    return _then(
      _value.copyWith(
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LatLngPointModelImplCopyWith<$Res>
    implements $LatLngPointModelCopyWith<$Res> {
  factory _$$LatLngPointModelImplCopyWith(
    _$LatLngPointModelImpl value,
    $Res Function(_$LatLngPointModelImpl) then,
  ) = __$$LatLngPointModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lng});
}

/// @nodoc
class __$$LatLngPointModelImplCopyWithImpl<$Res>
    extends _$LatLngPointModelCopyWithImpl<$Res, _$LatLngPointModelImpl>
    implements _$$LatLngPointModelImplCopyWith<$Res> {
  __$$LatLngPointModelImplCopyWithImpl(
    _$LatLngPointModelImpl _value,
    $Res Function(_$LatLngPointModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LatLngPointModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = null, Object? lng = null}) {
    return _then(
      _$LatLngPointModelImpl(
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LatLngPointModelImpl implements _LatLngPointModel {
  const _$LatLngPointModelImpl({required this.lat, required this.lng});

  factory _$LatLngPointModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LatLngPointModelImplFromJson(json);

  @override
  final double lat;
  @override
  final double lng;

  @override
  String toString() {
    return 'LatLngPointModel(lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatLngPointModelImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng);

  /// Create a copy of LatLngPointModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LatLngPointModelImplCopyWith<_$LatLngPointModelImpl> get copyWith =>
      __$$LatLngPointModelImplCopyWithImpl<_$LatLngPointModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LatLngPointModelImplToJson(this);
  }
}

abstract class _LatLngPointModel implements LatLngPointModel {
  const factory _LatLngPointModel({
    required final double lat,
    required final double lng,
  }) = _$LatLngPointModelImpl;

  factory _LatLngPointModel.fromJson(Map<String, dynamic> json) =
      _$LatLngPointModelImpl.fromJson;

  @override
  double get lat;
  @override
  double get lng;

  /// Create a copy of LatLngPointModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LatLngPointModelImplCopyWith<_$LatLngPointModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
