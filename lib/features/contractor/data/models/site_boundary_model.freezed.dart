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
  String get siteId => throw _privateConstructorUsedError;
  String get siteName => throw _privateConstructorUsedError;
  String get boundaryType => throw _privateConstructorUsedError;
  double? get centerLat => throw _privateConstructorUsedError;
  double? get centerLng => throw _privateConstructorUsedError;
  double get radiusMeters => throw _privateConstructorUsedError;
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
    String siteId,
    String siteName,
    String boundaryType,
    double? centerLat,
    double? centerLng,
    double radiusMeters,
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
    Object? siteId = null,
    Object? siteName = null,
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
            siteId: null == siteId
                ? _value.siteId
                : siteId // ignore: cast_nullable_to_non_nullable
                      as String,
            siteName: null == siteName
                ? _value.siteName
                : siteName // ignore: cast_nullable_to_non_nullable
                      as String,
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
    String siteId,
    String siteName,
    String boundaryType,
    double? centerLat,
    double? centerLng,
    double radiusMeters,
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
    Object? siteId = null,
    Object? siteName = null,
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
        siteId: null == siteId
            ? _value.siteId
            : siteId // ignore: cast_nullable_to_non_nullable
                  as String,
        siteName: null == siteName
            ? _value.siteName
            : siteName // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$SiteBoundaryModelImpl implements _SiteBoundaryModel {
  const _$SiteBoundaryModelImpl({
    required this.siteId,
    required this.siteName,
    this.boundaryType = 'circle',
    this.centerLat,
    this.centerLng,
    this.radiusMeters = 150.0,
    final List<LatLngPointModel> boundaryCoordinates = const [],
    this.projectId,
    this.projectName,
    this.status = 'active',
    this.workerCount = 0,
    this.assignmentCount = 0,
  }) : _boundaryCoordinates = boundaryCoordinates;

  factory _$SiteBoundaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SiteBoundaryModelImplFromJson(json);

  @override
  final String siteId;
  @override
  final String siteName;
  @override
  @JsonKey()
  final String boundaryType;
  @override
  final double? centerLat;
  @override
  final double? centerLng;
  @override
  @JsonKey()
  final double radiusMeters;
  final List<LatLngPointModel> _boundaryCoordinates;
  @override
  @JsonKey()
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
    return 'SiteBoundaryModel(siteId: $siteId, siteName: $siteName, boundaryType: $boundaryType, centerLat: $centerLat, centerLng: $centerLng, radiusMeters: $radiusMeters, boundaryCoordinates: $boundaryCoordinates, projectId: $projectId, projectName: $projectName, status: $status, workerCount: $workerCount, assignmentCount: $assignmentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SiteBoundaryModelImpl &&
            (identical(other.siteId, siteId) || other.siteId == siteId) &&
            (identical(other.siteName, siteName) ||
                other.siteName == siteName) &&
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
    siteId,
    siteName,
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

abstract class _SiteBoundaryModel implements SiteBoundaryModel {
  const factory _SiteBoundaryModel({
    required final String siteId,
    required final String siteName,
    final String boundaryType,
    final double? centerLat,
    final double? centerLng,
    final double radiusMeters,
    final List<LatLngPointModel> boundaryCoordinates,
    final String? projectId,
    final String? projectName,
    final String status,
    final int workerCount,
    final int assignmentCount,
  }) = _$SiteBoundaryModelImpl;

  factory _SiteBoundaryModel.fromJson(Map<String, dynamic> json) =
      _$SiteBoundaryModelImpl.fromJson;

  @override
  String get siteId;
  @override
  String get siteName;
  @override
  String get boundaryType;
  @override
  double? get centerLat;
  @override
  double? get centerLng;
  @override
  double get radiusMeters;
  @override
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
