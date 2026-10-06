// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'site_boundary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SiteBoundaryModel _$SiteBoundaryModelFromJson(Map<String, dynamic> json) {
  return _SiteBoundaryModel.fromJson(json);
}

/// @nodoc
mixin _$SiteBoundaryModel {
  @JsonKey(name: 'site_id')
  String? get siteIdUnderscore => throw _privateConstructorUsedError;
  @JsonKey(name: 'siteId')
  String? get siteIdCamel => throw _privateConstructorUsedError;
  @JsonKey(name: 'site_name')
  String? get siteNameUnderscore => throw _privateConstructorUsedError;
  @JsonKey(name: 'siteName')
  String? get siteNameCamel => throw _privateConstructorUsedError;
  @JsonKey(name: 'boundary_type')
  String get boundaryType => throw _privateConstructorUsedError;
  @JsonKey(name: 'center_lat')
  double? get centerLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'center_lng')
  double? get centerLng => throw _privateConstructorUsedError;
  @JsonKey(name: 'radius_meters')
  double get radiusMeters => throw _privateConstructorUsedError;
  @JsonKey(name: 'boundary_coordinates')
  List<LatLngPointModel> get boundaryCoordinates =>
      throw _privateConstructorUsedError;
  String? get projectId => throw _privateConstructorUsedError;
  String? get projectName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get workerCount => throw _privateConstructorUsedError;
  int get assignmentCount => throw _privateConstructorUsedError;

  /// Serializes this SiteBoundaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SiteBoundaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SiteBoundaryModelCopyWith<SiteBoundaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SiteBoundaryModelCopyWith<$Res> {
  factory $SiteBoundaryModelCopyWith(
    SiteBoundaryModel value,
    $Res Function(SiteBoundaryModel) then,
  ) = _$SiteBoundaryModelCopyWithImpl<$Res, SiteBoundaryModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'site_id') String? siteIdUnderscore,
    @JsonKey(name: 'siteId') String? siteIdCamel,
    @JsonKey(name: 'site_name') String? siteNameUnderscore,
    @JsonKey(name: 'siteName') String? siteNameCamel,
    @JsonKey(name: 'boundary_type') String boundaryType,
    @JsonKey(name: 'center_lat') double? centerLat,
    @JsonKey(name: 'center_lng') double? centerLng,
    @JsonKey(name: 'radius_meters') double radiusMeters,
    @JsonKey(name: 'boundary_coordinates')
    List<LatLngPointModel> boundaryCoordinates,
    String? projectId,
    String? projectName,
    String status,
    int workerCount,
    int assignmentCount,
  });
}

