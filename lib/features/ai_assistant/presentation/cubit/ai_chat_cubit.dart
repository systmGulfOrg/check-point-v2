import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/ai_chat_models.dart';
import '../../data/repos/ai_assistant_repo.dart';
import 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  AiChatCubit({required this.aiRepo}) : super(const AiChatState.initial());

  final AiAssistantRepo aiRepo;

  final List<AiChatMessageItem> _messages = [];
  String? _conversationId;

  List<AiChatMessageItem> get messages => List.unmodifiable(_messages);

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = AiChatMessageItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    emit(AiChatState.loading(messages: List.from(_messages)));

    final result = await aiRepo.sendChatMessage(
      message: text.trim(),
      conversationId: _conversationId,
    );

    result.when(
      success: (response) {
        _conversationId = response.conversationId ?? _conversationId;
        final botMessage = AiChatMessageItem(
          id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
          text: response.response,
          isUser: false,
          timestamp: DateTime.now(),
          suggestedActions: response.suggestedActions,
        );
        _messages.add(botMessage);
        emit(
          AiChatState.success(
            messages: List.from(_messages),
            conversationId: _conversationId,
            currentSuggestions: response.suggestedActions,
          ),
        );
      },
      failure: (failure) {
        emit(
          AiChatState.error(
            messageKey: failure.messageKey,
            messages: List.from(_messages),
          ),
        );
      },
    );
  }

  void clearChat() {
    _messages.clear();
    _conversationId = null;
    emit(const AiChatState.initial());
  }
}
