import '../../data/models/ai_chat_models.dart';

class AiChatState {
  final List<ChatMessageModel> messages;
  final String? threadId;
  final bool isLoading;
  final bool isConfirming;
  final String? errorMessage;

  const AiChatState({
    this.messages = const [],
    this.threadId,
    this.isLoading = false,
    this.isConfirming = false,
    this.errorMessage,
  });

  AiChatState copyWith({
    List<ChatMessageModel>? messages,
    String? threadId,
    bool? isLoading,
    bool? isConfirming,
    String? errorMessage,
  }) {
    return AiChatState(
      messages: messages ?? this.messages,
      threadId: threadId ?? this.threadId,
      isLoading: isLoading ?? this.isLoading,
      isConfirming: isConfirming ?? this.isConfirming,
      errorMessage: errorMessage,
    );
  }
}
