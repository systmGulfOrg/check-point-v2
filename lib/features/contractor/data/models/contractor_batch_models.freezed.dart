// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contractor_batch_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ContractorDailyAttendanceRequestBody
_$ContractorDailyAttendanceRequestBodyFromJson(Map<String, dynamic> json) {
  return _ContractorDailyAttendanceRequestBody.fromJson(json);
}

/// @nodoc
mixin _$ContractorDailyAttendanceRequestBody {
  @JsonKey(name: 'contractor_id')
  String get contractorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'site_id')
  String get siteId => throw _privateConstructorUsedError;
  @JsonKey(name: 'date')
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'notes')
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this ContractorDailyAttendanceRequestBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContractorDailyAttendanceRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContractorDailyAttendanceRequestBodyCopyWith<
    ContractorDailyAttendanceRequestBody
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContractorDailyAttendanceRequestBodyCopyWith<$Res> {
  factory $ContractorDailyAttendanceRequestBodyCopyWith(
    ContractorDailyAttendanceRequestBody value,
    $Res Function(ContractorDailyAttendanceRequestBody) then,
  ) =
      _$ContractorDailyAttendanceRequestBodyCopyWithImpl<
        $Res,
        ContractorDailyAttendanceRequestBody
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'contractor_id') String contractorId,
    @JsonKey(name: 'site_id') String siteId,
    @JsonKey(name: 'date') String date,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'notes') String? notes,
  });
}

/// @nodoc
class _$ContractorDailyAttendanceRequestBodyCopyWithImpl<
  $Res,
  $Val extends ContractorDailyAttendanceRequestBody
>
    implements $ContractorDailyAttendanceRequestBodyCopyWith<$Res> {
  _$ContractorDailyAttendanceRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContractorDailyAttendanceRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contractorId = null,
    Object? siteId = null,
    Object? date = null,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            contractorId: null == contractorId
                ? _value.contractorId
                : contractorId // ignore: cast_nullable_to_non_nullable
                      as String,
            siteId: null == siteId
                ? _value.siteId
                : siteId // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContractorDailyAttendanceRequestBodyImplCopyWith<$Res>
    implements $ContractorDailyAttendanceRequestBodyCopyWith<$Res> {
  factory _$$ContractorDailyAttendanceRequestBodyImplCopyWith(
    _$ContractorDailyAttendanceRequestBodyImpl value,
    $Res Function(_$ContractorDailyAttendanceRequestBodyImpl) then,
  ) = __$$ContractorDailyAttendanceRequestBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'contractor_id') String contractorId,
    @JsonKey(name: 'site_id') String siteId,
    @JsonKey(name: 'date') String date,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'notes') String? notes,
  });
}

