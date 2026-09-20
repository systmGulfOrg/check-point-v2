// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'projects_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProjectsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
    )
    success,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
    )?
    success,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
    )?
    success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsStateInitial value) initial,
    required TResult Function(ProjectsStateLoading value) loading,
    required TResult Function(ProjectsStateSuccess value) success,
    required TResult Function(ProjectsStateError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsStateInitial value)? initial,
    TResult? Function(ProjectsStateLoading value)? loading,
    TResult? Function(ProjectsStateSuccess value)? success,
    TResult? Function(ProjectsStateError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsStateInitial value)? initial,
    TResult Function(ProjectsStateLoading value)? loading,
    TResult Function(ProjectsStateSuccess value)? success,
    TResult Function(ProjectsStateError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectsStateCopyWith<$Res> {
  factory $ProjectsStateCopyWith(
    ProjectsState value,
    $Res Function(ProjectsState) then,
  ) = _$ProjectsStateCopyWithImpl<$Res, ProjectsState>;
}

/// @nodoc
class _$ProjectsStateCopyWithImpl<$Res, $Val extends ProjectsState>
    implements $ProjectsStateCopyWith<$Res> {
  _$ProjectsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProjectsStateInitialImplCopyWith<$Res> {
  factory _$$ProjectsStateInitialImplCopyWith(
    _$ProjectsStateInitialImpl value,
    $Res Function(_$ProjectsStateInitialImpl) then,
  ) = __$$ProjectsStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProjectsStateInitialImplCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsStateInitialImpl>
    implements _$$ProjectsStateInitialImplCopyWith<$Res> {
  __$$ProjectsStateInitialImplCopyWithImpl(
    _$ProjectsStateInitialImpl _value,
    $Res Function(_$ProjectsStateInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProjectsStateInitialImpl implements ProjectsStateInitial {
  const _$ProjectsStateInitialImpl();

  @override
  String toString() {
    return 'ProjectsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
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
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
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
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
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
    required TResult Function(ProjectsStateInitial value) initial,
    required TResult Function(ProjectsStateLoading value) loading,
    required TResult Function(ProjectsStateSuccess value) success,
    required TResult Function(ProjectsStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsStateInitial value)? initial,
    TResult? Function(ProjectsStateLoading value)? loading,
    TResult? Function(ProjectsStateSuccess value)? success,
    TResult? Function(ProjectsStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsStateInitial value)? initial,
    TResult Function(ProjectsStateLoading value)? loading,
    TResult Function(ProjectsStateSuccess value)? success,
    TResult Function(ProjectsStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ProjectsStateInitial implements ProjectsState {
  const factory ProjectsStateInitial() = _$ProjectsStateInitialImpl;
}

/// @nodoc
abstract class _$$ProjectsStateLoadingImplCopyWith<$Res> {
  factory _$$ProjectsStateLoadingImplCopyWith(
    _$ProjectsStateLoadingImpl value,
    $Res Function(_$ProjectsStateLoadingImpl) then,
  ) = __$$ProjectsStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProjectsStateLoadingImplCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsStateLoadingImpl>
    implements _$$ProjectsStateLoadingImplCopyWith<$Res> {
  __$$ProjectsStateLoadingImplCopyWithImpl(
    _$ProjectsStateLoadingImpl _value,
    $Res Function(_$ProjectsStateLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProjectsStateLoadingImpl implements ProjectsStateLoading {
  const _$ProjectsStateLoadingImpl();

  @override
  String toString() {
    return 'ProjectsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
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
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
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
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
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
    required TResult Function(ProjectsStateInitial value) initial,
    required TResult Function(ProjectsStateLoading value) loading,
    required TResult Function(ProjectsStateSuccess value) success,
    required TResult Function(ProjectsStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsStateInitial value)? initial,
    TResult? Function(ProjectsStateLoading value)? loading,
    TResult? Function(ProjectsStateSuccess value)? success,
    TResult? Function(ProjectsStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsStateInitial value)? initial,
    TResult Function(ProjectsStateLoading value)? loading,
    TResult Function(ProjectsStateSuccess value)? success,
    TResult Function(ProjectsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ProjectsStateLoading implements ProjectsState {
  const factory ProjectsStateLoading() = _$ProjectsStateLoadingImpl;
}

/// @nodoc
abstract class _$$ProjectsStateSuccessImplCopyWith<$Res> {
  factory _$$ProjectsStateSuccessImplCopyWith(
    _$ProjectsStateSuccessImpl value,
    $Res Function(_$ProjectsStateSuccessImpl) then,
  ) = __$$ProjectsStateSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<ProjectModel> projects,
    String? selectedProjectId,
    List<ProjectTaskModel> tasks,
    List<TaskAuditModel> audit,
  });
}

/// @nodoc
class __$$ProjectsStateSuccessImplCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsStateSuccessImpl>
    implements _$$ProjectsStateSuccessImplCopyWith<$Res> {
  __$$ProjectsStateSuccessImplCopyWithImpl(
    _$ProjectsStateSuccessImpl _value,
    $Res Function(_$ProjectsStateSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = null,
    Object? selectedProjectId = freezed,
    Object? tasks = null,
    Object? audit = null,
  }) {
    return _then(
      _$ProjectsStateSuccessImpl(
        projects: null == projects
            ? _value._projects
            : projects // ignore: cast_nullable_to_non_nullable
                  as List<ProjectModel>,
        selectedProjectId: freezed == selectedProjectId
            ? _value.selectedProjectId
            : selectedProjectId // ignore: cast_nullable_to_non_nullable
                  as String?,
        tasks: null == tasks
            ? _value._tasks
            : tasks // ignore: cast_nullable_to_non_nullable
                  as List<ProjectTaskModel>,
        audit: null == audit
            ? _value._audit
            : audit // ignore: cast_nullable_to_non_nullable
                  as List<TaskAuditModel>,
      ),
    );
  }
}

/// @nodoc

class _$ProjectsStateSuccessImpl implements ProjectsStateSuccess {
  const _$ProjectsStateSuccessImpl({
    required final List<ProjectModel> projects,
    this.selectedProjectId,
    final List<ProjectTaskModel> tasks = const <ProjectTaskModel>[],
    final List<TaskAuditModel> audit = const <TaskAuditModel>[],
  }) : _projects = projects,
       _tasks = tasks,
       _audit = audit;

  final List<ProjectModel> _projects;
  @override
  List<ProjectModel> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  final String? selectedProjectId;
  final List<ProjectTaskModel> _tasks;
  @override
  @JsonKey()
  List<ProjectTaskModel> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  final List<TaskAuditModel> _audit;
  @override
  @JsonKey()
  List<TaskAuditModel> get audit {
    if (_audit is EqualUnmodifiableListView) return _audit;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audit);
  }

  @override
  String toString() {
    return 'ProjectsState.success(projects: $projects, selectedProjectId: $selectedProjectId, tasks: $tasks, audit: $audit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsStateSuccessImpl &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            (identical(other.selectedProjectId, selectedProjectId) ||
                other.selectedProjectId == selectedProjectId) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            const DeepCollectionEquality().equals(other._audit, _audit));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_projects),
    selectedProjectId,
    const DeepCollectionEquality().hash(_tasks),
    const DeepCollectionEquality().hash(_audit),
  );

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsStateSuccessImplCopyWith<_$ProjectsStateSuccessImpl>
  get copyWith =>
      __$$ProjectsStateSuccessImplCopyWithImpl<_$ProjectsStateSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
    )
    success,
    required TResult Function(String messageKey) error,
  }) {
    return success(projects, selectedProjectId, tasks, audit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
    )?
    success,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call(projects, selectedProjectId, tasks, audit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
    )?
    success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(projects, selectedProjectId, tasks, audit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsStateInitial value) initial,
    required TResult Function(ProjectsStateLoading value) loading,
    required TResult Function(ProjectsStateSuccess value) success,
    required TResult Function(ProjectsStateError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsStateInitial value)? initial,
    TResult? Function(ProjectsStateLoading value)? loading,
    TResult? Function(ProjectsStateSuccess value)? success,
    TResult? Function(ProjectsStateError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsStateInitial value)? initial,
    TResult Function(ProjectsStateLoading value)? loading,
    TResult Function(ProjectsStateSuccess value)? success,
    TResult Function(ProjectsStateError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ProjectsStateSuccess implements ProjectsState {
  const factory ProjectsStateSuccess({
    required final List<ProjectModel> projects,
    final String? selectedProjectId,
    final List<ProjectTaskModel> tasks,
    final List<TaskAuditModel> audit,
  }) = _$ProjectsStateSuccessImpl;

  List<ProjectModel> get projects;
  String? get selectedProjectId;
  List<ProjectTaskModel> get tasks;
  List<TaskAuditModel> get audit;

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectsStateSuccessImplCopyWith<_$ProjectsStateSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProjectsStateErrorImplCopyWith<$Res> {
  factory _$$ProjectsStateErrorImplCopyWith(
    _$ProjectsStateErrorImpl value,
    $Res Function(_$ProjectsStateErrorImpl) then,
  ) = __$$ProjectsStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$ProjectsStateErrorImplCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsStateErrorImpl>
    implements _$$ProjectsStateErrorImplCopyWith<$Res> {
  __$$ProjectsStateErrorImplCopyWithImpl(
    _$ProjectsStateErrorImpl _value,
    $Res Function(_$ProjectsStateErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$ProjectsStateErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ProjectsStateErrorImpl implements ProjectsStateError {
  const _$ProjectsStateErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'ProjectsState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsStateErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsStateErrorImplCopyWith<_$ProjectsStateErrorImpl> get copyWith =>
      __$$ProjectsStateErrorImplCopyWithImpl<_$ProjectsStateErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
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
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
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
      List<ProjectModel> projects,
      String? selectedProjectId,
      List<ProjectTaskModel> tasks,
      List<TaskAuditModel> audit,
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
    required TResult Function(ProjectsStateInitial value) initial,
    required TResult Function(ProjectsStateLoading value) loading,
    required TResult Function(ProjectsStateSuccess value) success,
    required TResult Function(ProjectsStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsStateInitial value)? initial,
    TResult? Function(ProjectsStateLoading value)? loading,
    TResult? Function(ProjectsStateSuccess value)? success,
    TResult? Function(ProjectsStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsStateInitial value)? initial,
    TResult Function(ProjectsStateLoading value)? loading,
    TResult Function(ProjectsStateSuccess value)? success,
    TResult Function(ProjectsStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ProjectsStateError implements ProjectsState {
  const factory ProjectsStateError(final String messageKey) =
      _$ProjectsStateErrorImpl;

  String get messageKey;

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectsStateErrorImplCopyWith<_$ProjectsStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
