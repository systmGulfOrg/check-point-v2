// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supervisor_worker_roll_call_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SupervisorWorkerRollCallState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )
    loaded,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )?
    loaded,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )?
    loaded,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SupervisorWorkerRollCallInitial value) initial,
    required TResult Function(SupervisorWorkerRollCallLoading value) loading,
    required TResult Function(SupervisorWorkerRollCallLoaded value) loaded,
    required TResult Function(SupervisorWorkerRollCallError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupervisorWorkerRollCallInitial value)? initial,
    TResult? Function(SupervisorWorkerRollCallLoading value)? loading,
    TResult? Function(SupervisorWorkerRollCallLoaded value)? loaded,
    TResult? Function(SupervisorWorkerRollCallError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupervisorWorkerRollCallInitial value)? initial,
    TResult Function(SupervisorWorkerRollCallLoading value)? loading,
    TResult Function(SupervisorWorkerRollCallLoaded value)? loaded,
    TResult Function(SupervisorWorkerRollCallError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupervisorWorkerRollCallStateCopyWith<$Res> {
  factory $SupervisorWorkerRollCallStateCopyWith(
    SupervisorWorkerRollCallState value,
    $Res Function(SupervisorWorkerRollCallState) then,
  ) =
      _$SupervisorWorkerRollCallStateCopyWithImpl<
        $Res,
        SupervisorWorkerRollCallState
      >;
}

/// @nodoc
class _$SupervisorWorkerRollCallStateCopyWithImpl<
  $Res,
  $Val extends SupervisorWorkerRollCallState
>
    implements $SupervisorWorkerRollCallStateCopyWith<$Res> {
  _$SupervisorWorkerRollCallStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupervisorWorkerRollCallState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SupervisorWorkerRollCallInitialImplCopyWith<$Res> {
  factory _$$SupervisorWorkerRollCallInitialImplCopyWith(
    _$SupervisorWorkerRollCallInitialImpl value,
    $Res Function(_$SupervisorWorkerRollCallInitialImpl) then,
  ) = __$$SupervisorWorkerRollCallInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SupervisorWorkerRollCallInitialImplCopyWithImpl<$Res>
    extends
        _$SupervisorWorkerRollCallStateCopyWithImpl<
          $Res,
          _$SupervisorWorkerRollCallInitialImpl
        >
    implements _$$SupervisorWorkerRollCallInitialImplCopyWith<$Res> {
  __$$SupervisorWorkerRollCallInitialImplCopyWithImpl(
    _$SupervisorWorkerRollCallInitialImpl _value,
    $Res Function(_$SupervisorWorkerRollCallInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupervisorWorkerRollCallState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SupervisorWorkerRollCallInitialImpl
    implements SupervisorWorkerRollCallInitial {
  const _$SupervisorWorkerRollCallInitialImpl();

  @override
  String toString() {
    return 'SupervisorWorkerRollCallState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupervisorWorkerRollCallInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )
    loaded,
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
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )?
    loaded,
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
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )?
    loaded,
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
    required TResult Function(SupervisorWorkerRollCallInitial value) initial,
    required TResult Function(SupervisorWorkerRollCallLoading value) loading,
    required TResult Function(SupervisorWorkerRollCallLoaded value) loaded,
    required TResult Function(SupervisorWorkerRollCallError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupervisorWorkerRollCallInitial value)? initial,
    TResult? Function(SupervisorWorkerRollCallLoading value)? loading,
    TResult? Function(SupervisorWorkerRollCallLoaded value)? loaded,
    TResult? Function(SupervisorWorkerRollCallError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupervisorWorkerRollCallInitial value)? initial,
    TResult Function(SupervisorWorkerRollCallLoading value)? loading,
    TResult Function(SupervisorWorkerRollCallLoaded value)? loaded,
    TResult Function(SupervisorWorkerRollCallError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SupervisorWorkerRollCallInitial
    implements SupervisorWorkerRollCallState {
  const factory SupervisorWorkerRollCallInitial() =
      _$SupervisorWorkerRollCallInitialImpl;
}

/// @nodoc
abstract class _$$SupervisorWorkerRollCallLoadingImplCopyWith<$Res> {
  factory _$$SupervisorWorkerRollCallLoadingImplCopyWith(
    _$SupervisorWorkerRollCallLoadingImpl value,
    $Res Function(_$SupervisorWorkerRollCallLoadingImpl) then,
  ) = __$$SupervisorWorkerRollCallLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SupervisorWorkerRollCallLoadingImplCopyWithImpl<$Res>
    extends
        _$SupervisorWorkerRollCallStateCopyWithImpl<
          $Res,
          _$SupervisorWorkerRollCallLoadingImpl
        >
    implements _$$SupervisorWorkerRollCallLoadingImplCopyWith<$Res> {
  __$$SupervisorWorkerRollCallLoadingImplCopyWithImpl(
    _$SupervisorWorkerRollCallLoadingImpl _value,
    $Res Function(_$SupervisorWorkerRollCallLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupervisorWorkerRollCallState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SupervisorWorkerRollCallLoadingImpl
    implements SupervisorWorkerRollCallLoading {
  const _$SupervisorWorkerRollCallLoadingImpl();

  @override
  String toString() {
    return 'SupervisorWorkerRollCallState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupervisorWorkerRollCallLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )
    loaded,
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
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )?
    loaded,
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
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )?
    loaded,
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
    required TResult Function(SupervisorWorkerRollCallInitial value) initial,
    required TResult Function(SupervisorWorkerRollCallLoading value) loading,
    required TResult Function(SupervisorWorkerRollCallLoaded value) loaded,
    required TResult Function(SupervisorWorkerRollCallError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupervisorWorkerRollCallInitial value)? initial,
    TResult? Function(SupervisorWorkerRollCallLoading value)? loading,
    TResult? Function(SupervisorWorkerRollCallLoaded value)? loaded,
    TResult? Function(SupervisorWorkerRollCallError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupervisorWorkerRollCallInitial value)? initial,
    TResult Function(SupervisorWorkerRollCallLoading value)? loading,
    TResult Function(SupervisorWorkerRollCallLoaded value)? loaded,
    TResult Function(SupervisorWorkerRollCallError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SupervisorWorkerRollCallLoading
    implements SupervisorWorkerRollCallState {
  const factory SupervisorWorkerRollCallLoading() =
      _$SupervisorWorkerRollCallLoadingImpl;
}

/// @nodoc
abstract class _$$SupervisorWorkerRollCallLoadedImplCopyWith<$Res> {
  factory _$$SupervisorWorkerRollCallLoadedImplCopyWith(
    _$SupervisorWorkerRollCallLoadedImpl value,
    $Res Function(_$SupervisorWorkerRollCallLoadedImpl) then,
  ) = __$$SupervisorWorkerRollCallLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<WorkerDayItemModel> workers,
    List<BranchModel> sites,
    String? selectedSiteId,
    DateTime date,
    bool isSubmitting,
    RecordWorkerAttendanceValueModel? lastResult,
    String? successMessage,
    String? errorMessage,
  });
}

/// @nodoc
class __$$SupervisorWorkerRollCallLoadedImplCopyWithImpl<$Res>
    extends
        _$SupervisorWorkerRollCallStateCopyWithImpl<
          $Res,
          _$SupervisorWorkerRollCallLoadedImpl
        >
    implements _$$SupervisorWorkerRollCallLoadedImplCopyWith<$Res> {
  __$$SupervisorWorkerRollCallLoadedImplCopyWithImpl(
    _$SupervisorWorkerRollCallLoadedImpl _value,
    $Res Function(_$SupervisorWorkerRollCallLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupervisorWorkerRollCallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workers = null,
    Object? sites = null,
    Object? selectedSiteId = freezed,
    Object? date = null,
    Object? isSubmitting = null,
    Object? lastResult = freezed,
    Object? successMessage = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$SupervisorWorkerRollCallLoadedImpl(
        workers: null == workers
            ? _value._workers
            : workers // ignore: cast_nullable_to_non_nullable
                  as List<WorkerDayItemModel>,
        sites: null == sites
            ? _value._sites
            : sites // ignore: cast_nullable_to_non_nullable
                  as List<BranchModel>,
        selectedSiteId: freezed == selectedSiteId
            ? _value.selectedSiteId
            : selectedSiteId // ignore: cast_nullable_to_non_nullable
                  as String?,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastResult: freezed == lastResult
            ? _value.lastResult
            : lastResult // ignore: cast_nullable_to_non_nullable
                  as RecordWorkerAttendanceValueModel?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
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

class _$SupervisorWorkerRollCallLoadedImpl
    implements SupervisorWorkerRollCallLoaded {
  const _$SupervisorWorkerRollCallLoadedImpl({
    required final List<WorkerDayItemModel> workers,
    final List<BranchModel> sites = const [],
    this.selectedSiteId,
    required this.date,
    this.isSubmitting = false,
    this.lastResult,
    this.successMessage,
    this.errorMessage,
  }) : _workers = workers,
       _sites = sites;

  final List<WorkerDayItemModel> _workers;
  @override
  List<WorkerDayItemModel> get workers {
    if (_workers is EqualUnmodifiableListView) return _workers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workers);
  }

  final List<BranchModel> _sites;
  @override
  @JsonKey()
  List<BranchModel> get sites {
    if (_sites is EqualUnmodifiableListView) return _sites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sites);
  }

  @override
  final String? selectedSiteId;
  @override
  final DateTime date;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  final RecordWorkerAttendanceValueModel? lastResult;
  @override
  final String? successMessage;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SupervisorWorkerRollCallState.loaded(workers: $workers, sites: $sites, selectedSiteId: $selectedSiteId, date: $date, isSubmitting: $isSubmitting, lastResult: $lastResult, successMessage: $successMessage, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupervisorWorkerRollCallLoadedImpl &&
            const DeepCollectionEquality().equals(other._workers, _workers) &&
            const DeepCollectionEquality().equals(other._sites, _sites) &&
            (identical(other.selectedSiteId, selectedSiteId) ||
                other.selectedSiteId == selectedSiteId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.lastResult, lastResult) ||
                other.lastResult == lastResult) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_workers),
    const DeepCollectionEquality().hash(_sites),
    selectedSiteId,
    date,
    isSubmitting,
    lastResult,
    successMessage,
    errorMessage,
  );

  /// Create a copy of SupervisorWorkerRollCallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupervisorWorkerRollCallLoadedImplCopyWith<
    _$SupervisorWorkerRollCallLoadedImpl
  >
  get copyWith =>
      __$$SupervisorWorkerRollCallLoadedImplCopyWithImpl<
        _$SupervisorWorkerRollCallLoadedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )
    loaded,
    required TResult Function(String messageKey) error,
  }) {
    return loaded(
      workers,
      sites,
      selectedSiteId,
      date,
      isSubmitting,
      lastResult,
      successMessage,
      errorMessage,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )?
    loaded,
    TResult? Function(String messageKey)? error,
  }) {
    return loaded?.call(
      workers,
      sites,
      selectedSiteId,
      date,
      isSubmitting,
      lastResult,
      successMessage,
      errorMessage,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )?
    loaded,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        workers,
        sites,
        selectedSiteId,
        date,
        isSubmitting,
        lastResult,
        successMessage,
        errorMessage,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SupervisorWorkerRollCallInitial value) initial,
    required TResult Function(SupervisorWorkerRollCallLoading value) loading,
    required TResult Function(SupervisorWorkerRollCallLoaded value) loaded,
    required TResult Function(SupervisorWorkerRollCallError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupervisorWorkerRollCallInitial value)? initial,
    TResult? Function(SupervisorWorkerRollCallLoading value)? loading,
    TResult? Function(SupervisorWorkerRollCallLoaded value)? loaded,
    TResult? Function(SupervisorWorkerRollCallError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupervisorWorkerRollCallInitial value)? initial,
    TResult Function(SupervisorWorkerRollCallLoading value)? loading,
    TResult Function(SupervisorWorkerRollCallLoaded value)? loaded,
    TResult Function(SupervisorWorkerRollCallError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SupervisorWorkerRollCallLoaded
    implements SupervisorWorkerRollCallState {
  const factory SupervisorWorkerRollCallLoaded({
    required final List<WorkerDayItemModel> workers,
    final List<BranchModel> sites,
    final String? selectedSiteId,
    required final DateTime date,
    final bool isSubmitting,
    final RecordWorkerAttendanceValueModel? lastResult,
    final String? successMessage,
    final String? errorMessage,
  }) = _$SupervisorWorkerRollCallLoadedImpl;

  List<WorkerDayItemModel> get workers;
  List<BranchModel> get sites;
  String? get selectedSiteId;
  DateTime get date;
  bool get isSubmitting;
  RecordWorkerAttendanceValueModel? get lastResult;
  String? get successMessage;
  String? get errorMessage;

  /// Create a copy of SupervisorWorkerRollCallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupervisorWorkerRollCallLoadedImplCopyWith<
    _$SupervisorWorkerRollCallLoadedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SupervisorWorkerRollCallErrorImplCopyWith<$Res> {
  factory _$$SupervisorWorkerRollCallErrorImplCopyWith(
    _$SupervisorWorkerRollCallErrorImpl value,
    $Res Function(_$SupervisorWorkerRollCallErrorImpl) then,
  ) = __$$SupervisorWorkerRollCallErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$SupervisorWorkerRollCallErrorImplCopyWithImpl<$Res>
    extends
        _$SupervisorWorkerRollCallStateCopyWithImpl<
          $Res,
          _$SupervisorWorkerRollCallErrorImpl
        >
    implements _$$SupervisorWorkerRollCallErrorImplCopyWith<$Res> {
  __$$SupervisorWorkerRollCallErrorImplCopyWithImpl(
    _$SupervisorWorkerRollCallErrorImpl _value,
    $Res Function(_$SupervisorWorkerRollCallErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupervisorWorkerRollCallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$SupervisorWorkerRollCallErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SupervisorWorkerRollCallErrorImpl
    implements SupervisorWorkerRollCallError {
  const _$SupervisorWorkerRollCallErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'SupervisorWorkerRollCallState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupervisorWorkerRollCallErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of SupervisorWorkerRollCallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupervisorWorkerRollCallErrorImplCopyWith<
    _$SupervisorWorkerRollCallErrorImpl
  >
  get copyWith =>
      __$$SupervisorWorkerRollCallErrorImplCopyWithImpl<
        _$SupervisorWorkerRollCallErrorImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )
    loaded,
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
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )?
    loaded,
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
      List<WorkerDayItemModel> workers,
      List<BranchModel> sites,
      String? selectedSiteId,
      DateTime date,
      bool isSubmitting,
      RecordWorkerAttendanceValueModel? lastResult,
      String? successMessage,
      String? errorMessage,
    )?
    loaded,
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
    required TResult Function(SupervisorWorkerRollCallInitial value) initial,
    required TResult Function(SupervisorWorkerRollCallLoading value) loading,
    required TResult Function(SupervisorWorkerRollCallLoaded value) loaded,
    required TResult Function(SupervisorWorkerRollCallError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupervisorWorkerRollCallInitial value)? initial,
    TResult? Function(SupervisorWorkerRollCallLoading value)? loading,
    TResult? Function(SupervisorWorkerRollCallLoaded value)? loaded,
    TResult? Function(SupervisorWorkerRollCallError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupervisorWorkerRollCallInitial value)? initial,
    TResult Function(SupervisorWorkerRollCallLoading value)? loading,
    TResult Function(SupervisorWorkerRollCallLoaded value)? loaded,
    TResult Function(SupervisorWorkerRollCallError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SupervisorWorkerRollCallError
    implements SupervisorWorkerRollCallState {
  const factory SupervisorWorkerRollCallError(final String messageKey) =
      _$SupervisorWorkerRollCallErrorImpl;

  String get messageKey;

  /// Create a copy of SupervisorWorkerRollCallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupervisorWorkerRollCallErrorImplCopyWith<
    _$SupervisorWorkerRollCallErrorImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