/// @nodoc
class __$$ContractorDailyAttendanceRequestBodyImplCopyWithImpl<$Res>
    extends
        _$ContractorDailyAttendanceRequestBodyCopyWithImpl<
          $Res,
          _$ContractorDailyAttendanceRequestBodyImpl
        >
    implements _$$ContractorDailyAttendanceRequestBodyImplCopyWith<$Res> {
  __$$ContractorDailyAttendanceRequestBodyImplCopyWithImpl(
    _$ContractorDailyAttendanceRequestBodyImpl _value,
    $Res Function(_$ContractorDailyAttendanceRequestBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContractorDailyAttendanceRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contractorId = null,
    Object? siteId = null,
    Object? date = null,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$ContractorDailyAttendanceRequestBodyImpl(
        contractorId: null == contractorId
            ? _value.contractorId
            : contractorId // ignore: cast_nullable_to_non_nullable
                  as String,
        siteId: null == siteId
            ? _value.siteId
            : siteId // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContractorDailyAttendanceRequestBodyImpl
    implements _ContractorDailyAttendanceRequestBody {
  const _$ContractorDailyAttendanceRequestBodyImpl({
    @JsonKey(name: 'contractor_id') required this.contractorId,
    @JsonKey(name: 'site_id') required this.siteId,
    @JsonKey(name: 'date') required this.date,
    @JsonKey(name: 'status') this.status = 'Present',
    @JsonKey(name: 'notes') this.notes,
  });

  factory _$ContractorDailyAttendanceRequestBodyImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$ContractorDailyAttendanceRequestBodyImplFromJson(json);

  @override
  @JsonKey(name: 'contractor_id')
  final String contractorId;
  @override
  @JsonKey(name: 'site_id')
  final String siteId;
  @override
  @JsonKey(name: 'date')
  final String date;
  @override
  @JsonKey(name: 'status')
  final String status;
  @override
  @JsonKey(name: 'notes')
  final String? notes;

  @override
  String toString() {
    return 'ContractorDailyAttendanceRequestBody(contractorId: $contractorId, siteId: $siteId, date: $date, status: $status, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContractorDailyAttendanceRequestBodyImpl &&
            (identical(other.contractorId, contractorId) ||
                other.contractorId == contractorId) &&
            (identical(other.siteId, siteId) || other.siteId == siteId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, contractorId, siteId, date, status, notes);

  /// Create a copy of ContractorDailyAttendanceRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContractorDailyAttendanceRequestBodyImplCopyWith<
    _$ContractorDailyAttendanceRequestBodyImpl
  >
  get copyWith =>
      __$$ContractorDailyAttendanceRequestBodyImplCopyWithImpl<
        _$ContractorDailyAttendanceRequestBodyImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContractorDailyAttendanceRequestBodyImplToJson(this);
  }
}

abstract class _ContractorDailyAttendanceRequestBody
    implements ContractorDailyAttendanceRequestBody {
  const factory _ContractorDailyAttendanceRequestBody({
    @JsonKey(name: 'contractor_id') required final String contractorId,
    @JsonKey(name: 'site_id') required final String siteId,
    @JsonKey(name: 'date') required final String date,
    @JsonKey(name: 'status') final String status,
    @JsonKey(name: 'notes') final String? notes,
  }) = _$ContractorDailyAttendanceRequestBodyImpl;

  factory _ContractorDailyAttendanceRequestBody.fromJson(
    Map<String, dynamic> json,
  ) = _$ContractorDailyAttendanceRequestBodyImpl.fromJson;

  @override
  @JsonKey(name: 'contractor_id')
  String get contractorId;
  @override
  @JsonKey(name: 'site_id')
  String get siteId;
  @override
  @JsonKey(name: 'date')
  String get date;
  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(name: 'notes')
  String? get notes;

  /// Create a copy of ContractorDailyAttendanceRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContractorDailyAttendanceRequestBodyImplCopyWith<
    _$ContractorDailyAttendanceRequestBodyImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

BatchWorkerAttendanceRequestBody _$BatchWorkerAttendanceRequestBodyFromJson(
  Map<String, dynamic> json,
) {
  return _BatchWorkerAttendanceRequestBody.fromJson(json);
}

/// @nodoc
mixin _$BatchWorkerAttendanceRequestBody {
  @JsonKey(name: 'site_id')
  String get siteId => throw _privateConstructorUsedError;
  @JsonKey(name: 'contractor_id')
  String get contractorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'date')
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'worker_ids')
  List<String> get workerIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'latitude')
  double? get latitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'longitude')
  double? get longitude => throw _privateConstructorUsedError;

  /// Serializes this BatchWorkerAttendanceRequestBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BatchWorkerAttendanceRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BatchWorkerAttendanceRequestBodyCopyWith<BatchWorkerAttendanceRequestBody>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchWorkerAttendanceRequestBodyCopyWith<$Res> {
  factory $BatchWorkerAttendanceRequestBodyCopyWith(
    BatchWorkerAttendanceRequestBody value,
    $Res Function(BatchWorkerAttendanceRequestBody) then,
  ) =
      _$BatchWorkerAttendanceRequestBodyCopyWithImpl<
        $Res,
        BatchWorkerAttendanceRequestBody
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'site_id') String siteId,
    @JsonKey(name: 'contractor_id') String contractorId,
    @JsonKey(name: 'date') String date,
    @JsonKey(name: 'worker_ids') List<String> workerIds,
    @JsonKey(name: 'latitude') double? latitude,
    @JsonKey(name: 'longitude') double? longitude,
  });
}

/// @nodoc
class _$BatchWorkerAttendanceRequestBodyCopyWithImpl<
  $Res,
  $Val extends BatchWorkerAttendanceRequestBody
>
    implements $BatchWorkerAttendanceRequestBodyCopyWith<$Res> {
  _$BatchWorkerAttendanceRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BatchWorkerAttendanceRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? siteId = null,
    Object? contractorId = null,
    Object? date = null,
    Object? workerIds = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(
      _value.copyWith(
            siteId: null == siteId
                ? _value.siteId
                : siteId // ignore: cast_nullable_to_non_nullable
                      as String,
            contractorId: null == contractorId
                ? _value.contractorId
                : contractorId // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            workerIds: null == workerIds
                ? _value.workerIds
                : workerIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BatchWorkerAttendanceRequestBodyImplCopyWith<$Res>
    implements $BatchWorkerAttendanceRequestBodyCopyWith<$Res> {
  factory _$$BatchWorkerAttendanceRequestBodyImplCopyWith(
    _$BatchWorkerAttendanceRequestBodyImpl value,
    $Res Function(_$BatchWorkerAttendanceRequestBodyImpl) then,
  ) = __$$BatchWorkerAttendanceRequestBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'site_id') String siteId,
    @JsonKey(name: 'contractor_id') String contractorId,
    @JsonKey(name: 'date') String date,
    @JsonKey(name: 'worker_ids') List<String> workerIds,
    @JsonKey(name: 'latitude') double? latitude,
    @JsonKey(name: 'longitude') double? longitude,
  });
}

