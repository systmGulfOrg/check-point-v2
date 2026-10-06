// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AiChatState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<AiChatMessageItem> messages) loading,
    required TResult Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )
    success,
    required TResult Function(
      String messageKey,
      List<AiChatMessageItem> messages,
    )
    error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<AiChatMessageItem> messages)? loading,
    TResult? Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )?
    success,
    TResult? Function(String messageKey, List<AiChatMessageItem> messages)?
    error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<AiChatMessageItem> messages)? loading,
    TResult Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )?
    success,
    TResult Function(String messageKey, List<AiChatMessageItem> messages)?
    error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AiChatInitial value) initial,
    required TResult Function(AiChatLoading value) loading,
    required TResult Function(AiChatSuccess value) success,
    required TResult Function(AiChatError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AiChatInitial value)? initial,
    TResult? Function(AiChatLoading value)? loading,
    TResult? Function(AiChatSuccess value)? success,
    TResult? Function(AiChatError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AiChatInitial value)? initial,
    TResult Function(AiChatLoading value)? loading,
    TResult Function(AiChatSuccess value)? success,
    TResult Function(AiChatError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiChatStateCopyWith<$Res> {
  factory $AiChatStateCopyWith(
    AiChatState value,
    $Res Function(AiChatState) then,
  ) = _$AiChatStateCopyWithImpl<$Res, AiChatState>;
}

/// @nodoc
class _$AiChatStateCopyWithImpl<$Res, $Val extends AiChatState>
    implements $AiChatStateCopyWith<$Res> {
  _$AiChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AiChatInitialImplCopyWith<$Res> {
  factory _$$AiChatInitialImplCopyWith(
    _$AiChatInitialImpl value,
    $Res Function(_$AiChatInitialImpl) then,
  ) = __$$AiChatInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AiChatInitialImplCopyWithImpl<$Res>
    extends _$AiChatStateCopyWithImpl<$Res, _$AiChatInitialImpl>
    implements _$$AiChatInitialImplCopyWith<$Res> {
  __$$AiChatInitialImplCopyWithImpl(
    _$AiChatInitialImpl _value,
    $Res Function(_$AiChatInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AiChatInitialImpl implements AiChatInitial {
  const _$AiChatInitialImpl();

  @override
  String toString() {
    return 'AiChatState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AiChatInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<AiChatMessageItem> messages) loading,
    required TResult Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )
    success,
    required TResult Function(
      String messageKey,
      List<AiChatMessageItem> messages,
    )
    error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<AiChatMessageItem> messages)? loading,
    TResult? Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )?
    success,
    TResult? Function(String messageKey, List<AiChatMessageItem> messages)?
    error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<AiChatMessageItem> messages)? loading,
    TResult Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )?
    success,
    TResult Function(String messageKey, List<AiChatMessageItem> messages)?
    error,
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
    required TResult Function(AiChatInitial value) initial,
    required TResult Function(AiChatLoading value) loading,
    required TResult Function(AiChatSuccess value) success,
    required TResult Function(AiChatError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AiChatInitial value)? initial,
    TResult? Function(AiChatLoading value)? loading,
    TResult? Function(AiChatSuccess value)? success,
    TResult? Function(AiChatError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AiChatInitial value)? initial,
    TResult Function(AiChatLoading value)? loading,
    TResult Function(AiChatSuccess value)? success,
    TResult Function(AiChatError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AiChatInitial implements AiChatState {
  const factory AiChatInitial() = _$AiChatInitialImpl;
}

/// @nodoc
abstract class _$$AiChatLoadingImplCopyWith<$Res> {
  factory _$$AiChatLoadingImplCopyWith(
    _$AiChatLoadingImpl value,
    $Res Function(_$AiChatLoadingImpl) then,
  ) = __$$AiChatLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<AiChatMessageItem> messages});
}

/// @nodoc
class __$$AiChatLoadingImplCopyWithImpl<$Res>
    extends _$AiChatStateCopyWithImpl<$Res, _$AiChatLoadingImpl>
    implements _$$AiChatLoadingImplCopyWith<$Res> {
  __$$AiChatLoadingImplCopyWithImpl(
    _$AiChatLoadingImpl _value,
    $Res Function(_$AiChatLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messages = null}) {
    return _then(
      _$AiChatLoadingImpl(
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<AiChatMessageItem>,
      ),
    );
  }
}

/// @nodoc

class _$AiChatLoadingImpl implements AiChatLoading {
  const _$AiChatLoadingImpl({final List<AiChatMessageItem> messages = const []})
    : _messages = messages;

  final List<AiChatMessageItem> _messages;
  @override
  @JsonKey()
  List<AiChatMessageItem> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'AiChatState.loading(messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChatLoadingImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChatLoadingImplCopyWith<_$AiChatLoadingImpl> get copyWith =>
      __$$AiChatLoadingImplCopyWithImpl<_$AiChatLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<AiChatMessageItem> messages) loading,
    required TResult Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )
    success,
    required TResult Function(
      String messageKey,
      List<AiChatMessageItem> messages,
    )
    error,
  }) {
    return loading(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<AiChatMessageItem> messages)? loading,
    TResult? Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )?
    success,
    TResult? Function(String messageKey, List<AiChatMessageItem> messages)?
    error,
  }) {
    return loading?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<AiChatMessageItem> messages)? loading,
    TResult Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )?
    success,
    TResult Function(String messageKey, List<AiChatMessageItem> messages)?
    error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AiChatInitial value) initial,
    required TResult Function(AiChatLoading value) loading,
    required TResult Function(AiChatSuccess value) success,
    required TResult Function(AiChatError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AiChatInitial value)? initial,
    TResult? Function(AiChatLoading value)? loading,
    TResult? Function(AiChatSuccess value)? success,
    TResult? Function(AiChatError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AiChatInitial value)? initial,
    TResult Function(AiChatLoading value)? loading,
    TResult Function(AiChatSuccess value)? success,
    TResult Function(AiChatError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AiChatLoading implements AiChatState {
  const factory AiChatLoading({final List<AiChatMessageItem> messages}) =
      _$AiChatLoadingImpl;

  List<AiChatMessageItem> get messages;

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChatLoadingImplCopyWith<_$AiChatLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AiChatSuccessImplCopyWith<$Res> {
  factory _$$AiChatSuccessImplCopyWith(
    _$AiChatSuccessImpl value,
    $Res Function(_$AiChatSuccessImpl) then,
  ) = __$$AiChatSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<AiChatMessageItem> messages,
    String? conversationId,
    List<String> currentSuggestions,
  });
}