/// @nodoc
class _$SiteBoundaryModelCopyWithImpl<$Res, $Val extends SiteBoundaryModel>
    implements $SiteBoundaryModelCopyWith<$Res> {
  _$SiteBoundaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SiteBoundaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? siteIdUnderscore = freezed,
    Object? siteIdCamel = freezed,
    Object? siteNameUnderscore = freezed,
    Object? siteNameCamel = freezed,
    Object? boundaryType = null,
    Object? centerLat = freezed,
    Object? centerLng = freezed,
    Object? radiusMeters = null,
    Object? boundaryCoordinates = null,
    Object? projectId = freezed,
    Object? projectName = freezed,
    Object? status = null,
    Object? workerCount = null,
    Object? assignmentCount = null,
  }) {
    return _then(
      _value.copyWith(
            siteIdUnderscore: freezed == siteIdUnderscore
                ? _value.siteIdUnderscore
                : siteIdUnderscore // ignore: cast_nullable_to_non_nullable
                      as String?,
            siteIdCamel: freezed == siteIdCamel
                ? _value.siteIdCamel
                : siteIdCamel // ignore: cast_nullable_to_non_nullable
                      as String?,
            siteNameUnderscore: freezed == siteNameUnderscore
                ? _value.siteNameUnderscore
                : siteNameUnderscore // ignore: cast_nullable_to_non_nullable
                      as String?,
            siteNameCamel: freezed == siteNameCamel
                ? _value.siteNameCamel
                : siteNameCamel // ignore: cast_nullable_to_non_nullable
                      as String?,
            boundaryType: null == boundaryType
                ? _value.boundaryType
                : boundaryType // ignore: cast_nullable_to_non_nullable
                      as String,
            centerLat: freezed == centerLat
                ? _value.centerLat
                : centerLat // ignore: cast_nullable_to_non_nullable
                      as double?,
            centerLng: freezed == centerLng
                ? _value.centerLng
                : centerLng // ignore: cast_nullable_to_non_nullable
                      as double?,
            radiusMeters: null == radiusMeters
                ? _value.radiusMeters
                : radiusMeters // ignore: cast_nullable_to_non_nullable
                      as double,
            boundaryCoordinates: null == boundaryCoordinates
                ? _value.boundaryCoordinates
                : boundaryCoordinates // ignore: cast_nullable_to_non_nullable
                      as List<LatLngPointModel>,
            projectId: freezed == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String?,
            projectName: freezed == projectName
                ? _value.projectName
                : projectName // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            workerCount: null == workerCount
                ? _value.workerCount
                : workerCount // ignore: cast_nullable_to_non_nullable
                      as int,
            assignmentCount: null == assignmentCount
                ? _value.assignmentCount
                : assignmentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SiteBoundaryModelImplCopyWith<$Res>
    implements $SiteBoundaryModelCopyWith<$Res> {
  factory _$$SiteBoundaryModelImplCopyWith(
    _$SiteBoundaryModelImpl value,
    $Res Function(_$SiteBoundaryModelImpl) then,
  ) = __$$SiteBoundaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'site_id') String? siteIdUnderscore,
    @JsonKey(name: 'siteId') String? siteIdCamel,
    @JsonKey(name: 'site_name') String? siteNameUnderscore,
    @JsonKey(name: 'siteName') String? siteNameCamel,
    @JsonKey(name: 'boundary_type') String boundaryType,
    @JsonKey(name: 'center_lat') double? centerLat,
    @JsonKey(name: 'center_lng') double? centerLng,
    @JsonKey(name: 'radius_meters') double radiusMeters,
    @JsonKey(name: 'boundary_coordinates')
    List<LatLngPointModel> boundaryCoordinates,
    String? projectId,
    String? projectName,
    String status,
    int workerCount,
    int assignmentCount,
  });
}