/// @nodoc
class __$$BatchWorkerAttendanceRequestBodyImplCopyWithImpl<$Res>
    extends
        _$BatchWorkerAttendanceRequestBodyCopyWithImpl<
          $Res,
          _$BatchWorkerAttendanceRequestBodyImpl
        >
    implements _$$BatchWorkerAttendanceRequestBodyImplCopyWith<$Res> {
  __$$BatchWorkerAttendanceRequestBodyImplCopyWithImpl(
    _$BatchWorkerAttendanceRequestBodyImpl _value,
    $Res Function(_$BatchWorkerAttendanceRequestBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BatchWorkerAttendanceRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? siteId = null,
    Object? contractorId = null,
    Object? date = null,
    Object? workerIds = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(
      _$BatchWorkerAttendanceRequestBodyImpl(
        siteId: null == siteId
            ? _value.siteId
            : siteId // ignore: cast_nullable_to_non_nullable
                  as String,
        contractorId: null == contractorId
            ? _value.contractorId
            : contractorId // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        workerIds: null == workerIds
            ? _value._workerIds
            : workerIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BatchWorkerAttendanceRequestBodyImpl
    implements _BatchWorkerAttendanceRequestBody {
  const _$BatchWorkerAttendanceRequestBodyImpl({
    @JsonKey(name: 'site_id') required this.siteId,
    @JsonKey(name: 'contractor_id') required this.contractorId,
    @JsonKey(name: 'date') required this.date,
    @JsonKey(name: 'worker_ids') required final List<String> workerIds,
    @JsonKey(name: 'latitude') this.latitude,
    @JsonKey(name: 'longitude') this.longitude,
  }) : _workerIds = workerIds;

  factory _$BatchWorkerAttendanceRequestBodyImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$BatchWorkerAttendanceRequestBodyImplFromJson(json);

  @override
  @JsonKey(name: 'site_id')
  final String siteId;
  @override
  @JsonKey(name: 'contractor_id')
  final String contractorId;
  @override
  @JsonKey(name: 'date')
  final String date;
  final List<String> _workerIds;
  @override
  @JsonKey(name: 'worker_ids')
  List<String> get workerIds {
    if (_workerIds is EqualUnmodifiableListView) return _workerIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workerIds);
  }

  @override
  @JsonKey(name: 'latitude')
  final double? latitude;
  @override
  @JsonKey(name: 'longitude')
  final double? longitude;

  @override
  String toString() {
    return 'BatchWorkerAttendanceRequestBody(siteId: $siteId, contractorId: $contractorId, date: $date, workerIds: $workerIds, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchWorkerAttendanceRequestBodyImpl &&
            (identical(other.siteId, siteId) || other.siteId == siteId) &&
            (identical(other.contractorId, contractorId) ||
                other.contractorId == contractorId) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(
              other._workerIds,
              _workerIds,
            ) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    siteId,
    contractorId,
    date,
    const DeepCollectionEquality().hash(_workerIds),
    latitude,
    longitude,
  );

  /// Create a copy of BatchWorkerAttendanceRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchWorkerAttendanceRequestBodyImplCopyWith<
    _$BatchWorkerAttendanceRequestBodyImpl
  >
  get copyWith =>
      __$$BatchWorkerAttendanceRequestBodyImplCopyWithImpl<
        _$BatchWorkerAttendanceRequestBodyImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BatchWorkerAttendanceRequestBodyImplToJson(this);
  }
}

abstract class _BatchWorkerAttendanceRequestBody
    implements BatchWorkerAttendanceRequestBody {
  const factory _BatchWorkerAttendanceRequestBody({
    @JsonKey(name: 'site_id') required final String siteId,
    @JsonKey(name: 'contractor_id') required final String contractorId,
    @JsonKey(name: 'date') required final String date,
    @JsonKey(name: 'worker_ids') required final List<String> workerIds,
    @JsonKey(name: 'latitude') final double? latitude,
    @JsonKey(name: 'longitude') final double? longitude,
  }) = _$BatchWorkerAttendanceRequestBodyImpl;

  factory _BatchWorkerAttendanceRequestBody.fromJson(
    Map<String, dynamic> json,
  ) = _$BatchWorkerAttendanceRequestBodyImpl.fromJson;

  @override
  @JsonKey(name: 'site_id')
  String get siteId;
  @override
  @JsonKey(name: 'contractor_id')
  String get contractorId;
  @override
  @JsonKey(name: 'date')
  String get date;
  @override
  @JsonKey(name: 'worker_ids')
  List<String> get workerIds;
  @override
  @JsonKey(name: 'latitude')
  double? get latitude;
  @override
  @JsonKey(name: 'longitude')
  double? get longitude;

  /// Create a copy of BatchWorkerAttendanceRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BatchWorkerAttendanceRequestBodyImplCopyWith<
    _$BatchWorkerAttendanceRequestBodyImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

SingleWorkerBatchResultModel _$SingleWorkerBatchResultModelFromJson(
  Map<String, dynamic> json,
) {
  return _SingleWorkerBatchResultModel.fromJson(json);
}

/// @nodoc
mixin _$SingleWorkerBatchResultModel {
  @JsonKey(name: 'workerId')
  String get workerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'workerName')
  String? get workerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError; // RECORDED, REJECTED
  @JsonKey(name: 'errorCode')
  String? get errorCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'errorMessage')
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this SingleWorkerBatchResultModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SingleWorkerBatchResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SingleWorkerBatchResultModelCopyWith<SingleWorkerBatchResultModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SingleWorkerBatchResultModelCopyWith<$Res> {
  factory $SingleWorkerBatchResultModelCopyWith(
    SingleWorkerBatchResultModel value,
    $Res Function(SingleWorkerBatchResultModel) then,
  ) =
      _$SingleWorkerBatchResultModelCopyWithImpl<
        $Res,
        SingleWorkerBatchResultModel
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'workerId') String workerId,
    @JsonKey(name: 'workerName') String? workerName,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'errorCode') String? errorCode,
    @JsonKey(name: 'errorMessage') String? errorMessage,
  });
}