/// @nodoc
class __$$AiChatSuccessImplCopyWithImpl<$Res>
    extends _$AiChatStateCopyWithImpl<$Res, _$AiChatSuccessImpl>
    implements _$$AiChatSuccessImplCopyWith<$Res> {
  __$$AiChatSuccessImplCopyWithImpl(
    _$AiChatSuccessImpl _value,
    $Res Function(_$AiChatSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? conversationId = freezed,
    Object? currentSuggestions = null,
  }) {
    return _then(
      _$AiChatSuccessImpl(
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<AiChatMessageItem>,
        conversationId: freezed == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentSuggestions: null == currentSuggestions
            ? _value._currentSuggestions
            : currentSuggestions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$AiChatSuccessImpl implements AiChatSuccess {
  const _$AiChatSuccessImpl({
    required final List<AiChatMessageItem> messages,
    this.conversationId,
    final List<String> currentSuggestions = const [],
  }) : _messages = messages,
       _currentSuggestions = currentSuggestions;

  final List<AiChatMessageItem> _messages;
  @override
  List<AiChatMessageItem> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final String? conversationId;
  final List<String> _currentSuggestions;
  @override
  @JsonKey()
  List<String> get currentSuggestions {
    if (_currentSuggestions is EqualUnmodifiableListView)
      return _currentSuggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentSuggestions);
  }

  @override
  String toString() {
    return 'AiChatState.success(messages: $messages, conversationId: $conversationId, currentSuggestions: $currentSuggestions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChatSuccessImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            const DeepCollectionEquality().equals(
              other._currentSuggestions,
              _currentSuggestions,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_messages),
    conversationId,
    const DeepCollectionEquality().hash(_currentSuggestions),
  );

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChatSuccessImplCopyWith<_$AiChatSuccessImpl> get copyWith =>
      __$$AiChatSuccessImplCopyWithImpl<_$AiChatSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<AiChatMessageItem> messages) loading,
    required TResult Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )
    success,
    required TResult Function(
      String messageKey,
      List<AiChatMessageItem> messages,
    )
    error,
  }) {
    return success(messages, conversationId, currentSuggestions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<AiChatMessageItem> messages)? loading,
    TResult? Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )?
    success,
    TResult? Function(String messageKey, List<AiChatMessageItem> messages)?
    error,
  }) {
    return success?.call(messages, conversationId, currentSuggestions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<AiChatMessageItem> messages)? loading,
    TResult Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )?
    success,
    TResult Function(String messageKey, List<AiChatMessageItem> messages)?
    error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(messages, conversationId, currentSuggestions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AiChatInitial value) initial,
    required TResult Function(AiChatLoading value) loading,
    required TResult Function(AiChatSuccess value) success,
    required TResult Function(AiChatError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AiChatInitial value)? initial,
    TResult? Function(AiChatLoading value)? loading,
    TResult? Function(AiChatSuccess value)? success,
    TResult? Function(AiChatError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AiChatInitial value)? initial,
    TResult Function(AiChatLoading value)? loading,
    TResult Function(AiChatSuccess value)? success,
    TResult Function(AiChatError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AiChatSuccess implements AiChatState {
  const factory AiChatSuccess({
    required final List<AiChatMessageItem> messages,
    final String? conversationId,
    final List<String> currentSuggestions,
  }) = _$AiChatSuccessImpl;

  List<AiChatMessageItem> get messages;
  String? get conversationId;
  List<String> get currentSuggestions;

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChatSuccessImplCopyWith<_$AiChatSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AiChatErrorImplCopyWith<$Res> {
  factory _$$AiChatErrorImplCopyWith(
    _$AiChatErrorImpl value,
    $Res Function(_$AiChatErrorImpl) then,
  ) = __$$AiChatErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey, List<AiChatMessageItem> messages});
}