/// @nodoc
class __$$SiteBoundaryModelImplCopyWithImpl<$Res>
    extends _$SiteBoundaryModelCopyWithImpl<$Res, _$SiteBoundaryModelImpl>
    implements _$$SiteBoundaryModelImplCopyWith<$Res> {
  __$$SiteBoundaryModelImplCopyWithImpl(
    _$SiteBoundaryModelImpl _value,
    $Res Function(_$SiteBoundaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SiteBoundaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? siteIdUnderscore = freezed,
    Object? siteIdCamel = freezed,
    Object? siteNameUnderscore = freezed,
    Object? siteNameCamel = freezed,
    Object? boundaryType = null,
    Object? centerLat = freezed,
    Object? centerLng = freezed,
    Object? radiusMeters = null,
    Object? boundaryCoordinates = null,
    Object? projectId = freezed,
    Object? projectName = freezed,
    Object? status = null,
    Object? workerCount = null,
    Object? assignmentCount = null,
  }) {
    return _then(
      _$SiteBoundaryModelImpl(
        siteIdUnderscore: freezed == siteIdUnderscore
            ? _value.siteIdUnderscore
            : siteIdUnderscore // ignore: cast_nullable_to_non_nullable
                  as String?,
        siteIdCamel: freezed == siteIdCamel
            ? _value.siteIdCamel
            : siteIdCamel // ignore: cast_nullable_to_non_nullable
                  as String?,
        siteNameUnderscore: freezed == siteNameUnderscore
            ? _value.siteNameUnderscore
            : siteNameUnderscore // ignore: cast_nullable_to_non_nullable
                  as String?,
        siteNameCamel: freezed == siteNameCamel
            ? _value.siteNameCamel
            : siteNameCamel // ignore: cast_nullable_to_non_nullable
                  as String?,
        boundaryType: null == boundaryType
            ? _value.boundaryType
            : boundaryType // ignore: cast_nullable_to_non_nullable
                  as String,
        centerLat: freezed == centerLat
            ? _value.centerLat
            : centerLat // ignore: cast_nullable_to_non_nullable
                  as double?,
        centerLng: freezed == centerLng
            ? _value.centerLng
            : centerLng // ignore: cast_nullable_to_non_nullable
                  as double?,
        radiusMeters: null == radiusMeters
            ? _value.radiusMeters
            : radiusMeters // ignore: cast_nullable_to_non_nullable
                  as double,
        boundaryCoordinates: null == boundaryCoordinates
            ? _value._boundaryCoordinates
            : boundaryCoordinates // ignore: cast_nullable_to_non_nullable
                  as List<LatLngPointModel>,
        projectId: freezed == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String?,
        projectName: freezed == projectName
            ? _value.projectName
            : projectName // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        workerCount: null == workerCount
            ? _value.workerCount
            : workerCount // ignore: cast_nullable_to_non_nullable
                  as int,
        assignmentCount: null == assignmentCount
            ? _value.assignmentCount
            : assignmentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SiteBoundaryModelImpl extends _SiteBoundaryModel {
  const _$SiteBoundaryModelImpl({
    @JsonKey(name: 'site_id') this.siteIdUnderscore,
    @JsonKey(name: 'siteId') this.siteIdCamel,
    @JsonKey(name: 'site_name') this.siteNameUnderscore,
    @JsonKey(name: 'siteName') this.siteNameCamel,
    @JsonKey(name: 'boundary_type') this.boundaryType = 'polygon',
    @JsonKey(name: 'center_lat') this.centerLat,
    @JsonKey(name: 'center_lng') this.centerLng,
    @JsonKey(name: 'radius_meters') this.radiusMeters = 250.0,
    @JsonKey(name: 'boundary_coordinates')
    final List<LatLngPointModel> boundaryCoordinates = const [],
    this.projectId,
    this.projectName,
    this.status = 'active',
    this.workerCount = 0,
    this.assignmentCount = 0,
  }) : _boundaryCoordinates = boundaryCoordinates,
       super._();

  factory _$SiteBoundaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SiteBoundaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'site_id')
  final String? siteIdUnderscore;
  @override
  @JsonKey(name: 'siteId')
  final String? siteIdCamel;
  @override
  @JsonKey(name: 'site_name')
  final String? siteNameUnderscore;
  @override
  @JsonKey(name: 'siteName')
  final String? siteNameCamel;
  @override
  @JsonKey(name: 'boundary_type')
  final String boundaryType;
  @override
  @JsonKey(name: 'center_lat')
  final double? centerLat;
  @override
  @JsonKey(name: 'center_lng')
  final double? centerLng;
  @override
  @JsonKey(name: 'radius_meters')
  final double radiusMeters;
  final List<LatLngPointModel> _boundaryCoordinates;
  @override
  @JsonKey(name: 'boundary_coordinates')
  List<LatLngPointModel> get boundaryCoordinates {
    if (_boundaryCoordinates is EqualUnmodifiableListView)
      return _boundaryCoordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_boundaryCoordinates);
  }

  @override
  final String? projectId;
  @override
  final String? projectName;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final int workerCount;
  @override
  @JsonKey()
  final int assignmentCount;

  @override
  String toString() {
    return 'SiteBoundaryModel(siteIdUnderscore: $siteIdUnderscore, siteIdCamel: $siteIdCamel, siteNameUnderscore: $siteNameUnderscore, siteNameCamel: $siteNameCamel, boundaryType: $boundaryType, centerLat: $centerLat, centerLng: $centerLng, radiusMeters: $radiusMeters, boundaryCoordinates: $boundaryCoordinates, projectId: $projectId, projectName: $projectName, status: $status, workerCount: $workerCount, assignmentCount: $assignmentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SiteBoundaryModelImpl &&
            (identical(other.siteIdUnderscore, siteIdUnderscore) ||
                other.siteIdUnderscore == siteIdUnderscore) &&
            (identical(other.siteIdCamel, siteIdCamel) ||
                other.siteIdCamel == siteIdCamel) &&
            (identical(other.siteNameUnderscore, siteNameUnderscore) ||
                other.siteNameUnderscore == siteNameUnderscore) &&
            (identical(other.siteNameCamel, siteNameCamel) ||
                other.siteNameCamel == siteNameCamel) &&
            (identical(other.boundaryType, boundaryType) ||
                other.boundaryType == boundaryType) &&
            (identical(other.centerLat, centerLat) ||
                other.centerLat == centerLat) &&
            (identical(other.centerLng, centerLng) ||
                other.centerLng == centerLng) &&
            (identical(other.radiusMeters, radiusMeters) ||
                other.radiusMeters == radiusMeters) &&
            const DeepCollectionEquality().equals(
              other._boundaryCoordinates,
              _boundaryCoordinates,
            ) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.workerCount, workerCount) ||
                other.workerCount == workerCount) &&
            (identical(other.assignmentCount, assignmentCount) ||
                other.assignmentCount == assignmentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    siteIdUnderscore,
    siteIdCamel,
    siteNameUnderscore,
    siteNameCamel,
    boundaryType,
    centerLat,
    centerLng,
    radiusMeters,
    const DeepCollectionEquality().hash(_boundaryCoordinates),
    projectId,
    projectName,
    status,
    workerCount,
    assignmentCount,
  );

  /// Create a copy of SiteBoundaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SiteBoundaryModelImplCopyWith<_$SiteBoundaryModelImpl> get copyWith =>
      __$$SiteBoundaryModelImplCopyWithImpl<_$SiteBoundaryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SiteBoundaryModelImplToJson(this);
  }
}

