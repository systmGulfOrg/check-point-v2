// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_chat_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AiChatRequestBody _$AiChatRequestBodyFromJson(Map<String, dynamic> json) {
  return _AiChatRequestBody.fromJson(json);
}

/// @nodoc
mixin _$AiChatRequestBody {
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversationId')
  String? get conversationId => throw _privateConstructorUsedError;

  /// Serializes this AiChatRequestBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiChatRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiChatRequestBodyCopyWith<AiChatRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiChatRequestBodyCopyWith<$Res> {
  factory $AiChatRequestBodyCopyWith(
    AiChatRequestBody value,
    $Res Function(AiChatRequestBody) then,
  ) = _$AiChatRequestBodyCopyWithImpl<$Res, AiChatRequestBody>;
  @useResult
  $Res call({
    String message,
    @JsonKey(name: 'conversationId') String? conversationId,
  });
}

/// @nodoc
class _$AiChatRequestBodyCopyWithImpl<$Res, $Val extends AiChatRequestBody>
    implements $AiChatRequestBodyCopyWith<$Res> {
  _$AiChatRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiChatRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? conversationId = freezed}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            conversationId: freezed == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiChatRequestBodyImplCopyWith<$Res>
    implements $AiChatRequestBodyCopyWith<$Res> {
  factory _$$AiChatRequestBodyImplCopyWith(
    _$AiChatRequestBodyImpl value,
    $Res Function(_$AiChatRequestBodyImpl) then,
  ) = __$$AiChatRequestBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    @JsonKey(name: 'conversationId') String? conversationId,
  });
}