/// @nodoc
class _$SingleWorkerBatchResultModelCopyWithImpl<
  $Res,
  $Val extends SingleWorkerBatchResultModel
>
    implements $SingleWorkerBatchResultModelCopyWith<$Res> {
  _$SingleWorkerBatchResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SingleWorkerBatchResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = freezed,
    Object? status = null,
    Object? errorCode = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            workerId: null == workerId
                ? _value.workerId
                : workerId // ignore: cast_nullable_to_non_nullable
                      as String,
            workerName: freezed == workerName
                ? _value.workerName
                : workerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            errorCode: freezed == errorCode
                ? _value.errorCode
                : errorCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SingleWorkerBatchResultModelImplCopyWith<$Res>
    implements $SingleWorkerBatchResultModelCopyWith<$Res> {
  factory _$$SingleWorkerBatchResultModelImplCopyWith(
    _$SingleWorkerBatchResultModelImpl value,
    $Res Function(_$SingleWorkerBatchResultModelImpl) then,
  ) = __$$SingleWorkerBatchResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'workerId') String workerId,
    @JsonKey(name: 'workerName') String? workerName,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'errorCode') String? errorCode,
    @JsonKey(name: 'errorMessage') String? errorMessage,
  });
}

/// @nodoc
class __$$SingleWorkerBatchResultModelImplCopyWithImpl<$Res>
    extends
        _$SingleWorkerBatchResultModelCopyWithImpl<
          $Res,
          _$SingleWorkerBatchResultModelImpl
        >
    implements _$$SingleWorkerBatchResultModelImplCopyWith<$Res> {
  __$$SingleWorkerBatchResultModelImplCopyWithImpl(
    _$SingleWorkerBatchResultModelImpl _value,
    $Res Function(_$SingleWorkerBatchResultModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SingleWorkerBatchResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = freezed,
    Object? status = null,
    Object? errorCode = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$SingleWorkerBatchResultModelImpl(
        workerId: null == workerId
            ? _value.workerId
            : workerId // ignore: cast_nullable_to_non_nullable
                  as String,
        workerName: freezed == workerName
            ? _value.workerName
            : workerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SingleWorkerBatchResultModelImpl
    implements _SingleWorkerBatchResultModel {
  const _$SingleWorkerBatchResultModelImpl({
    @JsonKey(name: 'workerId') required this.workerId,
    @JsonKey(name: 'workerName') this.workerName,
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'errorCode') this.errorCode,
    @JsonKey(name: 'errorMessage') this.errorMessage,
  });

  factory _$SingleWorkerBatchResultModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$SingleWorkerBatchResultModelImplFromJson(json);

  @override
  @JsonKey(name: 'workerId')
  final String workerId;
  @override
  @JsonKey(name: 'workerName')
  final String? workerName;
  @override
  @JsonKey(name: 'status')
  final String status;
  // RECORDED, REJECTED
  @override
  @JsonKey(name: 'errorCode')
  final String? errorCode;
  @override
  @JsonKey(name: 'errorMessage')
  final String? errorMessage;

  @override
  String toString() {
    return 'SingleWorkerBatchResultModel(workerId: $workerId, workerName: $workerName, status: $status, errorCode: $errorCode, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SingleWorkerBatchResultModelImpl &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    workerId,
    workerName,
    status,
    errorCode,
    errorMessage,
  );

  /// Create a copy of SingleWorkerBatchResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SingleWorkerBatchResultModelImplCopyWith<
    _$SingleWorkerBatchResultModelImpl
  >
  get copyWith =>
      __$$SingleWorkerBatchResultModelImplCopyWithImpl<
        _$SingleWorkerBatchResultModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SingleWorkerBatchResultModelImplToJson(this);
  }
}

abstract class _SingleWorkerBatchResultModel
    implements SingleWorkerBatchResultModel {
  const factory _SingleWorkerBatchResultModel({
    @JsonKey(name: 'workerId') required final String workerId,
    @JsonKey(name: 'workerName') final String? workerName,
    @JsonKey(name: 'status') required final String status,
    @JsonKey(name: 'errorCode') final String? errorCode,
    @JsonKey(name: 'errorMessage') final String? errorMessage,
  }) = _$SingleWorkerBatchResultModelImpl;

  factory _SingleWorkerBatchResultModel.fromJson(Map<String, dynamic> json) =
      _$SingleWorkerBatchResultModelImpl.fromJson;

  @override
  @JsonKey(name: 'workerId')
  String get workerId;
  @override
  @JsonKey(name: 'workerName')
  String? get workerName;
  @override
  @JsonKey(name: 'status')
  String get status; // RECORDED, REJECTED
  @override
  @JsonKey(name: 'errorCode')
  String? get errorCode;
  @override
  @JsonKey(name: 'errorMessage')
  String? get errorMessage;

  /// Create a copy of SingleWorkerBatchResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SingleWorkerBatchResultModelImplCopyWith<
    _$SingleWorkerBatchResultModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

BatchWorkerAttendanceSummaryModel _$BatchWorkerAttendanceSummaryModelFromJson(
  Map<String, dynamic> json,
) {
  return _BatchWorkerAttendanceSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$BatchWorkerAttendanceSummaryModel {
  @JsonKey(name: 'totalSubmitted')
  int get totalSubmitted => throw _privateConstructorUsedError;
  @JsonKey(name: 'successfulCount')
  int get successfulCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'failedCount')
  int get failedCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'results')
  List<SingleWorkerBatchResultModel> get results =>
      throw _privateConstructorUsedError;

  /// Serializes this BatchWorkerAttendanceSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BatchWorkerAttendanceSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BatchWorkerAttendanceSummaryModelCopyWith<BatchWorkerAttendanceSummaryModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchWorkerAttendanceSummaryModelCopyWith<$Res> {
  factory $BatchWorkerAttendanceSummaryModelCopyWith(
    BatchWorkerAttendanceSummaryModel value,
    $Res Function(BatchWorkerAttendanceSummaryModel) then,
  ) =
      _$BatchWorkerAttendanceSummaryModelCopyWithImpl<
        $Res,
        BatchWorkerAttendanceSummaryModel
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'totalSubmitted') int totalSubmitted,
    @JsonKey(name: 'successfulCount') int successfulCount,
    @JsonKey(name: 'failedCount') int failedCount,
    @JsonKey(name: 'results') List<SingleWorkerBatchResultModel> results,
  });
}

