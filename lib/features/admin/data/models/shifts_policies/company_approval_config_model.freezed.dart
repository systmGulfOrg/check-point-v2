// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_approval_config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CompanyApprovalConfigModel _$CompanyApprovalConfigModelFromJson(
  Map<String, dynamic> json,
) {
  return _CompanyApprovalConfigModel.fromJson(json);
}

/// @nodoc
mixin _$CompanyApprovalConfigModel {
  String get leaveWorkflow => throw _privateConstructorUsedError;
  int get holdingGracePeriodMinutes => throw _privateConstructorUsedError;
  bool get adminsObserverOnly => throw _privateConstructorUsedError;
  bool get adminCanOverrideHolding => throw _privateConstructorUsedError;
  bool get enforceLateArrivalNoticeDeadline =>
      throw _privateConstructorUsedError;
  int get lateArrivalNoticeMinutes => throw _privateConstructorUsedError;
  bool get enforceGracePeriodForLateArrival =>
      throw _privateConstructorUsedError;
  bool get enforceEarlyDepartureDeadline => throw _privateConstructorUsedError;
  int get earlyDepartureDeadlinePercent => throw _privateConstructorUsedError;
  bool get allowPermitsOnWeekends => throw _privateConstructorUsedError;
  bool get allowPermitsOnHolidays => throw _privateConstructorUsedError;
  bool get forceSameDayCasualLeave => throw _privateConstructorUsedError;

  /// Serializes this CompanyApprovalConfigModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompanyApprovalConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompanyApprovalConfigModelCopyWith<CompanyApprovalConfigModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyApprovalConfigModelCopyWith<$Res> {
  factory $CompanyApprovalConfigModelCopyWith(
    CompanyApprovalConfigModel value,
    $Res Function(CompanyApprovalConfigModel) then,
  ) =
      _$CompanyApprovalConfigModelCopyWithImpl<
        $Res,
        CompanyApprovalConfigModel
      >;
  @useResult
  $Res call({
    String leaveWorkflow,
    int holdingGracePeriodMinutes,
    bool adminsObserverOnly,
    bool adminCanOverrideHolding,
    bool enforceLateArrivalNoticeDeadline,
    int lateArrivalNoticeMinutes,
    bool enforceGracePeriodForLateArrival,
    bool enforceEarlyDepartureDeadline,
    int earlyDepartureDeadlinePercent,
    bool allowPermitsOnWeekends,
    bool allowPermitsOnHolidays,
    bool forceSameDayCasualLeave,
  });
}

/// @nodoc
class _$CompanyApprovalConfigModelCopyWithImpl<
  $Res,
  $Val extends CompanyApprovalConfigModel