/// @nodoc
class __$$AiChatErrorImplCopyWithImpl<$Res>
    extends _$AiChatStateCopyWithImpl<$Res, _$AiChatErrorImpl>
    implements _$$AiChatErrorImplCopyWith<$Res> {
  __$$AiChatErrorImplCopyWithImpl(
    _$AiChatErrorImpl _value,
    $Res Function(_$AiChatErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null, Object? messages = null}) {
    return _then(
      _$AiChatErrorImpl(
        messageKey: null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<AiChatMessageItem>,
      ),
    );
  }
}

/// @nodoc

class _$AiChatErrorImpl implements AiChatError {
  const _$AiChatErrorImpl({
    required this.messageKey,
    final List<AiChatMessageItem> messages = const [],
  }) : _messages = messages;

  @override
  final String messageKey;
  final List<AiChatMessageItem> _messages;
  @override
  @JsonKey()
  List<AiChatMessageItem> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'AiChatState.error(messageKey: $messageKey, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChatErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    messageKey,
    const DeepCollectionEquality().hash(_messages),
  );

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChatErrorImplCopyWith<_$AiChatErrorImpl> get copyWith =>
      __$$AiChatErrorImplCopyWithImpl<_$AiChatErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<AiChatMessageItem> messages) loading,
    required TResult Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )
    success,
    required TResult Function(
      String messageKey,
      List<AiChatMessageItem> messages,
    )
    error,
  }) {
    return error(messageKey, messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<AiChatMessageItem> messages)? loading,
    TResult? Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )?
    success,
    TResult? Function(String messageKey, List<AiChatMessageItem> messages)?
    error,
  }) {
    return error?.call(messageKey, messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<AiChatMessageItem> messages)? loading,
    TResult Function(
      List<AiChatMessageItem> messages,
      String? conversationId,
      List<String> currentSuggestions,
    )?
    success,
    TResult Function(String messageKey, List<AiChatMessageItem> messages)?
    error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(messageKey, messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AiChatInitial value) initial,
    required TResult Function(AiChatLoading value) loading,
    required TResult Function(AiChatSuccess value) success,
    required TResult Function(AiChatError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AiChatInitial value)? initial,
    TResult? Function(AiChatLoading value)? loading,
    TResult? Function(AiChatSuccess value)? success,
    TResult? Function(AiChatError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AiChatInitial value)? initial,
    TResult Function(AiChatLoading value)? loading,
    TResult Function(AiChatSuccess value)? success,
    TResult Function(AiChatError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AiChatError implements AiChatState {
  const factory AiChatError({
    required final String messageKey,
    final List<AiChatMessageItem> messages,
  }) = _$AiChatErrorImpl;

  String get messageKey;
  List<AiChatMessageItem> get messages;

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChatErrorImplCopyWith<_$AiChatErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