/// @nodoc
class _$BatchWorkerAttendanceSummaryModelCopyWithImpl<
  $Res,
  $Val extends BatchWorkerAttendanceSummaryModel
>
    implements $BatchWorkerAttendanceSummaryModelCopyWith<$Res> {
  _$BatchWorkerAttendanceSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BatchWorkerAttendanceSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSubmitted = null,
    Object? successfulCount = null,
    Object? failedCount = null,
    Object? results = null,
  }) {
    return _then(
      _value.copyWith(
            totalSubmitted: null == totalSubmitted
                ? _value.totalSubmitted
                : totalSubmitted // ignore: cast_nullable_to_non_nullable
                      as int,
            successfulCount: null == successfulCount
                ? _value.successfulCount
                : successfulCount // ignore: cast_nullable_to_non_nullable
                      as int,
            failedCount: null == failedCount
                ? _value.failedCount
                : failedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<SingleWorkerBatchResultModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BatchWorkerAttendanceSummaryModelImplCopyWith<$Res>
    implements $BatchWorkerAttendanceSummaryModelCopyWith<$Res> {
  factory _$$BatchWorkerAttendanceSummaryModelImplCopyWith(
    _$BatchWorkerAttendanceSummaryModelImpl value,
    $Res Function(_$BatchWorkerAttendanceSummaryModelImpl) then,
  ) = __$$BatchWorkerAttendanceSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'totalSubmitted') int totalSubmitted,
    @JsonKey(name: 'successfulCount') int successfulCount,
    @JsonKey(name: 'failedCount') int failedCount,
    @JsonKey(name: 'results') List<SingleWorkerBatchResultModel> results,
  });
}