/// @nodoc
class __$$AiChatRequestBodyImplCopyWithImpl<$Res>
    extends _$AiChatRequestBodyCopyWithImpl<$Res, _$AiChatRequestBodyImpl>
    implements _$$AiChatRequestBodyImplCopyWith<$Res> {
  __$$AiChatRequestBodyImplCopyWithImpl(
    _$AiChatRequestBodyImpl _value,
    $Res Function(_$AiChatRequestBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiChatRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? conversationId = freezed}) {
    return _then(
      _$AiChatRequestBodyImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        conversationId: freezed == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiChatRequestBodyImpl implements _AiChatRequestBody {
  const _$AiChatRequestBodyImpl({
    required this.message,
    @JsonKey(name: 'conversationId') this.conversationId,
  });

  factory _$AiChatRequestBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiChatRequestBodyImplFromJson(json);

  @override
  final String message;
  @override
  @JsonKey(name: 'conversationId')
  final String? conversationId;

  @override
  String toString() {
    return 'AiChatRequestBody(message: $message, conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChatRequestBodyImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, conversationId);

  /// Create a copy of AiChatRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChatRequestBodyImplCopyWith<_$AiChatRequestBodyImpl> get copyWith =>
      __$$AiChatRequestBodyImplCopyWithImpl<_$AiChatRequestBodyImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AiChatRequestBodyImplToJson(this);
  }
}

abstract class _AiChatRequestBody implements AiChatRequestBody {
  const factory _AiChatRequestBody({
    required final String message,
    @JsonKey(name: 'conversationId') final String? conversationId,
  }) = _$AiChatRequestBodyImpl;

  factory _AiChatRequestBody.fromJson(Map<String, dynamic> json) =
      _$AiChatRequestBodyImpl.fromJson;

  @override
  String get message;
  @override
  @JsonKey(name: 'conversationId')
  String? get conversationId;

  /// Create a copy of AiChatRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChatRequestBodyImplCopyWith<_$AiChatRequestBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AiChatResponseModel _$AiChatResponseModelFromJson(Map<String, dynamic> json) {
  return _AiChatResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AiChatResponseModel {
  String get response => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversationId')
  String? get conversationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'suggestedActions')
  List<String> get suggestedActions => throw _privateConstructorUsedError;

  /// Serializes this AiChatResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiChatResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiChatResponseModelCopyWith<AiChatResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiChatResponseModelCopyWith<$Res> {
  factory $AiChatResponseModelCopyWith(
    AiChatResponseModel value,
    $Res Function(AiChatResponseModel) then,
  ) = _$AiChatResponseModelCopyWithImpl<$Res, AiChatResponseModel>;
  @useResult
  $Res call({
    String response,
    @JsonKey(name: 'conversationId') String? conversationId,
    @JsonKey(name: 'suggestedActions') List<String> suggestedActions,
  });
}

/// @nodoc
class _$AiChatResponseModelCopyWithImpl<$Res, $Val extends AiChatResponseModel>
    implements $AiChatResponseModelCopyWith<$Res> {
  _$AiChatResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiChatResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
    Object? conversationId = freezed,
    Object? suggestedActions = null,
  }) {
    return _then(
      _value.copyWith(
            response: null == response
                ? _value.response
                : response // ignore: cast_nullable_to_non_nullable
                      as String,
            conversationId: freezed == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            suggestedActions: null == suggestedActions
                ? _value.suggestedActions
                : suggestedActions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiChatResponseModelImplCopyWith<$Res>
    implements $AiChatResponseModelCopyWith<$Res> {
  factory _$$AiChatResponseModelImplCopyWith(
    _$AiChatResponseModelImpl value,
    $Res Function(_$AiChatResponseModelImpl) then,
  ) = __$$AiChatResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String response,
    @JsonKey(name: 'conversationId') String? conversationId,
    @JsonKey(name: 'suggestedActions') List<String> suggestedActions,
  });
}

/// @nodoc
class __$$AiChatResponseModelImplCopyWithImpl<$Res>
    extends _$AiChatResponseModelCopyWithImpl<$Res, _$AiChatResponseModelImpl>
    implements _$$AiChatResponseModelImplCopyWith<$Res> {
  __$$AiChatResponseModelImplCopyWithImpl(
    _$AiChatResponseModelImpl _value,
    $Res Function(_$AiChatResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiChatResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
    Object? conversationId = freezed,
    Object? suggestedActions = null,
  }) {
    return _then(
      _$AiChatResponseModelImpl(
        response: null == response
            ? _value.response
            : response // ignore: cast_nullable_to_non_nullable
                  as String,
        conversationId: freezed == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        suggestedActions: null == suggestedActions
            ? _value._suggestedActions
            : suggestedActions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiChatResponseModelImpl implements _AiChatResponseModel {
  const _$AiChatResponseModelImpl({
    required this.response,
    @JsonKey(name: 'conversationId') this.conversationId,
    @JsonKey(name: 'suggestedActions')
    final List<String> suggestedActions = const [],
  }) : _suggestedActions = suggestedActions;

  factory _$AiChatResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiChatResponseModelImplFromJson(json);

  @override
  final String response;
  @override
  @JsonKey(name: 'conversationId')
  final String? conversationId;
  final List<String> _suggestedActions;
  @override
  @JsonKey(name: 'suggestedActions')
  List<String> get suggestedActions {
    if (_suggestedActions is EqualUnmodifiableListView)
      return _suggestedActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestedActions);
  }

  @override
  String toString() {
    return 'AiChatResponseModel(response: $response, conversationId: $conversationId, suggestedActions: $suggestedActions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChatResponseModelImpl &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            const DeepCollectionEquality().equals(
              other._suggestedActions,
              _suggestedActions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    response,
    conversationId,
    const DeepCollectionEquality().hash(_suggestedActions),
  );

  /// Create a copy of AiChatResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChatResponseModelImplCopyWith<_$AiChatResponseModelImpl> get copyWith =>
      __$$AiChatResponseModelImplCopyWithImpl<_$AiChatResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AiChatResponseModelImplToJson(this);
  }
}

abstract class _AiChatResponseModel implements AiChatResponseModel {
  const factory _AiChatResponseModel({
    required final String response,
    @JsonKey(name: 'conversationId') final String? conversationId,
    @JsonKey(name: 'suggestedActions') final List<String> suggestedActions,
  }) = _$AiChatResponseModelImpl;

  factory _AiChatResponseModel.fromJson(Map<String, dynamic> json) =
      _$AiChatResponseModelImpl.fromJson;

  @override
  String get response;
  @override
  @JsonKey(name: 'conversationId')
  String? get conversationId;
  @override
  @JsonKey(name: 'suggestedActions')
  List<String> get suggestedActions;

  /// Create a copy of AiChatResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChatResponseModelImplCopyWith<_$AiChatResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AiChatMessageItem _$AiChatMessageItemFromJson(Map<String, dynamic> json) {
  return _AiChatMessageItem.fromJson(json);
}

/// @nodoc
mixin _$AiChatMessageItem {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  bool get isUser => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<String> get suggestedActions => throw _privateConstructorUsedError;

  /// Serializes this AiChatMessageItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiChatMessageItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiChatMessageItemCopyWith<AiChatMessageItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiChatMessageItemCopyWith<$Res> {
  factory $AiChatMessageItemCopyWith(
    AiChatMessageItem value,
    $Res Function(AiChatMessageItem) then,
  ) = _$AiChatMessageItemCopyWithImpl<$Res, AiChatMessageItem>;
  @useResult
  $Res call({
    String id,
    String text,
    bool isUser,
    DateTime timestamp,
    List<String> suggestedActions,
  });
}

/// @nodoc
class _$AiChatMessageItemCopyWithImpl<$Res, $Val extends AiChatMessageItem>
    implements $AiChatMessageItemCopyWith<$Res> {
  _$AiChatMessageItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiChatMessageItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? isUser = null,
    Object? timestamp = null,
    Object? suggestedActions = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            isUser: null == isUser
                ? _value.isUser
                : isUser // ignore: cast_nullable_to_non_nullable
                      as bool,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            suggestedActions: null == suggestedActions
                ? _value.suggestedActions
                : suggestedActions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiChatMessageItemImplCopyWith<$Res>
    implements $AiChatMessageItemCopyWith<$Res> {
  factory _$$AiChatMessageItemImplCopyWith(
    _$AiChatMessageItemImpl value,
    $Res Function(_$AiChatMessageItemImpl) then,
  ) = __$$AiChatMessageItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String text,
    bool isUser,
    DateTime timestamp,
    List<String> suggestedActions,
  });
}

/// @nodoc
class __$$AiChatMessageItemImplCopyWithImpl<$Res>
    extends _$AiChatMessageItemCopyWithImpl<$Res, _$AiChatMessageItemImpl>
    implements _$$AiChatMessageItemImplCopyWith<$Res> {
  __$$AiChatMessageItemImplCopyWithImpl(
    _$AiChatMessageItemImpl _value,
    $Res Function(_$AiChatMessageItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiChatMessageItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? isUser = null,
    Object? timestamp = null,
    Object? suggestedActions = null,
  }) {
    return _then(
      _$AiChatMessageItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        isUser: null == isUser
            ? _value.isUser
            : isUser // ignore: cast_nullable_to_non_nullable
                  as bool,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        suggestedActions: null == suggestedActions
            ? _value._suggestedActions
            : suggestedActions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiChatMessageItemImpl implements _AiChatMessageItem {
  const _$AiChatMessageItemImpl({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    final List<String> suggestedActions = const [],
  }) : _suggestedActions = suggestedActions;

  factory _$AiChatMessageItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiChatMessageItemImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final bool isUser;
  @override
  final DateTime timestamp;
  final List<String> _suggestedActions;
  @override
  @JsonKey()
  List<String> get suggestedActions {
    if (_suggestedActions is EqualUnmodifiableListView)
      return _suggestedActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestedActions);
  }

  @override
  String toString() {
    return 'AiChatMessageItem(id: $id, text: $text, isUser: $isUser, timestamp: $timestamp, suggestedActions: $suggestedActions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChatMessageItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isUser, isUser) || other.isUser == isUser) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(
              other._suggestedActions,
              _suggestedActions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    isUser,
    timestamp,
    const DeepCollectionEquality().hash(_suggestedActions),
  );

  /// Create a copy of AiChatMessageItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChatMessageItemImplCopyWith<_$AiChatMessageItemImpl> get copyWith =>
      __$$AiChatMessageItemImplCopyWithImpl<_$AiChatMessageItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AiChatMessageItemImplToJson(this);
  }
}

abstract class _AiChatMessageItem implements AiChatMessageItem {
  const factory _AiChatMessageItem({
    required final String id,
    required final String text,
    required final bool isUser,
    required final DateTime timestamp,
    final List<String> suggestedActions,
  }) = _$AiChatMessageItemImpl;

  factory _AiChatMessageItem.fromJson(Map<String, dynamic> json) =
      _$AiChatMessageItemImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  bool get isUser;
  @override
  DateTime get timestamp;
  @override
  List<String> get suggestedActions;

  /// Create a copy of AiChatMessageItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChatMessageItemImplCopyWith<_$AiChatMessageItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
