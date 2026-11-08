// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EmployeeRecordResponseModel _$EmployeeRecordResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _EmployeeRecordResponseModel.fromJson(json);
}

/// @nodoc
mixin _$EmployeeRecordResponseModel {
  EmployeeRecordModel? get value => throw _privateConstructorUsedError;

  /// Serializes this EmployeeRecordResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmployeeRecordResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeeRecordResponseModelCopyWith<EmployeeRecordResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeRecordResponseModelCopyWith<$Res> {
  factory $EmployeeRecordResponseModelCopyWith(
    EmployeeRecordResponseModel value,
    $Res Function(EmployeeRecordResponseModel) then,
  ) =
      _$EmployeeRecordResponseModelCopyWithImpl<
        $Res,
        EmployeeRecordResponseModel
      >;
  @useResult
  $Res call({EmployeeRecordModel? value});

  $EmployeeRecordModelCopyWith<$Res>? get value;
}

/// @nodoc
class _$EmployeeRecordResponseModelCopyWithImpl<
  $Res,
  $Val extends EmployeeRecordResponseModel
>
    implements $EmployeeRecordResponseModelCopyWith<$Res> {
  _$EmployeeRecordResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeeRecordResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = freezed}) {
    return _then(
      _value.copyWith(
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as EmployeeRecordModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of EmployeeRecordResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmployeeRecordModelCopyWith<$Res>? get value {
    if (_value.value == null) {
      return null;
    }

    return $EmployeeRecordModelCopyWith<$Res>(_value.value!, (value) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmployeeRecordResponseModelImplCopyWith<$Res>
    implements $EmployeeRecordResponseModelCopyWith<$Res> {
  factory _$$EmployeeRecordResponseModelImplCopyWith(
    _$EmployeeRecordResponseModelImpl value,
    $Res Function(_$EmployeeRecordResponseModelImpl) then,
  ) = __$$EmployeeRecordResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EmployeeRecordModel? value});

  @override
  $EmployeeRecordModelCopyWith<$Res>? get value;
}

/// @nodoc
class __$$EmployeeRecordResponseModelImplCopyWithImpl<$Res>
    extends
        _$EmployeeRecordResponseModelCopyWithImpl<
          $Res,
          _$EmployeeRecordResponseModelImpl
        >
    implements _$$EmployeeRecordResponseModelImplCopyWith<$Res> {
  __$$EmployeeRecordResponseModelImplCopyWithImpl(
    _$EmployeeRecordResponseModelImpl _value,
    $Res Function(_$EmployeeRecordResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeRecordResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = freezed}) {
    return _then(
      _$EmployeeRecordResponseModelImpl(
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as EmployeeRecordModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeRecordResponseModelImpl
    implements _EmployeeRecordResponseModel {
  const _$EmployeeRecordResponseModelImpl({this.value});

  factory _$EmployeeRecordResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$EmployeeRecordResponseModelImplFromJson(json);

  @override
  final EmployeeRecordModel? value;

  @override
  String toString() {
    return 'EmployeeRecordResponseModel(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeRecordResponseModelImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of EmployeeRecordResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeRecordResponseModelImplCopyWith<_$EmployeeRecordResponseModelImpl>
  get copyWith =>
      __$$EmployeeRecordResponseModelImplCopyWithImpl<
        _$EmployeeRecordResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeRecordResponseModelImplToJson(this);
  }
}

abstract class _EmployeeRecordResponseModel
    implements EmployeeRecordResponseModel {
  const factory _EmployeeRecordResponseModel({
    final EmployeeRecordModel? value,
  }) = _$EmployeeRecordResponseModelImpl;

  factory _EmployeeRecordResponseModel.fromJson(Map<String, dynamic> json) =
      _$EmployeeRecordResponseModelImpl.fromJson;

  @override
  EmployeeRecordModel? get value;

  /// Create a copy of EmployeeRecordResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeRecordResponseModelImplCopyWith<_$EmployeeRecordResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

EmployeeRecordModel _$EmployeeRecordModelFromJson(Map<String, dynamic> json) {
  return _EmployeeRecordModel.fromJson(json);
}

/// @nodoc
mixin _$EmployeeRecordModel {
  RecordEmployeeModel get employee => throw _privateConstructorUsedError;
  RecordTotalsModel get totals => throw _privateConstructorUsedError;
  List<RecordDayModel> get days => throw _privateConstructorUsedError;

  /// Serializes this EmployeeRecordModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmployeeRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeeRecordModelCopyWith<EmployeeRecordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeRecordModelCopyWith<$Res> {
  factory $EmployeeRecordModelCopyWith(
    EmployeeRecordModel value,
    $Res Function(EmployeeRecordModel) then,
  ) = _$EmployeeRecordModelCopyWithImpl<$Res, EmployeeRecordModel>;
  @useResult
  $Res call({
    RecordEmployeeModel employee,
    RecordTotalsModel totals,
    List<RecordDayModel> days,
  });

  $RecordEmployeeModelCopyWith<$Res> get employee;
  $RecordTotalsModelCopyWith<$Res> get totals;
}

/// @nodoc
class _$EmployeeRecordModelCopyWithImpl<$Res, $Val extends EmployeeRecordModel>
    implements $EmployeeRecordModelCopyWith<$Res> {
  _$EmployeeRecordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeeRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employee = null,
    Object? totals = null,
    Object? days = null,
  }) {
    return _then(
      _value.copyWith(
            employee: null == employee
                ? _value.employee
                : employee // ignore: cast_nullable_to_non_nullable
                      as RecordEmployeeModel,
            totals: null == totals
                ? _value.totals
                : totals // ignore: cast_nullable_to_non_nullable
                      as RecordTotalsModel,
            days: null == days
                ? _value.days
                : days // ignore: cast_nullable_to_non_nullable
                      as List<RecordDayModel>,
          )
          as $Val,
    );
  }

  /// Create a copy of EmployeeRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEmployeeModelCopyWith<$Res> get employee {
    return $RecordEmployeeModelCopyWith<$Res>(_value.employee, (value) {
      return _then(_value.copyWith(employee: value) as $Val);
    });
  }

  /// Create a copy of EmployeeRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordTotalsModelCopyWith<$Res> get totals {
    return $RecordTotalsModelCopyWith<$Res>(_value.totals, (value) {
      return _then(_value.copyWith(totals: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmployeeRecordModelImplCopyWith<$Res>
    implements $EmployeeRecordModelCopyWith<$Res> {
  factory _$$EmployeeRecordModelImplCopyWith(
    _$EmployeeRecordModelImpl value,
    $Res Function(_$EmployeeRecordModelImpl) then,
  ) = __$$EmployeeRecordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    RecordEmployeeModel employee,
    RecordTotalsModel totals,
    List<RecordDayModel> days,
  });

  @override
  $RecordEmployeeModelCopyWith<$Res> get employee;
  @override
  $RecordTotalsModelCopyWith<$Res> get totals;
}

/// @nodoc
class __$$EmployeeRecordModelImplCopyWithImpl<$Res>
    extends _$EmployeeRecordModelCopyWithImpl<$Res, _$EmployeeRecordModelImpl>
    implements _$$EmployeeRecordModelImplCopyWith<$Res> {
  __$$EmployeeRecordModelImplCopyWithImpl(
    _$EmployeeRecordModelImpl _value,
    $Res Function(_$EmployeeRecordModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employee = null,
    Object? totals = null,
    Object? days = null,
  }) {
    return _then(
      _$EmployeeRecordModelImpl(
        employee: null == employee
            ? _value.employee
            : employee // ignore: cast_nullable_to_non_nullable
                  as RecordEmployeeModel,
        totals: null == totals
            ? _value.totals
            : totals // ignore: cast_nullable_to_non_nullable
                  as RecordTotalsModel,
        days: null == days
            ? _value._days
            : days // ignore: cast_nullable_to_non_nullable
                  as List<RecordDayModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeRecordModelImpl implements _EmployeeRecordModel {
  const _$EmployeeRecordModelImpl({
    required this.employee,
    this.totals = const RecordTotalsModel(),
    final List<RecordDayModel> days = const <RecordDayModel>[],
  }) : _days = days;

  factory _$EmployeeRecordModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeRecordModelImplFromJson(json);

  @override
  final RecordEmployeeModel employee;
  @override
  @JsonKey()
  final RecordTotalsModel totals;
  final List<RecordDayModel> _days;
  @override
  @JsonKey()
  List<RecordDayModel> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  String toString() {
    return 'EmployeeRecordModel(employee: $employee, totals: $totals, days: $days)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeRecordModelImpl &&
            (identical(other.employee, employee) ||
                other.employee == employee) &&
            (identical(other.totals, totals) || other.totals == totals) &&
            const DeepCollectionEquality().equals(other._days, _days));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    employee,
    totals,
    const DeepCollectionEquality().hash(_days),
  );

  /// Create a copy of EmployeeRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeRecordModelImplCopyWith<_$EmployeeRecordModelImpl> get copyWith =>
      __$$EmployeeRecordModelImplCopyWithImpl<_$EmployeeRecordModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeRecordModelImplToJson(this);
  }
}

abstract class _EmployeeRecordModel implements EmployeeRecordModel {
  const factory _EmployeeRecordModel({
    required final RecordEmployeeModel employee,
    final RecordTotalsModel totals,
    final List<RecordDayModel> days,
  }) = _$EmployeeRecordModelImpl;

  factory _EmployeeRecordModel.fromJson(Map<String, dynamic> json) =
      _$EmployeeRecordModelImpl.fromJson;

  @override
  RecordEmployeeModel get employee;
  @override
  RecordTotalsModel get totals;
  @override
  List<RecordDayModel> get days;

  /// Create a copy of EmployeeRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeRecordModelImplCopyWith<_$EmployeeRecordModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecordEmployeeModel _$RecordEmployeeModelFromJson(Map<String, dynamic> json) {
  return _RecordEmployeeModel.fromJson(json);
}

/// @nodoc
mixin _$RecordEmployeeModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get employeeCode => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this RecordEmployeeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecordEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordEmployeeModelCopyWith<RecordEmployeeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordEmployeeModelCopyWith<$Res> {
  factory $RecordEmployeeModelCopyWith(
    RecordEmployeeModel value,
    $Res Function(RecordEmployeeModel) then,
  ) = _$RecordEmployeeModelCopyWithImpl<$Res, RecordEmployeeModel>;
  @useResult
  $Res call({String id, String name, String? employeeCode, String? imageUrl});
}

/// @nodoc
class _$RecordEmployeeModelCopyWithImpl<$Res, $Val extends RecordEmployeeModel>
    implements $RecordEmployeeModelCopyWith<$Res> {
  _$RecordEmployeeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? employeeCode = freezed,
    Object? imageUrl = freezed,
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
            employeeCode: freezed == employeeCode
                ? _value.employeeCode
                : employeeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecordEmployeeModelImplCopyWith<$Res>
    implements $RecordEmployeeModelCopyWith<$Res> {
  factory _$$RecordEmployeeModelImplCopyWith(
    _$RecordEmployeeModelImpl value,
    $Res Function(_$RecordEmployeeModelImpl) then,
  ) = __$$RecordEmployeeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? employeeCode, String? imageUrl});
}

/// @nodoc
class __$$RecordEmployeeModelImplCopyWithImpl<$Res>
    extends _$RecordEmployeeModelCopyWithImpl<$Res, _$RecordEmployeeModelImpl>
    implements _$$RecordEmployeeModelImplCopyWith<$Res> {
  __$$RecordEmployeeModelImplCopyWithImpl(
    _$RecordEmployeeModelImpl _value,
    $Res Function(_$RecordEmployeeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecordEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? employeeCode = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$RecordEmployeeModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        employeeCode: freezed == employeeCode
            ? _value.employeeCode
            : employeeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordEmployeeModelImpl implements _RecordEmployeeModel {
  const _$RecordEmployeeModelImpl({
    required this.id,
    this.name = '',
    this.employeeCode,
    this.imageUrl,
  });

  factory _$RecordEmployeeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordEmployeeModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final String? employeeCode;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'RecordEmployeeModel(id: $id, name: $name, employeeCode: $employeeCode, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordEmployeeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, employeeCode, imageUrl);

  /// Create a copy of RecordEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordEmployeeModelImplCopyWith<_$RecordEmployeeModelImpl> get copyWith =>
      __$$RecordEmployeeModelImplCopyWithImpl<_$RecordEmployeeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordEmployeeModelImplToJson(this);
  }
}

abstract class _RecordEmployeeModel implements RecordEmployeeModel {
  const factory _RecordEmployeeModel({
    required final String id,
    final String name,
    final String? employeeCode,
    final String? imageUrl,
  }) = _$RecordEmployeeModelImpl;

  factory _RecordEmployeeModel.fromJson(Map<String, dynamic> json) =
      _$RecordEmployeeModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get employeeCode;
  @override
  String? get imageUrl;

  /// Create a copy of RecordEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordEmployeeModelImplCopyWith<_$RecordEmployeeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecordTotalsModel _$RecordTotalsModelFromJson(Map<String, dynamic> json) {
  return _RecordTotalsModel.fromJson(json);
}

/// @nodoc
mixin _$RecordTotalsModel {
  int get workingDays => throw _privateConstructorUsedError;
  int get presentDays => throw _privateConstructorUsedError;
  int get lateDays => throw _privateConstructorUsedError;
  int get coveredDays => throw _privateConstructorUsedError;
  int get earlyLeaveDays => throw _privateConstructorUsedError;
  int get absentDays => throw _privateConstructorUsedError;
  int get leaveDays => throw _privateConstructorUsedError;
  int get holidayDays => throw _privateConstructorUsedError;
  int get weeklyOffDays => throw _privateConstructorUsedError;
  int get permits => throw _privateConstructorUsedError;

  /// Serializes this RecordTotalsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecordTotalsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordTotalsModelCopyWith<RecordTotalsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordTotalsModelCopyWith<$Res> {
  factory $RecordTotalsModelCopyWith(
    RecordTotalsModel value,
    $Res Function(RecordTotalsModel) then,
  ) = _$RecordTotalsModelCopyWithImpl<$Res, RecordTotalsModel>;
  @useResult
  $Res call({
    int workingDays,
    int presentDays,
    int lateDays,
    int coveredDays,
    int earlyLeaveDays,
    int absentDays,
    int leaveDays,
    int holidayDays,
    int weeklyOffDays,
    int permits,
  });
}

/// @nodoc
class _$RecordTotalsModelCopyWithImpl<$Res, $Val extends RecordTotalsModel>
    implements $RecordTotalsModelCopyWith<$Res> {
  _$RecordTotalsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordTotalsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workingDays = null,
    Object? presentDays = null,
    Object? lateDays = null,
    Object? coveredDays = null,
    Object? earlyLeaveDays = null,
    Object? absentDays = null,
    Object? leaveDays = null,
    Object? holidayDays = null,
    Object? weeklyOffDays = null,
    Object? permits = null,
  }) {
    return _then(
      _value.copyWith(
            workingDays: null == workingDays
                ? _value.workingDays
                : workingDays // ignore: cast_nullable_to_non_nullable
                      as int,
            presentDays: null == presentDays
                ? _value.presentDays
                : presentDays // ignore: cast_nullable_to_non_nullable
                      as int,
            lateDays: null == lateDays
                ? _value.lateDays
                : lateDays // ignore: cast_nullable_to_non_nullable
                      as int,
            coveredDays: null == coveredDays
                ? _value.coveredDays
                : coveredDays // ignore: cast_nullable_to_non_nullable
                      as int,
            earlyLeaveDays: null == earlyLeaveDays
                ? _value.earlyLeaveDays
                : earlyLeaveDays // ignore: cast_nullable_to_non_nullable
                      as int,
            absentDays: null == absentDays
                ? _value.absentDays
                : absentDays // ignore: cast_nullable_to_non_nullable
                      as int,
            leaveDays: null == leaveDays
                ? _value.leaveDays
                : leaveDays // ignore: cast_nullable_to_non_nullable
                      as int,
            holidayDays: null == holidayDays
                ? _value.holidayDays
                : holidayDays // ignore: cast_nullable_to_non_nullable
                      as int,
            weeklyOffDays: null == weeklyOffDays
                ? _value.weeklyOffDays
                : weeklyOffDays // ignore: cast_nullable_to_non_nullable
                      as int,
            permits: null == permits
                ? _value.permits
                : permits // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecordTotalsModelImplCopyWith<$Res>
    implements $RecordTotalsModelCopyWith<$Res> {
  factory _$$RecordTotalsModelImplCopyWith(
    _$RecordTotalsModelImpl value,
    $Res Function(_$RecordTotalsModelImpl) then,
  ) = __$$RecordTotalsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int workingDays,
    int presentDays,
    int lateDays,
    int coveredDays,
    int earlyLeaveDays,
    int absentDays,
    int leaveDays,
    int holidayDays,
    int weeklyOffDays,
    int permits,
  });
}

/// @nodoc
class __$$RecordTotalsModelImplCopyWithImpl<$Res>
    extends _$RecordTotalsModelCopyWithImpl<$Res, _$RecordTotalsModelImpl>
    implements _$$RecordTotalsModelImplCopyWith<$Res> {
  __$$RecordTotalsModelImplCopyWithImpl(
    _$RecordTotalsModelImpl _value,
    $Res Function(_$RecordTotalsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecordTotalsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workingDays = null,
    Object? presentDays = null,
    Object? lateDays = null,
    Object? coveredDays = null,
    Object? earlyLeaveDays = null,
    Object? absentDays = null,
    Object? leaveDays = null,
    Object? holidayDays = null,
    Object? weeklyOffDays = null,
    Object? permits = null,
  }) {
    return _then(
      _$RecordTotalsModelImpl(
        workingDays: null == workingDays
            ? _value.workingDays
            : workingDays // ignore: cast_nullable_to_non_nullable
                  as int,
        presentDays: null == presentDays
            ? _value.presentDays
            : presentDays // ignore: cast_nullable_to_non_nullable
                  as int,
        lateDays: null == lateDays
            ? _value.lateDays
            : lateDays // ignore: cast_nullable_to_non_nullable
                  as int,
        coveredDays: null == coveredDays
            ? _value.coveredDays
            : coveredDays // ignore: cast_nullable_to_non_nullable
                  as int,
        earlyLeaveDays: null == earlyLeaveDays
            ? _value.earlyLeaveDays
            : earlyLeaveDays // ignore: cast_nullable_to_non_nullable
                  as int,
        absentDays: null == absentDays
            ? _value.absentDays
            : absentDays // ignore: cast_nullable_to_non_nullable
                  as int,
        leaveDays: null == leaveDays
            ? _value.leaveDays
            : leaveDays // ignore: cast_nullable_to_non_nullable
                  as int,
        holidayDays: null == holidayDays
            ? _value.holidayDays
            : holidayDays // ignore: cast_nullable_to_non_nullable
                  as int,
        weeklyOffDays: null == weeklyOffDays
            ? _value.weeklyOffDays
            : weeklyOffDays // ignore: cast_nullable_to_non_nullable
                  as int,
        permits: null == permits
            ? _value.permits
            : permits // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordTotalsModelImpl implements _RecordTotalsModel {
  const _$RecordTotalsModelImpl({
    this.workingDays = 0,
    this.presentDays = 0,
    this.lateDays = 0,
    this.coveredDays = 0,
    this.earlyLeaveDays = 0,
    this.absentDays = 0,
    this.leaveDays = 0,
    this.holidayDays = 0,
    this.weeklyOffDays = 0,
    this.permits = 0,
  });

  factory _$RecordTotalsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordTotalsModelImplFromJson(json);

  @override
  @JsonKey()
  final int workingDays;
  @override
  @JsonKey()
  final int presentDays;
  @override
  @JsonKey()
  final int lateDays;
  @override
  @JsonKey()
  final int coveredDays;
  @override
  @JsonKey()
  final int earlyLeaveDays;
  @override
  @JsonKey()
  final int absentDays;
  @override
  @JsonKey()
  final int leaveDays;
  @override
  @JsonKey()
  final int holidayDays;
  @override
  @JsonKey()
  final int weeklyOffDays;
  @override
  @JsonKey()
  final int permits;

  @override
  String toString() {
    return 'RecordTotalsModel(workingDays: $workingDays, presentDays: $presentDays, lateDays: $lateDays, coveredDays: $coveredDays, earlyLeaveDays: $earlyLeaveDays, absentDays: $absentDays, leaveDays: $leaveDays, holidayDays: $holidayDays, weeklyOffDays: $weeklyOffDays, permits: $permits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordTotalsModelImpl &&
            (identical(other.workingDays, workingDays) ||
                other.workingDays == workingDays) &&
            (identical(other.presentDays, presentDays) ||
                other.presentDays == presentDays) &&
            (identical(other.lateDays, lateDays) ||
                other.lateDays == lateDays) &&
            (identical(other.coveredDays, coveredDays) ||
                other.coveredDays == coveredDays) &&
            (identical(other.earlyLeaveDays, earlyLeaveDays) ||
                other.earlyLeaveDays == earlyLeaveDays) &&
            (identical(other.absentDays, absentDays) ||
                other.absentDays == absentDays) &&
            (identical(other.leaveDays, leaveDays) ||
                other.leaveDays == leaveDays) &&
            (identical(other.holidayDays, holidayDays) ||
                other.holidayDays == holidayDays) &&
            (identical(other.weeklyOffDays, weeklyOffDays) ||
                other.weeklyOffDays == weeklyOffDays) &&
            (identical(other.permits, permits) || other.permits == permits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    workingDays,
    presentDays,
    lateDays,
    coveredDays,
    earlyLeaveDays,
    absentDays,
    leaveDays,
    holidayDays,
    weeklyOffDays,
    permits,
  );

  /// Create a copy of RecordTotalsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordTotalsModelImplCopyWith<_$RecordTotalsModelImpl> get copyWith =>
      __$$RecordTotalsModelImplCopyWithImpl<_$RecordTotalsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordTotalsModelImplToJson(this);
  }
}

abstract class _RecordTotalsModel implements RecordTotalsModel {
  const factory _RecordTotalsModel({
    final int workingDays,
    final int presentDays,
    final int lateDays,
    final int coveredDays,
    final int earlyLeaveDays,
    final int absentDays,
    final int leaveDays,
    final int holidayDays,
    final int weeklyOffDays,
    final int permits,
  }) = _$RecordTotalsModelImpl;

  factory _RecordTotalsModel.fromJson(Map<String, dynamic> json) =
      _$RecordTotalsModelImpl.fromJson;

  @override
  int get workingDays;
  @override
  int get presentDays;
  @override
  int get lateDays;
  @override
  int get coveredDays;
  @override
  int get earlyLeaveDays;
  @override
  int get absentDays;
  @override
  int get leaveDays;
  @override
  int get holidayDays;
  @override
  int get weeklyOffDays;
  @override
  int get permits;

  /// Create a copy of RecordTotalsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordTotalsModelImplCopyWith<_$RecordTotalsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecordDayModel _$RecordDayModelFromJson(Map<String, dynamic> json) {
  return _RecordDayModel.fromJson(json);
}

/// @nodoc
mixin _$RecordDayModel {
  /// `YYYY-MM-DD`, parsed once in the data layer (§28).
  @RecordDayDateConverter()
  DateTime get date => throw _privateConstructorUsedError;

  /// working | weeklyOff | holiday | leave
  String get dayType => throw _privateConstructorUsedError;

  /// present | late | lateCovered | earlyLeave | earlyCovered |
  /// lateAndEarly | absent | upcoming | none
  String get status => throw _privateConstructorUsedError;
  DateTime? get clockIn => throw _privateConstructorUsedError;
  DateTime? get clockOut => throw _privateConstructorUsedError;
  int? get workedMinutes => throw _privateConstructorUsedError;
  int get lateMinutes => throw _privateConstructorUsedError;
  int get earlyLeaveMinutes => throw _privateConstructorUsedError;
  String? get holidayName => throw _privateConstructorUsedError;
  RecordLeaveModel? get leave => throw _privateConstructorUsedError;
  List<RecordPermitModel> get permits => throw _privateConstructorUsedError;

  /// Serializes this RecordDayModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecordDayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordDayModelCopyWith<RecordDayModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordDayModelCopyWith<$Res> {
  factory $RecordDayModelCopyWith(
    RecordDayModel value,
    $Res Function(RecordDayModel) then,
  ) = _$RecordDayModelCopyWithImpl<$Res, RecordDayModel>;
  @useResult
  $Res call({
    @RecordDayDateConverter() DateTime date,
    String dayType,
    String status,
    DateTime? clockIn,
    DateTime? clockOut,
    int? workedMinutes,
    int lateMinutes,
    int earlyLeaveMinutes,
    String? holidayName,
    RecordLeaveModel? leave,
    List<RecordPermitModel> permits,
  });

  $RecordLeaveModelCopyWith<$Res>? get leave;
}

/// @nodoc
class _$RecordDayModelCopyWithImpl<$Res, $Val extends RecordDayModel>
    implements $RecordDayModelCopyWith<$Res> {
  _$RecordDayModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordDayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? dayType = null,
    Object? status = null,
    Object? clockIn = freezed,
    Object? clockOut = freezed,
    Object? workedMinutes = freezed,
    Object? lateMinutes = null,
    Object? earlyLeaveMinutes = null,
    Object? holidayName = freezed,
    Object? leave = freezed,
    Object? permits = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            dayType: null == dayType
                ? _value.dayType
                : dayType // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            clockIn: freezed == clockIn
                ? _value.clockIn
                : clockIn // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            clockOut: freezed == clockOut
                ? _value.clockOut
                : clockOut // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            workedMinutes: freezed == workedMinutes
                ? _value.workedMinutes
                : workedMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            lateMinutes: null == lateMinutes
                ? _value.lateMinutes
                : lateMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            earlyLeaveMinutes: null == earlyLeaveMinutes
                ? _value.earlyLeaveMinutes
                : earlyLeaveMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            holidayName: freezed == holidayName
                ? _value.holidayName
                : holidayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            leave: freezed == leave
                ? _value.leave
                : leave // ignore: cast_nullable_to_non_nullable
                      as RecordLeaveModel?,
            permits: null == permits
                ? _value.permits
                : permits // ignore: cast_nullable_to_non_nullable
                      as List<RecordPermitModel>,
          )
          as $Val,
    );
  }

  /// Create a copy of RecordDayModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordLeaveModelCopyWith<$Res>? get leave {
    if (_value.leave == null) {
      return null;
    }

    return $RecordLeaveModelCopyWith<$Res>(_value.leave!, (value) {
      return _then(_value.copyWith(leave: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecordDayModelImplCopyWith<$Res>
    implements $RecordDayModelCopyWith<$Res> {
  factory _$$RecordDayModelImplCopyWith(
    _$RecordDayModelImpl value,
    $Res Function(_$RecordDayModelImpl) then,
  ) = __$$RecordDayModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @RecordDayDateConverter() DateTime date,
    String dayType,
    String status,
    DateTime? clockIn,
    DateTime? clockOut,
    int? workedMinutes,
    int lateMinutes,
    int earlyLeaveMinutes,
    String? holidayName,
    RecordLeaveModel? leave,
    List<RecordPermitModel> permits,
  });

  @override
  $RecordLeaveModelCopyWith<$Res>? get leave;
}

/// @nodoc
class __$$RecordDayModelImplCopyWithImpl<$Res>
    extends _$RecordDayModelCopyWithImpl<$Res, _$RecordDayModelImpl>
    implements _$$RecordDayModelImplCopyWith<$Res> {
  __$$RecordDayModelImplCopyWithImpl(
    _$RecordDayModelImpl _value,
    $Res Function(_$RecordDayModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecordDayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? dayType = null,
    Object? status = null,
    Object? clockIn = freezed,
    Object? clockOut = freezed,
    Object? workedMinutes = freezed,
    Object? lateMinutes = null,
    Object? earlyLeaveMinutes = null,
    Object? holidayName = freezed,
    Object? leave = freezed,
    Object? permits = null,
  }) {
    return _then(
      _$RecordDayModelImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        dayType: null == dayType
            ? _value.dayType
            : dayType // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        clockIn: freezed == clockIn
            ? _value.clockIn
            : clockIn // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        clockOut: freezed == clockOut
            ? _value.clockOut
            : clockOut // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        workedMinutes: freezed == workedMinutes
            ? _value.workedMinutes
            : workedMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        lateMinutes: null == lateMinutes
            ? _value.lateMinutes
            : lateMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        earlyLeaveMinutes: null == earlyLeaveMinutes
            ? _value.earlyLeaveMinutes
            : earlyLeaveMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        holidayName: freezed == holidayName
            ? _value.holidayName
            : holidayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        leave: freezed == leave
            ? _value.leave
            : leave // ignore: cast_nullable_to_non_nullable
                  as RecordLeaveModel?,
        permits: null == permits
            ? _value._permits
            : permits // ignore: cast_nullable_to_non_nullable
                  as List<RecordPermitModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordDayModelImpl extends _RecordDayModel {
  const _$RecordDayModelImpl({
    @RecordDayDateConverter() required this.date,
    this.dayType = 'working',
    this.status = 'none',
    this.clockIn,
    this.clockOut,
    this.workedMinutes,
    this.lateMinutes = 0,
    this.earlyLeaveMinutes = 0,
    this.holidayName,
    this.leave,
    final List<RecordPermitModel> permits = const <RecordPermitModel>[],
  }) : _permits = permits,
       super._();

  factory _$RecordDayModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordDayModelImplFromJson(json);

  /// `YYYY-MM-DD`, parsed once in the data layer (§28).
  @override
  @RecordDayDateConverter()
  final DateTime date;

  /// working | weeklyOff | holiday | leave
  @override
  @JsonKey()
  final String dayType;

  /// present | late | lateCovered | earlyLeave | earlyCovered |
  /// lateAndEarly | absent | upcoming | none
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? clockIn;
  @override
  final DateTime? clockOut;
  @override
  final int? workedMinutes;
  @override
  @JsonKey()
  final int lateMinutes;
  @override
  @JsonKey()
  final int earlyLeaveMinutes;
  @override
  final String? holidayName;
  @override
  final RecordLeaveModel? leave;
  final List<RecordPermitModel> _permits;
  @override
  @JsonKey()
  List<RecordPermitModel> get permits {
    if (_permits is EqualUnmodifiableListView) return _permits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permits);
  }

  @override
  String toString() {
    return 'RecordDayModel(date: $date, dayType: $dayType, status: $status, clockIn: $clockIn, clockOut: $clockOut, workedMinutes: $workedMinutes, lateMinutes: $lateMinutes, earlyLeaveMinutes: $earlyLeaveMinutes, holidayName: $holidayName, leave: $leave, permits: $permits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordDayModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.dayType, dayType) || other.dayType == dayType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.clockIn, clockIn) || other.clockIn == clockIn) &&
            (identical(other.clockOut, clockOut) ||
                other.clockOut == clockOut) &&
            (identical(other.workedMinutes, workedMinutes) ||
                other.workedMinutes == workedMinutes) &&
            (identical(other.lateMinutes, lateMinutes) ||
                other.lateMinutes == lateMinutes) &&
            (identical(other.earlyLeaveMinutes, earlyLeaveMinutes) ||
                other.earlyLeaveMinutes == earlyLeaveMinutes) &&
            (identical(other.holidayName, holidayName) ||
                other.holidayName == holidayName) &&
            (identical(other.leave, leave) || other.leave == leave) &&
            const DeepCollectionEquality().equals(other._permits, _permits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    dayType,
    status,
    clockIn,
    clockOut,
    workedMinutes,
    lateMinutes,
    earlyLeaveMinutes,
    holidayName,
    leave,
    const DeepCollectionEquality().hash(_permits),
  );

  /// Create a copy of RecordDayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordDayModelImplCopyWith<_$RecordDayModelImpl> get copyWith =>
      __$$RecordDayModelImplCopyWithImpl<_$RecordDayModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordDayModelImplToJson(this);
  }
}

abstract class _RecordDayModel extends RecordDayModel {
  const factory _RecordDayModel({
    @RecordDayDateConverter() required final DateTime date,
    final String dayType,
    final String status,
    final DateTime? clockIn,
    final DateTime? clockOut,
    final int? workedMinutes,
    final int lateMinutes,
    final int earlyLeaveMinutes,
    final String? holidayName,
    final RecordLeaveModel? leave,
    final List<RecordPermitModel> permits,
  }) = _$RecordDayModelImpl;
  const _RecordDayModel._() : super._();

  factory _RecordDayModel.fromJson(Map<String, dynamic> json) =
      _$RecordDayModelImpl.fromJson;

  /// `YYYY-MM-DD`, parsed once in the data layer (§28).
  @override
  @RecordDayDateConverter()
  DateTime get date;

  /// working | weeklyOff | holiday | leave
  @override
  String get dayType;

  /// present | late | lateCovered | earlyLeave | earlyCovered |
  /// lateAndEarly | absent | upcoming | none
  @override
  String get status;
  @override
  DateTime? get clockIn;
  @override
  DateTime? get clockOut;
  @override
  int? get workedMinutes;
  @override
  int get lateMinutes;
  @override
  int get earlyLeaveMinutes;
  @override
  String? get holidayName;
  @override
  RecordLeaveModel? get leave;
  @override
  List<RecordPermitModel> get permits;

  /// Create a copy of RecordDayModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordDayModelImplCopyWith<_$RecordDayModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecordLeaveModel _$RecordLeaveModelFromJson(Map<String, dynamic> json) {
  return _RecordLeaveModel.fromJson(json);
}

/// @nodoc
mixin _$RecordLeaveModel {
  String get id => throw _privateConstructorUsedError;
  String get typeName => throw _privateConstructorUsedError;

  /// Serializes this RecordLeaveModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecordLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordLeaveModelCopyWith<RecordLeaveModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordLeaveModelCopyWith<$Res> {
  factory $RecordLeaveModelCopyWith(
    RecordLeaveModel value,
    $Res Function(RecordLeaveModel) then,
  ) = _$RecordLeaveModelCopyWithImpl<$Res, RecordLeaveModel>;
  @useResult
  $Res call({String id, String typeName});
}

/// @nodoc
class _$RecordLeaveModelCopyWithImpl<$Res, $Val extends RecordLeaveModel>
    implements $RecordLeaveModelCopyWith<$Res> {
  _$RecordLeaveModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? typeName = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecordLeaveModelImplCopyWith<$Res>
    implements $RecordLeaveModelCopyWith<$Res> {
  factory _$$RecordLeaveModelImplCopyWith(
    _$RecordLeaveModelImpl value,
    $Res Function(_$RecordLeaveModelImpl) then,
  ) = __$$RecordLeaveModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String typeName});
}

/// @nodoc
class __$$RecordLeaveModelImplCopyWithImpl<$Res>
    extends _$RecordLeaveModelCopyWithImpl<$Res, _$RecordLeaveModelImpl>
    implements _$$RecordLeaveModelImplCopyWith<$Res> {
  __$$RecordLeaveModelImplCopyWithImpl(
    _$RecordLeaveModelImpl _value,
    $Res Function(_$RecordLeaveModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecordLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? typeName = null}) {
    return _then(
      _$RecordLeaveModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        typeName: null == typeName
            ? _value.typeName
            : typeName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordLeaveModelImpl implements _RecordLeaveModel {
  const _$RecordLeaveModelImpl({required this.id, this.typeName = ''});

  factory _$RecordLeaveModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordLeaveModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String typeName;

  @override
  String toString() {
    return 'RecordLeaveModel(id: $id, typeName: $typeName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordLeaveModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, typeName);

  /// Create a copy of RecordLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordLeaveModelImplCopyWith<_$RecordLeaveModelImpl> get copyWith =>
      __$$RecordLeaveModelImplCopyWithImpl<_$RecordLeaveModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordLeaveModelImplToJson(this);
  }
}

abstract class _RecordLeaveModel implements RecordLeaveModel {
  const factory _RecordLeaveModel({
    required final String id,
    final String typeName,
  }) = _$RecordLeaveModelImpl;

  factory _RecordLeaveModel.fromJson(Map<String, dynamic> json) =
      _$RecordLeaveModelImpl.fromJson;

  @override
  String get id;
  @override
  String get typeName;

  /// Create a copy of RecordLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordLeaveModelImplCopyWith<_$RecordLeaveModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecordPermitModel _$RecordPermitModelFromJson(Map<String, dynamic> json) {
  return _RecordPermitModel.fromJson(json);
}

/// @nodoc
mixin _$RecordPermitModel {
  String get id => throw _privateConstructorUsedError;

  /// LateArrival | EarlyDeparture | Temporary
  String get permitType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int? get durationMinutes => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;

  /// Serializes this RecordPermitModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecordPermitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordPermitModelCopyWith<RecordPermitModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordPermitModelCopyWith<$Res> {
  factory $RecordPermitModelCopyWith(
    RecordPermitModel value,
    $Res Function(RecordPermitModel) then,
  ) = _$RecordPermitModelCopyWithImpl<$Res, RecordPermitModel>;
  @useResult
  $Res call({
    String id,
    String permitType,
    String status,
    int? durationMinutes,
    String startTime,
    String endTime,
  });
}

/// @nodoc
class _$RecordPermitModelCopyWithImpl<$Res, $Val extends RecordPermitModel>
    implements $RecordPermitModelCopyWith<$Res> {
  _$RecordPermitModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordPermitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? permitType = null,
    Object? status = null,
    Object? durationMinutes = freezed,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            permitType: null == permitType
                ? _value.permitType
                : permitType // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecordPermitModelImplCopyWith<$Res>
    implements $RecordPermitModelCopyWith<$Res> {
  factory _$$RecordPermitModelImplCopyWith(
    _$RecordPermitModelImpl value,
    $Res Function(_$RecordPermitModelImpl) then,
  ) = __$$RecordPermitModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String permitType,
    String status,
    int? durationMinutes,
    String startTime,
    String endTime,
  });
}

/// @nodoc
class __$$RecordPermitModelImplCopyWithImpl<$Res>
    extends _$RecordPermitModelCopyWithImpl<$Res, _$RecordPermitModelImpl>
    implements _$$RecordPermitModelImplCopyWith<$Res> {
  __$$RecordPermitModelImplCopyWithImpl(
    _$RecordPermitModelImpl _value,
    $Res Function(_$RecordPermitModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecordPermitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? permitType = null,
    Object? status = null,
    Object? durationMinutes = freezed,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(
      _$RecordPermitModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        permitType: null == permitType
            ? _value.permitType
            : permitType // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordPermitModelImpl implements _RecordPermitModel {
  const _$RecordPermitModelImpl({
    required this.id,
    this.permitType = '',
    this.status = '',
    this.durationMinutes,
    this.startTime = '',
    this.endTime = '',
  });

  factory _$RecordPermitModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordPermitModelImplFromJson(json);

  @override
  final String id;

  /// LateArrival | EarlyDeparture | Temporary
  @override
  @JsonKey()
  final String permitType;
  @override
  @JsonKey()
  final String status;
  @override
  final int? durationMinutes;
  @override
  @JsonKey()
  final String startTime;
  @override
  @JsonKey()
  final String endTime;

  @override
  String toString() {
    return 'RecordPermitModel(id: $id, permitType: $permitType, status: $status, durationMinutes: $durationMinutes, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordPermitModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.permitType, permitType) ||
                other.permitType == permitType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    permitType,
    status,
    durationMinutes,
    startTime,
    endTime,
  );

  /// Create a copy of RecordPermitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordPermitModelImplCopyWith<_$RecordPermitModelImpl> get copyWith =>
      __$$RecordPermitModelImplCopyWithImpl<_$RecordPermitModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordPermitModelImplToJson(this);
  }
}

abstract class _RecordPermitModel implements RecordPermitModel {
  const factory _RecordPermitModel({
    required final String id,
    final String permitType,
    final String status,
    final int? durationMinutes,
    final String startTime,
    final String endTime,
  }) = _$RecordPermitModelImpl;

  factory _RecordPermitModel.fromJson(Map<String, dynamic> json) =
      _$RecordPermitModelImpl.fromJson;

  @override
  String get id;

  /// LateArrival | EarlyDeparture | Temporary
  @override
  String get permitType;
  @override
  String get status;
  @override
  int? get durationMinutes;
  @override
  String get startTime;
  @override
  String get endTime;

  /// Create a copy of RecordPermitModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordPermitModelImplCopyWith<_$RecordPermitModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
