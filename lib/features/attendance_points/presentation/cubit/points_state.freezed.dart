// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PointsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PointsSummaryModel summary,
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PointsSummaryModel summary,
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PointsSummaryModel summary,
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PointsInitial value) initial,
    required TResult Function(PointsLoading value) loading,
    required TResult Function(PointsLoaded value) loaded,
    required TResult Function(PointsError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PointsInitial value)? initial,
    TResult? Function(PointsLoading value)? loading,
    TResult? Function(PointsLoaded value)? loaded,
    TResult? Function(PointsError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PointsInitial value)? initial,
    TResult Function(PointsLoading value)? loading,
    TResult Function(PointsLoaded value)? loaded,
    TResult Function(PointsError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsStateCopyWith<$Res> {
  factory $PointsStateCopyWith(
    PointsState value,
    $Res Function(PointsState) then,
  ) = _$PointsStateCopyWithImpl<$Res, PointsState>;
}

/// @nodoc
class _$PointsStateCopyWithImpl<$Res, $Val extends PointsState>
    implements $PointsStateCopyWith<$Res> {
  _$PointsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PointsInitialImplCopyWith<$Res> {
  factory _$$PointsInitialImplCopyWith(
    _$PointsInitialImpl value,
    $Res Function(_$PointsInitialImpl) then,
  ) = __$$PointsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PointsInitialImplCopyWithImpl<$Res>
    extends _$PointsStateCopyWithImpl<$Res, _$PointsInitialImpl>
    implements _$$PointsInitialImplCopyWith<$Res> {
  __$$PointsInitialImplCopyWithImpl(
    _$PointsInitialImpl _value,
    $Res Function(_$PointsInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PointsInitialImpl implements PointsInitial {
  const _$PointsInitialImpl();

  @override
  String toString() {
    return 'PointsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PointsInitialImpl);
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
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )
    loaded,
    required TResult Function(String message) error,
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
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )?
    loaded,
    TResult? Function(String message)? error,
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
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )?
    loaded,
    TResult Function(String message)? error,
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
    required TResult Function(PointsInitial value) initial,
    required TResult Function(PointsLoading value) loading,
    required TResult Function(PointsLoaded value) loaded,
    required TResult Function(PointsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PointsInitial value)? initial,
    TResult? Function(PointsLoading value)? loading,
    TResult? Function(PointsLoaded value)? loaded,
    TResult? Function(PointsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PointsInitial value)? initial,
    TResult Function(PointsLoading value)? loading,
    TResult Function(PointsLoaded value)? loaded,
    TResult Function(PointsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PointsInitial implements PointsState {
  const factory PointsInitial() = _$PointsInitialImpl;
}

/// @nodoc
abstract class _$$PointsLoadingImplCopyWith<$Res> {
  factory _$$PointsLoadingImplCopyWith(
    _$PointsLoadingImpl value,
    $Res Function(_$PointsLoadingImpl) then,
  ) = __$$PointsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PointsLoadingImplCopyWithImpl<$Res>
    extends _$PointsStateCopyWithImpl<$Res, _$PointsLoadingImpl>
    implements _$$PointsLoadingImplCopyWith<$Res> {
  __$$PointsLoadingImplCopyWithImpl(
    _$PointsLoadingImpl _value,
    $Res Function(_$PointsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PointsLoadingImpl implements PointsLoading {
  const _$PointsLoadingImpl();

  @override
  String toString() {
    return 'PointsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PointsLoadingImpl);
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
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )
    loaded,
    required TResult Function(String message) error,
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
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )?
    loaded,
    TResult? Function(String message)? error,
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
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )?
    loaded,
    TResult Function(String message)? error,
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
    required TResult Function(PointsInitial value) initial,
    required TResult Function(PointsLoading value) loading,
    required TResult Function(PointsLoaded value) loaded,
    required TResult Function(PointsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PointsInitial value)? initial,
    TResult? Function(PointsLoading value)? loading,
    TResult? Function(PointsLoaded value)? loaded,
    TResult? Function(PointsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PointsInitial value)? initial,
    TResult Function(PointsLoading value)? loading,
    TResult Function(PointsLoaded value)? loaded,
    TResult Function(PointsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PointsLoading implements PointsState {
  const factory PointsLoading() = _$PointsLoadingImpl;
}

/// @nodoc
abstract class _$$PointsLoadedImplCopyWith<$Res> {
  factory _$$PointsLoadedImplCopyWith(
    _$PointsLoadedImpl value,
    $Res Function(_$PointsLoadedImpl) then,
  ) = __$$PointsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    PointsSummaryModel summary,
    List<PointsHistoryItemModel> history,
    List<PointsBadgeItemModel> badges,
    List<PointsLeaderboardEntryModel> leaderboard,
  });

  $PointsSummaryModelCopyWith<$Res> get summary;
}

/// @nodoc
class __$$PointsLoadedImplCopyWithImpl<$Res>
    extends _$PointsStateCopyWithImpl<$Res, _$PointsLoadedImpl>
    implements _$$PointsLoadedImplCopyWith<$Res> {
  __$$PointsLoadedImplCopyWithImpl(
    _$PointsLoadedImpl _value,
    $Res Function(_$PointsLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? history = null,
    Object? badges = null,
    Object? leaderboard = null,
  }) {
    return _then(
      _$PointsLoadedImpl(
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as PointsSummaryModel,
        history: null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
                  as List<PointsHistoryItemModel>,
        badges: null == badges
            ? _value._badges
            : badges // ignore: cast_nullable_to_non_nullable
                  as List<PointsBadgeItemModel>,
        leaderboard: null == leaderboard
            ? _value._leaderboard
            : leaderboard // ignore: cast_nullable_to_non_nullable
                  as List<PointsLeaderboardEntryModel>,
      ),
    );
  }

  /// Create a copy of PointsState
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

class _$PointsLoadedImpl implements PointsLoaded {
  const _$PointsLoadedImpl({
    required this.summary,
    final List<PointsHistoryItemModel> history =
        const <PointsHistoryItemModel>[],
    final List<PointsBadgeItemModel> badges = const <PointsBadgeItemModel>[],
    final List<PointsLeaderboardEntryModel> leaderboard =
        const <PointsLeaderboardEntryModel>[],
  }) : _history = history,
       _badges = badges,
       _leaderboard = leaderboard;

  @override
  final PointsSummaryModel summary;
  final List<PointsHistoryItemModel> _history;
  @override
  @JsonKey()
  List<PointsHistoryItemModel> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  final List<PointsBadgeItemModel> _badges;
  @override
  @JsonKey()
  List<PointsBadgeItemModel> get badges {
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
  }

  final List<PointsLeaderboardEntryModel> _leaderboard;
  @override
  @JsonKey()
  List<PointsLeaderboardEntryModel> get leaderboard {
    if (_leaderboard is EqualUnmodifiableListView) return _leaderboard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_leaderboard);
  }

  @override
  String toString() {
    return 'PointsState.loaded(summary: $summary, history: $history, badges: $badges, leaderboard: $leaderboard)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsLoadedImpl &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            const DeepCollectionEquality().equals(
              other._leaderboard,
              _leaderboard,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    summary,
    const DeepCollectionEquality().hash(_history),
    const DeepCollectionEquality().hash(_badges),
    const DeepCollectionEquality().hash(_leaderboard),
  );

  /// Create a copy of PointsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsLoadedImplCopyWith<_$PointsLoadedImpl> get copyWith =>
      __$$PointsLoadedImplCopyWithImpl<_$PointsLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PointsSummaryModel summary,
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(summary, history, badges, leaderboard);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PointsSummaryModel summary,
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(summary, history, badges, leaderboard);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PointsSummaryModel summary,
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(summary, history, badges, leaderboard);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PointsInitial value) initial,
    required TResult Function(PointsLoading value) loading,
    required TResult Function(PointsLoaded value) loaded,
    required TResult Function(PointsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PointsInitial value)? initial,
    TResult? Function(PointsLoading value)? loading,
    TResult? Function(PointsLoaded value)? loaded,
    TResult? Function(PointsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PointsInitial value)? initial,
    TResult Function(PointsLoading value)? loading,
    TResult Function(PointsLoaded value)? loaded,
    TResult Function(PointsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class PointsLoaded implements PointsState {
  const factory PointsLoaded({
    required final PointsSummaryModel summary,
    final List<PointsHistoryItemModel> history,
    final List<PointsBadgeItemModel> badges,
    final List<PointsLeaderboardEntryModel> leaderboard,
  }) = _$PointsLoadedImpl;

  PointsSummaryModel get summary;
  List<PointsHistoryItemModel> get history;
  List<PointsBadgeItemModel> get badges;
  List<PointsLeaderboardEntryModel> get leaderboard;

  /// Create a copy of PointsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsLoadedImplCopyWith<_$PointsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PointsErrorImplCopyWith<$Res> {
  factory _$$PointsErrorImplCopyWith(
    _$PointsErrorImpl value,
    $Res Function(_$PointsErrorImpl) then,
  ) = __$$PointsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PointsErrorImplCopyWithImpl<$Res>
    extends _$PointsStateCopyWithImpl<$Res, _$PointsErrorImpl>
    implements _$$PointsErrorImplCopyWith<$Res> {
  __$$PointsErrorImplCopyWithImpl(
    _$PointsErrorImpl _value,
    $Res Function(_$PointsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$PointsErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PointsErrorImpl implements PointsError {
  const _$PointsErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'PointsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PointsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsErrorImplCopyWith<_$PointsErrorImpl> get copyWith =>
      __$$PointsErrorImplCopyWithImpl<_$PointsErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PointsSummaryModel summary,
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PointsSummaryModel summary,
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PointsSummaryModel summary,
      List<PointsHistoryItemModel> history,
      List<PointsBadgeItemModel> badges,
      List<PointsLeaderboardEntryModel> leaderboard,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PointsInitial value) initial,
    required TResult Function(PointsLoading value) loading,
    required TResult Function(PointsLoaded value) loaded,
    required TResult Function(PointsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PointsInitial value)? initial,
    TResult? Function(PointsLoading value)? loading,
    TResult? Function(PointsLoaded value)? loaded,
    TResult? Function(PointsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PointsInitial value)? initial,
    TResult Function(PointsLoading value)? loading,
    TResult Function(PointsLoaded value)? loaded,
    TResult Function(PointsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PointsError implements PointsState {
  const factory PointsError(final String message) = _$PointsErrorImpl;

  String get message;

  /// Create a copy of PointsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsErrorImplCopyWith<_$PointsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