/// @nodoc
class __$$BatchWorkerAttendanceSummaryModelImplCopyWithImpl<$Res>
    extends
        _$BatchWorkerAttendanceSummaryModelCopyWithImpl<
          $Res,
          _$BatchWorkerAttendanceSummaryModelImpl
        >
    implements _$$BatchWorkerAttendanceSummaryModelImplCopyWith<$Res> {
  __$$BatchWorkerAttendanceSummaryModelImplCopyWithImpl(
    _$BatchWorkerAttendanceSummaryModelImpl _value,
    $Res Function(_$BatchWorkerAttendanceSummaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BatchWorkerAttendanceSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSubmitted = null,
    Object? successfulCount = null,
    Object? failedCount = null,
    Object? results = null,
  }) {
    return _then(
      _$BatchWorkerAttendanceSummaryModelImpl(
        totalSubmitted: null == totalSubmitted
            ? _value.totalSubmitted
            : totalSubmitted // ignore: cast_nullable_to_non_nullable
                  as int,
        successfulCount: null == successfulCount
            ? _value.successfulCount
            : successfulCount // ignore: cast_nullable_to_non_nullable
                  as int,
        failedCount: null == failedCount
            ? _value.failedCount
            : failedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<SingleWorkerBatchResultModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BatchWorkerAttendanceSummaryModelImpl
    implements _BatchWorkerAttendanceSummaryModel {
  const _$BatchWorkerAttendanceSummaryModelImpl({
    @JsonKey(name: 'totalSubmitted') this.totalSubmitted = 0,
    @JsonKey(name: 'successfulCount') this.successfulCount = 0,
    @JsonKey(name: 'failedCount') this.failedCount = 0,
    @JsonKey(name: 'results')
    final List<SingleWorkerBatchResultModel> results = const [],
  }) : _results = results;

  factory _$BatchWorkerAttendanceSummaryModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$BatchWorkerAttendanceSummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'totalSubmitted')
  final int totalSubmitted;
  @override
  @JsonKey(name: 'successfulCount')
  final int successfulCount;
  @override
  @JsonKey(name: 'failedCount')
  final int failedCount;
  final List<SingleWorkerBatchResultModel> _results;
  @override
  @JsonKey(name: 'results')
  List<SingleWorkerBatchResultModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'BatchWorkerAttendanceSummaryModel(totalSubmitted: $totalSubmitted, successfulCount: $successfulCount, failedCount: $failedCount, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchWorkerAttendanceSummaryModelImpl &&
            (identical(other.totalSubmitted, totalSubmitted) ||
                other.totalSubmitted == totalSubmitted) &&
            (identical(other.successfulCount, successfulCount) ||
                other.successfulCount == successfulCount) &&
            (identical(other.failedCount, failedCount) ||
                other.failedCount == failedCount) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalSubmitted,
    successfulCount,
    failedCount,
    const DeepCollectionEquality().hash(_results),
  );

  /// Create a copy of BatchWorkerAttendanceSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchWorkerAttendanceSummaryModelImplCopyWith<
    _$BatchWorkerAttendanceSummaryModelImpl
  >
  get copyWith =>
      __$$BatchWorkerAttendanceSummaryModelImplCopyWithImpl<
        _$BatchWorkerAttendanceSummaryModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BatchWorkerAttendanceSummaryModelImplToJson(this);
  }
}

abstract class _BatchWorkerAttendanceSummaryModel
    implements BatchWorkerAttendanceSummaryModel {
  const factory _BatchWorkerAttendanceSummaryModel({
    @JsonKey(name: 'totalSubmitted') final int totalSubmitted,
    @JsonKey(name: 'successfulCount') final int successfulCount,
    @JsonKey(name: 'failedCount') final int failedCount,
    @JsonKey(name: 'results') final List<SingleWorkerBatchResultModel> results,
  }) = _$BatchWorkerAttendanceSummaryModelImpl;

  factory _BatchWorkerAttendanceSummaryModel.fromJson(
    Map<String, dynamic> json,
  ) = _$BatchWorkerAttendanceSummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'totalSubmitted')
  int get totalSubmitted;
  @override
  @JsonKey(name: 'successfulCount')
  int get successfulCount;
  @override
  @JsonKey(name: 'failedCount')
  int get failedCount;
  @override
  @JsonKey(name: 'results')
  List<SingleWorkerBatchResultModel> get results;

  /// Create a copy of BatchWorkerAttendanceSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BatchWorkerAttendanceSummaryModelImplCopyWith<
    _$BatchWorkerAttendanceSummaryModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

BatchWorkerAttendanceResponseModel _$BatchWorkerAttendanceResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _BatchWorkerAttendanceResponseModel.fromJson(json);
}

/// @nodoc
mixin _$BatchWorkerAttendanceResponseModel {
  @JsonKey(name: 'isSuccess')
  bool get isSuccess => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'value')
  BatchWorkerAttendanceSummaryModel? get value =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'errorMessage')
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this BatchWorkerAttendanceResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BatchWorkerAttendanceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BatchWorkerAttendanceResponseModelCopyWith<
    BatchWorkerAttendanceResponseModel
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchWorkerAttendanceResponseModelCopyWith<$Res> {
  factory $BatchWorkerAttendanceResponseModelCopyWith(
    BatchWorkerAttendanceResponseModel value,
    $Res Function(BatchWorkerAttendanceResponseModel) then,
  ) =
      _$BatchWorkerAttendanceResponseModelCopyWithImpl<
        $Res,
        BatchWorkerAttendanceResponseModel
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'isSuccess') bool isSuccess,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'value') BatchWorkerAttendanceSummaryModel? value,
    @JsonKey(name: 'errorMessage') String? errorMessage,
  });

  $BatchWorkerAttendanceSummaryModelCopyWith<$Res>? get value;
}

/// @nodoc
class _$BatchWorkerAttendanceResponseModelCopyWithImpl<
  $Res,
  $Val extends BatchWorkerAttendanceResponseModel
>
    implements $BatchWorkerAttendanceResponseModelCopyWith<$Res> {
  _$BatchWorkerAttendanceResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BatchWorkerAttendanceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? status = freezed,
    Object? value = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isSuccess: null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int?,
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as BatchWorkerAttendanceSummaryModel?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of BatchWorkerAttendanceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BatchWorkerAttendanceSummaryModelCopyWith<$Res>? get value {
    if (_value.value == null) {
      return null;
    }

    return $BatchWorkerAttendanceSummaryModelCopyWith<$Res>(_value.value!, (
      value,
    ) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BatchWorkerAttendanceResponseModelImplCopyWith<$Res>
    implements $BatchWorkerAttendanceResponseModelCopyWith<$Res> {
  factory _$$BatchWorkerAttendanceResponseModelImplCopyWith(
    _$BatchWorkerAttendanceResponseModelImpl value,
    $Res Function(_$BatchWorkerAttendanceResponseModelImpl) then,
  ) = __$$BatchWorkerAttendanceResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'isSuccess') bool isSuccess,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'value') BatchWorkerAttendanceSummaryModel? value,
    @JsonKey(name: 'errorMessage') String? errorMessage,
  });

  @override
  $BatchWorkerAttendanceSummaryModelCopyWith<$Res>? get value;
}