>
    implements $CompanyApprovalConfigModelCopyWith<$Res> {
  _$CompanyApprovalConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompanyApprovalConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaveWorkflow = null,
    Object? holdingGracePeriodMinutes = null,
    Object? adminsObserverOnly = null,
    Object? adminCanOverrideHolding = null,
    Object? enforceLateArrivalNoticeDeadline = null,
    Object? lateArrivalNoticeMinutes = null,
    Object? enforceGracePeriodForLateArrival = null,
    Object? enforceEarlyDepartureDeadline = null,
    Object? earlyDepartureDeadlinePercent = null,
    Object? allowPermitsOnWeekends = null,
    Object? allowPermitsOnHolidays = null,
    Object? forceSameDayCasualLeave = null,
  }) {
    return _then(
      _value.copyWith(
            leaveWorkflow: null == leaveWorkflow
                ? _value.leaveWorkflow
                : leaveWorkflow // ignore: cast_nullable_to_non_nullable
                      as String,
            holdingGracePeriodMinutes: null == holdingGracePeriodMinutes
                ? _value.holdingGracePeriodMinutes
                : holdingGracePeriodMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            adminsObserverOnly: null == adminsObserverOnly
                ? _value.adminsObserverOnly
                : adminsObserverOnly // ignore: cast_nullable_to_non_nullable
                      as bool,
            adminCanOverrideHolding: null == adminCanOverrideHolding
                ? _value.adminCanOverrideHolding
                : adminCanOverrideHolding // ignore: cast_nullable_to_non_nullable
                      as bool,
            enforceLateArrivalNoticeDeadline:
                null == enforceLateArrivalNoticeDeadline
                ? _value.enforceLateArrivalNoticeDeadline
                : enforceLateArrivalNoticeDeadline // ignore: cast_nullable_to_non_nullable
                      as bool,
            lateArrivalNoticeMinutes: null == lateArrivalNoticeMinutes
                ? _value.lateArrivalNoticeMinutes
                : lateArrivalNoticeMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            enforceGracePeriodForLateArrival:
                null == enforceGracePeriodForLateArrival
                ? _value.enforceGracePeriodForLateArrival
                : enforceGracePeriodForLateArrival // ignore: cast_nullable_to_non_nullable
                      as bool,
            enforceEarlyDepartureDeadline: null == enforceEarlyDepartureDeadline
                ? _value.enforceEarlyDepartureDeadline
                : enforceEarlyDepartureDeadline // ignore: cast_nullable_to_non_nullable
                      as bool,
            earlyDepartureDeadlinePercent: null == earlyDepartureDeadlinePercent
                ? _value.earlyDepartureDeadlinePercent
                : earlyDepartureDeadlinePercent // ignore: cast_nullable_to_non_nullable
                      as int,
            allowPermitsOnWeekends: null == allowPermitsOnWeekends
                ? _value.allowPermitsOnWeekends
                : allowPermitsOnWeekends // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowPermitsOnHolidays: null == allowPermitsOnHolidays
                ? _value.allowPermitsOnHolidays
                : allowPermitsOnHolidays // ignore: cast_nullable_to_non_nullable
                      as bool,
            forceSameDayCasualLeave: null == forceSameDayCasualLeave
                ? _value.forceSameDayCasualLeave
                : forceSameDayCasualLeave // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CompanyApprovalConfigModelImplCopyWith<$Res>
    implements $CompanyApprovalConfigModelCopyWith<$Res> {
  factory _$$CompanyApprovalConfigModelImplCopyWith(
    _$CompanyApprovalConfigModelImpl value,
    $Res Function(_$CompanyApprovalConfigModelImpl) then,
  ) = __$$CompanyApprovalConfigModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String leaveWorkflow,
    int holdingGracePeriodMinutes,
    bool adminsObserverOnly,
    bool adminCanOverrideHolding,
    bool enforceLateArrivalNoticeDeadline,
    int lateArrivalNoticeMinutes,
    bool enforceGracePeriodForLateArrival,
    bool enforceEarlyDepartureDeadline,
    int earlyDepartureDeadlinePercent,
    bool allowPermitsOnWeekends,
    bool allowPermitsOnHolidays,
    bool forceSameDayCasualLeave,
  });
}

/// @nodoc
class __$$CompanyApprovalConfigModelImplCopyWithImpl<$Res>
    extends
        _$CompanyApprovalConfigModelCopyWithImpl<
          $Res,
          _$CompanyApprovalConfigModelImpl
        >
    implements _$$CompanyApprovalConfigModelImplCopyWith<$Res> {
  __$$CompanyApprovalConfigModelImplCopyWithImpl(
    _$CompanyApprovalConfigModelImpl _value,
    $Res Function(_$CompanyApprovalConfigModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompanyApprovalConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaveWorkflow = null,
    Object? holdingGracePeriodMinutes = null,
    Object? adminsObserverOnly = null,
    Object? adminCanOverrideHolding = null,
    Object? enforceLateArrivalNoticeDeadline = null,
    Object? lateArrivalNoticeMinutes = null,
    Object? enforceGracePeriodForLateArrival = null,
    Object? enforceEarlyDepartureDeadline = null,
    Object? earlyDepartureDeadlinePercent = null,
    Object? allowPermitsOnWeekends = null,
    Object? allowPermitsOnHolidays = null,
    Object? forceSameDayCasualLeave = null,
  }) {
    return _then(
      _$CompanyApprovalConfigModelImpl(
        leaveWorkflow: null == leaveWorkflow
            ? _value.leaveWorkflow
            : leaveWorkflow // ignore: cast_nullable_to_non_nullable
                  as String,
        holdingGracePeriodMinutes: null == holdingGracePeriodMinutes
            ? _value.holdingGracePeriodMinutes
            : holdingGracePeriodMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        adminsObserverOnly: null == adminsObserverOnly
            ? _value.adminsObserverOnly
            : adminsObserverOnly // ignore: cast_nullable_to_non_nullable
                  as bool,
        adminCanOverrideHolding: null == adminCanOverrideHolding
            ? _value.adminCanOverrideHolding
            : adminCanOverrideHolding // ignore: cast_nullable_to_non_nullable
                  as bool,
        enforceLateArrivalNoticeDeadline:
            null == enforceLateArrivalNoticeDeadline
            ? _value.enforceLateArrivalNoticeDeadline
            : enforceLateArrivalNoticeDeadline // ignore: cast_nullable_to_non_nullable
                  as bool,
        lateArrivalNoticeMinutes: null == lateArrivalNoticeMinutes
            ? _value.lateArrivalNoticeMinutes
            : lateArrivalNoticeMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        enforceGracePeriodForLateArrival:
            null == enforceGracePeriodForLateArrival
            ? _value.enforceGracePeriodForLateArrival
            : enforceGracePeriodForLateArrival // ignore: cast_nullable_to_non_nullable
                  as bool,
        enforceEarlyDepartureDeadline: null == enforceEarlyDepartureDeadline
            ? _value.enforceEarlyDepartureDeadline
            : enforceEarlyDepartureDeadline // ignore: cast_nullable_to_non_nullable
                  as bool,
        earlyDepartureDeadlinePercent: null == earlyDepartureDeadlinePercent
            ? _value.earlyDepartureDeadlinePercent
            : earlyDepartureDeadlinePercent // ignore: cast_nullable_to_non_nullable
                  as int,
        allowPermitsOnWeekends: null == allowPermitsOnWeekends
            ? _value.allowPermitsOnWeekends
            : allowPermitsOnWeekends // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowPermitsOnHolidays: null == allowPermitsOnHolidays
            ? _value.allowPermitsOnHolidays
            : allowPermitsOnHolidays // ignore: cast_nullable_to_non_nullable
                  as bool,
        forceSameDayCasualLeave: null == forceSameDayCasualLeave
            ? _value.forceSameDayCasualLeave
            : forceSameDayCasualLeave // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyApprovalConfigModelImpl implements _CompanyApprovalConfigModel {
  const _$CompanyApprovalConfigModelImpl({
    this.leaveWorkflow = 'manager_then_hr',
    this.holdingGracePeriodMinutes = 0,
    this.adminsObserverOnly = true,
    this.adminCanOverrideHolding = false,
    this.enforceLateArrivalNoticeDeadline = false,
    this.lateArrivalNoticeMinutes = 60,
    this.enforceGracePeriodForLateArrival = false,
    this.enforceEarlyDepartureDeadline = false,
    this.earlyDepartureDeadlinePercent = 50,
    this.allowPermitsOnWeekends = true,
    this.allowPermitsOnHolidays = true,
    this.forceSameDayCasualLeave = false,
  });

  factory _$CompanyApprovalConfigModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$CompanyApprovalConfigModelImplFromJson(json);

  @override
  @JsonKey()
  final String leaveWorkflow;
  @override
  @JsonKey()
  final int holdingGracePeriodMinutes;
  @override
  @JsonKey()
  final bool adminsObserverOnly;
  @override
  @JsonKey()
  final bool adminCanOverrideHolding;
  @override
  @JsonKey()
  final bool enforceLateArrivalNoticeDeadline;
  @override
  @JsonKey()
  final int lateArrivalNoticeMinutes;
  @override
  @JsonKey()
  final bool enforceGracePeriodForLateArrival;
  @override
  @JsonKey()
  final bool enforceEarlyDepartureDeadline;
  @override
  @JsonKey()
  final int earlyDepartureDeadlinePercent;
  @override
  @JsonKey()
  final bool allowPermitsOnWeekends;
  @override
  @JsonKey()
  final bool allowPermitsOnHolidays;
  @override
  @JsonKey()
  final bool forceSameDayCasualLeave;

  @override
  String toString() {
    return 'CompanyApprovalConfigModel(leaveWorkflow: $leaveWorkflow, holdingGracePeriodMinutes: $holdingGracePeriodMinutes, adminsObserverOnly: $adminsObserverOnly, adminCanOverrideHolding: $adminCanOverrideHolding, enforceLateArrivalNoticeDeadline: $enforceLateArrivalNoticeDeadline, lateArrivalNoticeMinutes: $lateArrivalNoticeMinutes, enforceGracePeriodForLateArrival: $enforceGracePeriodForLateArrival, enforceEarlyDepartureDeadline: $enforceEarlyDepartureDeadline, earlyDepartureDeadlinePercent: $earlyDepartureDeadlinePercent, allowPermitsOnWeekends: $allowPermitsOnWeekends, allowPermitsOnHolidays: $allowPermitsOnHolidays, forceSameDayCasualLeave: $forceSameDayCasualLeave)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyApprovalConfigModelImpl &&
            (identical(other.leaveWorkflow, leaveWorkflow) ||
                other.leaveWorkflow == leaveWorkflow) &&
            (identical(
                  other.holdingGracePeriodMinutes,
                  holdingGracePeriodMinutes,
                ) ||
                other.holdingGracePeriodMinutes == holdingGracePeriodMinutes) &&
            (identical(other.adminsObserverOnly, adminsObserverOnly) ||
                other.adminsObserverOnly == adminsObserverOnly) &&
            (identical(
                  other.adminCanOverrideHolding,
                  adminCanOverrideHolding,
                ) ||
                other.adminCanOverrideHolding == adminCanOverrideHolding) &&
            (identical(
                  other.enforceLateArrivalNoticeDeadline,
                  enforceLateArrivalNoticeDeadline,
                ) ||
                other.enforceLateArrivalNoticeDeadline ==
                    enforceLateArrivalNoticeDeadline) &&
            (identical(
                  other.lateArrivalNoticeMinutes,
                  lateArrivalNoticeMinutes,
                ) ||
                other.lateArrivalNoticeMinutes == lateArrivalNoticeMinutes) &&
            (identical(
                  other.enforceGracePeriodForLateArrival,
                  enforceGracePeriodForLateArrival,
                ) ||
                other.enforceGracePeriodForLateArrival ==
                    enforceGracePeriodForLateArrival) &&
            (identical(
                  other.enforceEarlyDepartureDeadline,
                  enforceEarlyDepartureDeadline,
                ) ||
                other.enforceEarlyDepartureDeadline ==
                    enforceEarlyDepartureDeadline) &&
            (identical(
                  other.earlyDepartureDeadlinePercent,
                  earlyDepartureDeadlinePercent,
                ) ||
                other.earlyDepartureDeadlinePercent ==
                    earlyDepartureDeadlinePercent) &&
            (identical(other.allowPermitsOnWeekends, allowPermitsOnWeekends) ||
                other.allowPermitsOnWeekends == allowPermitsOnWeekends) &&
            (identical(other.allowPermitsOnHolidays, allowPermitsOnHolidays) ||
                other.allowPermitsOnHolidays == allowPermitsOnHolidays) &&
            (identical(
                  other.forceSameDayCasualLeave,
                  forceSameDayCasualLeave,
                ) ||
                other.forceSameDayCasualLeave == forceSameDayCasualLeave));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    leaveWorkflow,
    holdingGracePeriodMinutes,
    adminsObserverOnly,
    adminCanOverrideHolding,
    enforceLateArrivalNoticeDeadline,
    lateArrivalNoticeMinutes,
    enforceGracePeriodForLateArrival,
    enforceEarlyDepartureDeadline,
    earlyDepartureDeadlinePercent,
    allowPermitsOnWeekends,
    allowPermitsOnHolidays,
    forceSameDayCasualLeave,
  );

  /// Create a copy of CompanyApprovalConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyApprovalConfigModelImplCopyWith<_$CompanyApprovalConfigModelImpl>
  get copyWith =>
      __$$CompanyApprovalConfigModelImplCopyWithImpl<
        _$CompanyApprovalConfigModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyApprovalConfigModelImplToJson(this);
  }
}

abstract class _CompanyApprovalConfigModel
    implements CompanyApprovalConfigModel {
  const factory _CompanyApprovalConfigModel({
    final String leaveWorkflow,
    final int holdingGracePeriodMinutes,
    final bool adminsObserverOnly,
    final bool adminCanOverrideHolding,
    final bool enforceLateArrivalNoticeDeadline,
    final int lateArrivalNoticeMinutes,
    final bool enforceGracePeriodForLateArrival,
    final bool enforceEarlyDepartureDeadline,
    final int earlyDepartureDeadlinePercent,
    final bool allowPermitsOnWeekends,
    final bool allowPermitsOnHolidays,
    final bool forceSameDayCasualLeave,
  }) = _$CompanyApprovalConfigModelImpl;

  factory _CompanyApprovalConfigModel.fromJson(Map<String, dynamic> json) =
      _$CompanyApprovalConfigModelImpl.fromJson;

  @override
  String get leaveWorkflow;
  @override
  int get holdingGracePeriodMinutes;
  @override
  bool get adminsObserverOnly;
  @override
  bool get adminCanOverrideHolding;
  @override
  bool get enforceLateArrivalNoticeDeadline;
  @override
  int get lateArrivalNoticeMinutes;
  @override
  bool get enforceGracePeriodForLateArrival;
  @override
  bool get enforceEarlyDepartureDeadline;
  @override
  int get earlyDepartureDeadlinePercent;
  @override
  bool get allowPermitsOnWeekends;
  @override
  bool get allowPermitsOnHolidays;
  @override
  bool get forceSameDayCasualLeave;

  /// Create a copy of CompanyApprovalConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompanyApprovalConfigModelImplCopyWith<_$CompanyApprovalConfigModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
