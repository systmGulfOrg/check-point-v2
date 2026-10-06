// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiChatRequestBodyImpl _$$AiChatRequestBodyImplFromJson(
  Map<String, dynamic> json,
) => _$AiChatRequestBodyImpl(
  message: json['message'] as String,
  conversationId: json['conversationId'] as String?,
);

Map<String, dynamic> _$$AiChatRequestBodyImplToJson(
  _$AiChatRequestBodyImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'conversationId': instance.conversationId,
};

_$AiChatResponseModelImpl _$$AiChatResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$AiChatResponseModelImpl(
  response: json['response'] as String,
  conversationId: json['conversationId'] as String?,
  suggestedActions:
      (json['suggestedActions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$AiChatResponseModelImplToJson(
  _$AiChatResponseModelImpl instance,
) => <String, dynamic>{
  'response': instance.response,
  'conversationId': instance.conversationId,
  'suggestedActions': instance.suggestedActions,
};

_$AiChatMessageItemImpl _$$AiChatMessageItemImplFromJson(
  Map<String, dynamic> json,
) => _$AiChatMessageItemImpl(
  id: json['id'] as String,
  text: json['text'] as String,
  isUser: json['isUser'] as bool,
  timestamp: DateTime.parse(json['timestamp'] as String),
  suggestedActions:
      (json['suggestedActions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$AiChatMessageItemImplToJson(
  _$AiChatMessageItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'isUser': instance.isUser,
  'timestamp': instance.timestamp.toIso8601String(),
  'suggestedActions': instance.suggestedActions,
};