/// @nodoc
class __$$BatchWorkerAttendanceResponseModelImplCopyWithImpl<$Res>
    extends
        _$BatchWorkerAttendanceResponseModelCopyWithImpl<
          $Res,
          _$BatchWorkerAttendanceResponseModelImpl
        >
    implements _$$BatchWorkerAttendanceResponseModelImplCopyWith<$Res> {
  __$$BatchWorkerAttendanceResponseModelImplCopyWithImpl(
    _$BatchWorkerAttendanceResponseModelImpl _value,
    $Res Function(_$BatchWorkerAttendanceResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BatchWorkerAttendanceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? status = freezed,
    Object? value = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$BatchWorkerAttendanceResponseModelImpl(
        isSuccess: null == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int?,
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as BatchWorkerAttendanceSummaryModel?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BatchWorkerAttendanceResponseModelImpl
    implements _BatchWorkerAttendanceResponseModel {
  const _$BatchWorkerAttendanceResponseModelImpl({
    @JsonKey(name: 'isSuccess') this.isSuccess = false,
    @JsonKey(name: 'status') this.status,
    @JsonKey(name: 'value') this.value,
    @JsonKey(name: 'errorMessage') this.errorMessage,
  });

  factory _$BatchWorkerAttendanceResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$BatchWorkerAttendanceResponseModelImplFromJson(json);

  @override
  @JsonKey(name: 'isSuccess')
  final bool isSuccess;
  @override
  @JsonKey(name: 'status')
  final int? status;
  @override
  @JsonKey(name: 'value')
  final BatchWorkerAttendanceSummaryModel? value;
  @override
  @JsonKey(name: 'errorMessage')
  final String? errorMessage;

  @override
  String toString() {
    return 'BatchWorkerAttendanceResponseModel(isSuccess: $isSuccess, status: $status, value: $value, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchWorkerAttendanceResponseModelImpl &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isSuccess, status, value, errorMessage);

  /// Create a copy of BatchWorkerAttendanceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchWorkerAttendanceResponseModelImplCopyWith<
    _$BatchWorkerAttendanceResponseModelImpl
  >
  get copyWith =>
      __$$BatchWorkerAttendanceResponseModelImplCopyWithImpl<
        _$BatchWorkerAttendanceResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BatchWorkerAttendanceResponseModelImplToJson(this);
  }
}

abstract class _BatchWorkerAttendanceResponseModel
    implements BatchWorkerAttendanceResponseModel {
  const factory _BatchWorkerAttendanceResponseModel({
    @JsonKey(name: 'isSuccess') final bool isSuccess,
    @JsonKey(name: 'status') final int? status,
    @JsonKey(name: 'value') final BatchWorkerAttendanceSummaryModel? value,
    @JsonKey(name: 'errorMessage') final String? errorMessage,
  }) = _$BatchWorkerAttendanceResponseModelImpl;

  factory _BatchWorkerAttendanceResponseModel.fromJson(
    Map<String, dynamic> json,
  ) = _$BatchWorkerAttendanceResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'isSuccess')
  bool get isSuccess;
  @override
  @JsonKey(name: 'status')
  int? get status;
  @override
  @JsonKey(name: 'value')
  BatchWorkerAttendanceSummaryModel? get value;
  @override
  @JsonKey(name: 'errorMessage')
  String? get errorMessage;

  /// Create a copy of BatchWorkerAttendanceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BatchWorkerAttendanceResponseModelImplCopyWith<
    _$BatchWorkerAttendanceResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

NationalIdDetailsModel _$NationalIdDetailsModelFromJson(
  Map<String, dynamic> json,
) {
  return _NationalIdDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$NationalIdDetailsModel {
  @JsonKey(name: 'birthDate')
  String? get birthDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender')
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'governorate')
  String? get governorate => throw _privateConstructorUsedError;
  @JsonKey(name: 'governorateCode')
  String? get governorateCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'century')
  String? get century => throw _privateConstructorUsedError;

  /// Serializes this NationalIdDetailsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NationalIdDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NationalIdDetailsModelCopyWith<NationalIdDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NationalIdDetailsModelCopyWith<$Res> {
  factory $NationalIdDetailsModelCopyWith(
    NationalIdDetailsModel value,
    $Res Function(NationalIdDetailsModel) then,
  ) = _$NationalIdDetailsModelCopyWithImpl<$Res, NationalIdDetailsModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'birthDate') String? birthDate,
    @JsonKey(name: 'gender') String? gender,
    @JsonKey(name: 'governorate') String? governorate,
    @JsonKey(name: 'governorateCode') String? governorateCode,
    @JsonKey(name: 'century') String? century,
  });
}

/// @nodoc
class _$NationalIdDetailsModelCopyWithImpl<
  $Res,
  $Val extends NationalIdDetailsModel
