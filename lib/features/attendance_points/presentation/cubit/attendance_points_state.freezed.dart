// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_points_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AttendancePointsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )
    success,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )?
    success,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )?
    success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendancePointsInitial value) initial,
    required TResult Function(AttendancePointsLoading value) loading,
    required TResult Function(AttendancePointsSuccess value) success,
    required TResult Function(AttendancePointsError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendancePointsInitial value)? initial,
    TResult? Function(AttendancePointsLoading value)? loading,
    TResult? Function(AttendancePointsSuccess value)? success,
    TResult? Function(AttendancePointsError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendancePointsInitial value)? initial,
    TResult Function(AttendancePointsLoading value)? loading,
    TResult Function(AttendancePointsSuccess value)? success,
    TResult Function(AttendancePointsError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendancePointsStateCopyWith<$Res> {
  factory $AttendancePointsStateCopyWith(
    AttendancePointsState value,
    $Res Function(AttendancePointsState) then,
  ) = _$AttendancePointsStateCopyWithImpl<$Res, AttendancePointsState>;
}

/// @nodoc
class _$AttendancePointsStateCopyWithImpl<
  $Res,
  $Val extends AttendancePointsState
>
    implements $AttendancePointsStateCopyWith<$Res> {
  _$AttendancePointsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendancePointsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AttendancePointsInitialImplCopyWith<$Res> {
  factory _$$AttendancePointsInitialImplCopyWith(
    _$AttendancePointsInitialImpl value,
    $Res Function(_$AttendancePointsInitialImpl) then,
  ) = __$$AttendancePointsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AttendancePointsInitialImplCopyWithImpl<$Res>
    extends
        _$AttendancePointsStateCopyWithImpl<$Res, _$AttendancePointsInitialImpl>
    implements _$$AttendancePointsInitialImplCopyWith<$Res> {
  __$$AttendancePointsInitialImplCopyWithImpl(
    _$AttendancePointsInitialImpl _value,
    $Res Function(_$AttendancePointsInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendancePointsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AttendancePointsInitialImpl implements AttendancePointsInitial {
  const _$AttendancePointsInitialImpl();

  @override
  String toString() {
    return 'AttendancePointsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendancePointsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )
    success,
    required TResult Function(String messageKey) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )?
    success,
    TResult? Function(String messageKey)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )?
    success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendancePointsInitial value) initial,
    required TResult Function(AttendancePointsLoading value) loading,
    required TResult Function(AttendancePointsSuccess value) success,
    required TResult Function(AttendancePointsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendancePointsInitial value)? initial,
    TResult? Function(AttendancePointsLoading value)? loading,
    TResult? Function(AttendancePointsSuccess value)? success,
    TResult? Function(AttendancePointsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendancePointsInitial value)? initial,
    TResult Function(AttendancePointsLoading value)? loading,
    TResult Function(AttendancePointsSuccess value)? success,
    TResult Function(AttendancePointsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AttendancePointsInitial implements AttendancePointsState {
  const factory AttendancePointsInitial() = _$AttendancePointsInitialImpl;
}

/// @nodoc
abstract class _$$AttendancePointsLoadingImplCopyWith<$Res> {
  factory _$$AttendancePointsLoadingImplCopyWith(
    _$AttendancePointsLoadingImpl value,
    $Res Function(_$AttendancePointsLoadingImpl) then,
  ) = __$$AttendancePointsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AttendancePointsLoadingImplCopyWithImpl<$Res>
    extends
        _$AttendancePointsStateCopyWithImpl<$Res, _$AttendancePointsLoadingImpl>
    implements _$$AttendancePointsLoadingImplCopyWith<$Res> {
  __$$AttendancePointsLoadingImplCopyWithImpl(
    _$AttendancePointsLoadingImpl _value,
    $Res Function(_$AttendancePointsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendancePointsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AttendancePointsLoadingImpl implements AttendancePointsLoading {
  const _$AttendancePointsLoadingImpl();

  @override
  String toString() {
    return 'AttendancePointsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendancePointsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )
    success,
    required TResult Function(String messageKey) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )?
    success,
    TResult? Function(String messageKey)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )?
    success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendancePointsInitial value) initial,
    required TResult Function(AttendancePointsLoading value) loading,
    required TResult Function(AttendancePointsSuccess value) success,
    required TResult Function(AttendancePointsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendancePointsInitial value)? initial,
    TResult? Function(AttendancePointsLoading value)? loading,
    TResult? Function(AttendancePointsSuccess value)? success,
    TResult? Function(AttendancePointsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendancePointsInitial value)? initial,
    TResult Function(AttendancePointsLoading value)? loading,
    TResult Function(AttendancePointsSuccess value)? success,
    TResult Function(AttendancePointsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AttendancePointsLoading implements AttendancePointsState {
  const factory AttendancePointsLoading() = _$AttendancePointsLoadingImpl;
}

/// @nodoc
abstract class _$$AttendancePointsSuccessImplCopyWith<$Res> {
  factory _$$AttendancePointsSuccessImplCopyWith(
    _$AttendancePointsSuccessImpl value,
    $Res Function(_$AttendancePointsSuccessImpl) then,
  ) = __$$AttendancePointsSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PointsSummaryModel summary, List<AttendancePointModel> history});

  $PointsSummaryModelCopyWith<$Res> get summary;
}

/// @nodoc
class __$$AttendancePointsSuccessImplCopyWithImpl<$Res>
    extends
        _$AttendancePointsStateCopyWithImpl<$Res, _$AttendancePointsSuccessImpl>
    implements _$$AttendancePointsSuccessImplCopyWith<$Res> {
  __$$AttendancePointsSuccessImplCopyWithImpl(
    _$AttendancePointsSuccessImpl _value,
    $Res Function(_$AttendancePointsSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendancePointsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? summary = null, Object? history = null}) {
    return _then(
      _$AttendancePointsSuccessImpl(
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as PointsSummaryModel,
        history: null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
                  as List<AttendancePointModel>,
      ),
    );
  }

  /// Create a copy of AttendancePointsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointsSummaryModelCopyWith<$Res> get summary {
    return $PointsSummaryModelCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value));
    });
  }
}

/// @nodoc

class _$AttendancePointsSuccessImpl implements AttendancePointsSuccess {
  const _$AttendancePointsSuccessImpl({
    required this.summary,
    required final List<AttendancePointModel> history,
  }) : _history = history;

  @override
  final PointsSummaryModel summary;
  final List<AttendancePointModel> _history;
  @override
  List<AttendancePointModel> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  String toString() {
    return 'AttendancePointsState.success(summary: $summary, history: $history)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendancePointsSuccessImpl &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._history, _history));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    summary,
    const DeepCollectionEquality().hash(_history),
  );

  /// Create a copy of AttendancePointsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendancePointsSuccessImplCopyWith<_$AttendancePointsSuccessImpl>
  get copyWith =>
      __$$AttendancePointsSuccessImplCopyWithImpl<
        _$AttendancePointsSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )
    success,
    required TResult Function(String messageKey) error,
  }) {
    return success(summary, history);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )?
    success,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call(summary, history);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )?
    success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(summary, history);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendancePointsInitial value) initial,
    required TResult Function(AttendancePointsLoading value) loading,
    required TResult Function(AttendancePointsSuccess value) success,
    required TResult Function(AttendancePointsError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendancePointsInitial value)? initial,
    TResult? Function(AttendancePointsLoading value)? loading,
    TResult? Function(AttendancePointsSuccess value)? success,
    TResult? Function(AttendancePointsError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendancePointsInitial value)? initial,
    TResult Function(AttendancePointsLoading value)? loading,
    TResult Function(AttendancePointsSuccess value)? success,
    TResult Function(AttendancePointsError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AttendancePointsSuccess implements AttendancePointsState {
  const factory AttendancePointsSuccess({
    required final PointsSummaryModel summary,
    required final List<AttendancePointModel> history,
  }) = _$AttendancePointsSuccessImpl;

  PointsSummaryModel get summary;
  List<AttendancePointModel> get history;

  /// Create a copy of AttendancePointsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendancePointsSuccessImplCopyWith<_$AttendancePointsSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AttendancePointsErrorImplCopyWith<$Res> {
  factory _$$AttendancePointsErrorImplCopyWith(
    _$AttendancePointsErrorImpl value,
    $Res Function(_$AttendancePointsErrorImpl) then,
  ) = __$$AttendancePointsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$AttendancePointsErrorImplCopyWithImpl<$Res>
    extends
        _$AttendancePointsStateCopyWithImpl<$Res, _$AttendancePointsErrorImpl>
    implements _$$AttendancePointsErrorImplCopyWith<$Res> {
  __$$AttendancePointsErrorImplCopyWithImpl(
    _$AttendancePointsErrorImpl _value,
    $Res Function(_$AttendancePointsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendancePointsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$AttendancePointsErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AttendancePointsErrorImpl implements AttendancePointsError {
  const _$AttendancePointsErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'AttendancePointsState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendancePointsErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of AttendancePointsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendancePointsErrorImplCopyWith<_$AttendancePointsErrorImpl>
  get copyWith =>
      __$$AttendancePointsErrorImplCopyWithImpl<_$AttendancePointsErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )
    success,
    required TResult Function(String messageKey) error,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )?
    success,
    TResult? Function(String messageKey)? error,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PointsSummaryModel summary,
      List<AttendancePointModel> history,
    )?
    success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(messageKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendancePointsInitial value) initial,
    required TResult Function(AttendancePointsLoading value) loading,
    required TResult Function(AttendancePointsSuccess value) success,
    required TResult Function(AttendancePointsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendancePointsInitial value)? initial,
    TResult? Function(AttendancePointsLoading value)? loading,
    TResult? Function(AttendancePointsSuccess value)? success,
    TResult? Function(AttendancePointsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendancePointsInitial value)? initial,
    TResult Function(AttendancePointsLoading value)? loading,
    TResult Function(AttendancePointsSuccess value)? success,
    TResult Function(AttendancePointsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AttendancePointsError implements AttendancePointsState {
  const factory AttendancePointsError(final String messageKey) =
      _$AttendancePointsErrorImpl;

  String get messageKey;

  /// Create a copy of AttendancePointsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendancePointsErrorImplCopyWith<_$AttendancePointsErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}
