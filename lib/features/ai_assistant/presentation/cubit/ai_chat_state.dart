import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/ai_chat_models.dart';

part 'ai_chat_state.freezed.dart';

@freezed
class AiChatState with _$AiChatState {
  const factory AiChatState.initial() = AiChatInitial;
  const factory AiChatState.loading({
    @Default([]) List<AiChatMessageItem> messages,
  }) = AiChatLoading;
  const factory AiChatState.success({
    required List<AiChatMessageItem> messages,
    String? conversationId,
    @Default([]) List<String> currentSuggestions,
  }) = AiChatSuccess;
  const factory AiChatState.error({
    required String messageKey,
    @Default([]) List<AiChatMessageItem> messages,
  }) = AiChatError;
}
