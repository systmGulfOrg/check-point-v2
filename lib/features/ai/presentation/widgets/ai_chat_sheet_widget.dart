import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import '../cubit/ai_chat_cubit.dart';
import '../cubit/ai_chat_state.dart';
import 'ai_active_agents_bar_widget.dart';
import 'ai_chat_empty_state_widget.dart';
import 'ai_chat_input_bar_widget.dart';
import 'ai_chat_top_bar_widget.dart';
import 'ai_chat_typing_indicator_widget.dart';
import 'ai_message_bubble_widget.dart';

void showAiChatSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (sheetContext) => BlocProvider<AiChatCubit>(
      create: (_) => sl<AiChatCubit>(),
      child: const AiChatSheetWidget(),
    ),
  );
}

class AiChatSheetWidget extends StatefulWidget {
  const AiChatSheetWidget({super.key});

  @override
  State<AiChatSheetWidget> createState() => _AiChatSheetWidgetState();
}

class _AiChatSheetWidgetState extends State<AiChatSheetWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animController;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage([String? textToSend]) {
    final text = textToSend ?? _controller.text;
    if (text.trim().isEmpty) return;

    context.read<AiChatCubit>().sendMessage(text);
    _controller.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final sheetHeight = MediaQuery.sizeOf(context).height * 0.88;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Container(
          height: sheetHeight,
          decoration: const BoxDecoration(
            color: Color(0xFFF8FAFC),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Column(
              children: [
                const AiChatTopBarWidget(),
                const AiActiveAgentsBarWidget(),
                Expanded(
                  child: BlocConsumer<AiChatCubit, AiChatState>(
                    listener: (context, state) {
                      _scrollToBottom();
                    },
                    builder: (context, state) {
                      if (state.messages.isEmpty) {
                        return AiChatEmptyStateWidget(
                          onSelectPrompt: _sendMessage,
                        );
                      }

                      return ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        itemCount:
                            state.messages.length + (state.isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == state.messages.length &&
                              state.isLoading) {
                            return const AiChatTypingIndicatorWidget();
                          }

                          final msg = state.messages[index];
                          return AiMessageBubbleWidget(
                            message: msg,
                            isConfirming: state.isConfirming,
                            onConfirmAction: () {
                              if (msg.pendingAction != null) {
                                final actionId = msg.pendingAction!.actionId;
                                context.read<AiChatCubit>().confirmAction(
                                  msg.id,
                                  actionId,
                                );
                              }
                            },
                            onCancelAction: () {
                              context.read<AiChatCubit>().cancelAction(msg.id);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: bottomInset),
                  child: AiChatInputBarWidget(
                    controller: _controller,
                    onSend: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