abstract class _SiteBoundaryModel extends SiteBoundaryModel {
  const factory _SiteBoundaryModel({
    @JsonKey(name: 'site_id') final String? siteIdUnderscore,
    @JsonKey(name: 'siteId') final String? siteIdCamel,
    @JsonKey(name: 'site_name') final String? siteNameUnderscore,
    @JsonKey(name: 'siteName') final String? siteNameCamel,
    @JsonKey(name: 'boundary_type') final String boundaryType,
    @JsonKey(name: 'center_lat') final double? centerLat,
    @JsonKey(name: 'center_lng') final double? centerLng,
    @JsonKey(name: 'radius_meters') final double radiusMeters,
    @JsonKey(name: 'boundary_coordinates')
    final List<LatLngPointModel> boundaryCoordinates,
    final String? projectId,
    final String? projectName,
    final String status,
    final int workerCount,
    final int assignmentCount,
  }) = _$SiteBoundaryModelImpl;
  const _SiteBoundaryModel._() : super._();

  factory _SiteBoundaryModel.fromJson(Map<String, dynamic> json) =
      _$SiteBoundaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'site_id')
  String? get siteIdUnderscore;
  @override
  @JsonKey(name: 'siteId')
  String? get siteIdCamel;
  @override
  @JsonKey(name: 'site_name')
  String? get siteNameUnderscore;
  @override
  @JsonKey(name: 'siteName')
  String? get siteNameCamel;
  @override
  @JsonKey(name: 'boundary_type')
  String get boundaryType;
  @override
  @JsonKey(name: 'center_lat')
  double? get centerLat;
  @override
  @JsonKey(name: 'center_lng')
  double? get centerLng;
  @override
  @JsonKey(name: 'radius_meters')
  double get radiusMeters;
  @override
  @JsonKey(name: 'boundary_coordinates')
  List<LatLngPointModel> get boundaryCoordinates;
  @override
  String? get projectId;
  @override
  String? get projectName;
  @override
  String get status;
  @override
  int get workerCount;
  @override
  int get assignmentCount;

  /// Create a copy of SiteBoundaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SiteBoundaryModelImplCopyWith<_$SiteBoundaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