>
    implements $NationalIdDetailsModelCopyWith<$Res> {
  _$NationalIdDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NationalIdDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? birthDate = freezed,
    Object? gender = freezed,
    Object? governorate = freezed,
    Object? governorateCode = freezed,
    Object? century = freezed,
  }) {
    return _then(
      _value.copyWith(
            birthDate: freezed == birthDate
                ? _value.birthDate
                : birthDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            governorate: freezed == governorate
                ? _value.governorate
                : governorate // ignore: cast_nullable_to_non_nullable
                      as String?,
            governorateCode: freezed == governorateCode
                ? _value.governorateCode
                : governorateCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            century: freezed == century
                ? _value.century
                : century // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NationalIdDetailsModelImplCopyWith<$Res>
    implements $NationalIdDetailsModelCopyWith<$Res> {
  factory _$$NationalIdDetailsModelImplCopyWith(
    _$NationalIdDetailsModelImpl value,
    $Res Function(_$NationalIdDetailsModelImpl) then,
  ) = __$$NationalIdDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'birthDate') String? birthDate,
    @JsonKey(name: 'gender') String? gender,
    @JsonKey(name: 'governorate') String? governorate,
    @JsonKey(name: 'governorateCode') String? governorateCode,
    @JsonKey(name: 'century') String? century,
  });
}

/// @nodoc
class __$$NationalIdDetailsModelImplCopyWithImpl<$Res>
    extends
        _$NationalIdDetailsModelCopyWithImpl<$Res, _$NationalIdDetailsModelImpl>
    implements _$$NationalIdDetailsModelImplCopyWith<$Res> {
  __$$NationalIdDetailsModelImplCopyWithImpl(
    _$NationalIdDetailsModelImpl _value,
    $Res Function(_$NationalIdDetailsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NationalIdDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? birthDate = freezed,
    Object? gender = freezed,
    Object? governorate = freezed,
    Object? governorateCode = freezed,
    Object? century = freezed,
  }) {
    return _then(
      _$NationalIdDetailsModelImpl(
        birthDate: freezed == birthDate
            ? _value.birthDate
            : birthDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        governorate: freezed == governorate
            ? _value.governorate
            : governorate // ignore: cast_nullable_to_non_nullable
                  as String?,
        governorateCode: freezed == governorateCode
            ? _value.governorateCode
            : governorateCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        century: freezed == century
            ? _value.century
            : century // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NationalIdDetailsModelImpl implements _NationalIdDetailsModel {
  const _$NationalIdDetailsModelImpl({
    @JsonKey(name: 'birthDate') this.birthDate,
    @JsonKey(name: 'gender') this.gender,
    @JsonKey(name: 'governorate') this.governorate,
    @JsonKey(name: 'governorateCode') this.governorateCode,
    @JsonKey(name: 'century') this.century,
  });

  factory _$NationalIdDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NationalIdDetailsModelImplFromJson(json);

  @override
  @JsonKey(name: 'birthDate')
  final String? birthDate;
  @override
  @JsonKey(name: 'gender')
  final String? gender;
  @override
  @JsonKey(name: 'governorate')
  final String? governorate;
  @override
  @JsonKey(name: 'governorateCode')
  final String? governorateCode;
  @override
  @JsonKey(name: 'century')
  final String? century;

  @override
  String toString() {
    return 'NationalIdDetailsModel(birthDate: $birthDate, gender: $gender, governorate: $governorate, governorateCode: $governorateCode, century: $century)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NationalIdDetailsModelImpl &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.governorate, governorate) ||
                other.governorate == governorate) &&
            (identical(other.governorateCode, governorateCode) ||
                other.governorateCode == governorateCode) &&
            (identical(other.century, century) || other.century == century));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    birthDate,
    gender,
    governorate,
    governorateCode,
    century,
  );

  /// Create a copy of NationalIdDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NationalIdDetailsModelImplCopyWith<_$NationalIdDetailsModelImpl>
  get copyWith =>
      __$$NationalIdDetailsModelImplCopyWithImpl<_$NationalIdDetailsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NationalIdDetailsModelImplToJson(this);
  }
}

abstract class _NationalIdDetailsModel implements NationalIdDetailsModel {
  const factory _NationalIdDetailsModel({
    @JsonKey(name: 'birthDate') final String? birthDate,
    @JsonKey(name: 'gender') final String? gender,
    @JsonKey(name: 'governorate') final String? governorate,
    @JsonKey(name: 'governorateCode') final String? governorateCode,
    @JsonKey(name: 'century') final String? century,
  }) = _$NationalIdDetailsModelImpl;

  factory _NationalIdDetailsModel.fromJson(Map<String, dynamic> json) =
      _$NationalIdDetailsModelImpl.fromJson;

  @override
  @JsonKey(name: 'birthDate')
  String? get birthDate;
  @override
  @JsonKey(name: 'gender')
  String? get gender;
  @override
  @JsonKey(name: 'governorate')
  String? get governorate;
  @override
  @JsonKey(name: 'governorateCode')
  String? get governorateCode;
  @override
  @JsonKey(name: 'century')
  String? get century;

  /// Create a copy of NationalIdDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NationalIdDetailsModelImplCopyWith<_$NationalIdDetailsModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
