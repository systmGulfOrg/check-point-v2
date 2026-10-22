import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import '../../data/models/ai_chat_models.dart';
import '../../data/repos/ai_repo.dart';
import 'ai_chat_state.dart';

class AiChatCubit extends SafeCubit<AiChatState> {
  final AiRepo repo;

  AiChatCubit({required this.repo}) : super(const AiChatState());

  void startNewChat() {
    safeEmit(const AiChatState(
      messages: [],
      threadId: null,
      isLoading: false,
    ));
  }

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.isLoading) return;

    final userMsg = ChatMessageModel(
      id: 'msg_u_${DateTime.now().millisecondsSinceEpoch}',
      role: 'user',
      text: trimmed,
      createdAt: DateTime.now(),
    );

    final updatedMessages = [...state.messages, userMsg];
    safeEmit(state.copyWith(
      messages: updatedMessages,
      isLoading: true,
      errorMessage: null,
    ));

    final result = await repo.sendMessage(
      trimmed,
      threadId: state.threadId,
    );

    result.when(
      success: (data) {
        final botMsg = ChatMessageModel(
          id: 'msg_a_${DateTime.now().millisecondsSinceEpoch}',
          role: 'assistant',
          text: data.response,
          targetAgents: data.targetAgents,
          pendingAction: data.pendingAction,
          createdAt: DateTime.now(),
        );

        safeEmit(state.copyWith(
          messages: [...state.messages, botMsg],
          threadId: data.threadId.isNotEmpty ? data.threadId : state.threadId,
          isLoading: false,
        ));
      },
      failure: (failure) {
        final errorMsg = ChatMessageModel(
          id: 'msg_err_${DateTime.now().millisecondsSinceEpoch}',
          role: 'assistant',
          text: failure.messageKey.isNotEmpty
              ? failure.messageKey
              : 'حدث خطأ أثناء معالجة الطلب، يرجى إعادة المحاولة.',
          createdAt: DateTime.now(),
        );

        safeEmit(state.copyWith(
          messages: [...state.messages, errorMsg],
          isLoading: false,
          errorMessage: failure.messageKey,
        ));
      },
    );
  }

  Future<void> confirmAction(String messageId, String actionId) async {
    if (state.isConfirming) return;

    safeEmit(state.copyWith(isConfirming: true));

    final result = await repo.confirmAction(actionId, confirmed: true);

    result.when(
      success: (msg) {
        final updated = state.messages.map((m) {
          if (m.id == messageId) {
            return m.copyWith(
              isConfirmed: true,
              text: '${m.text}\n\n✅ **$msg**',
            );
          }
          return m;
        }).toList();

        safeEmit(state.copyWith(
          messages: updated,
          isConfirming: false,
        ));
      },
      failure: (failure) {
        safeEmit(state.copyWith(
          isConfirming: false,
          errorMessage: failure.messageKey,
        ));
      },
    );
  }

  void cancelAction(String messageId) {
    final updated = state.messages.map((m) {
      if (m.id == messageId) {
        return m.copyWith(
          isConfirmed: true,
          text: '${m.text}\n\n❌ تم إلغاء الإجراء.',
        );
      }
      return m;
    }).toList();

    safeEmit(state.copyWith(messages: updated));
  }
}
