// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_chat_models.freezed.dart';
part 'ai_chat_models.g.dart';

@freezed
class AiChatRequestBody with _$AiChatRequestBody {
  const factory AiChatRequestBody({
    required String message,
    @JsonKey(name: 'conversationId') String? conversationId,
  }) = _AiChatRequestBody;

  factory AiChatRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AiChatRequestBodyFromJson(json);
}

@freezed
class AiChatResponseModel with _$AiChatResponseModel {
  const factory AiChatResponseModel({
    required String response,
    @JsonKey(name: 'conversationId') String? conversationId,
    @JsonKey(name: 'suggestedActions') @Default([]) List<String> suggestedActions,
  }) = _AiChatResponseModel;

  factory AiChatResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AiChatResponseModelFromJson(json);
}

@freezed
class AiChatMessageItem with _$AiChatMessageItem {
  const factory AiChatMessageItem({
    required String id,
    required String text,
    required bool isUser,
    required DateTime timestamp,
    @Default([]) List<String> suggestedActions,
  }) = _AiChatMessageItem;

  factory AiChatMessageItem.fromJson(Map<String, dynamic> json) =>
      _$AiChatMessageItemFromJson(json);
}
