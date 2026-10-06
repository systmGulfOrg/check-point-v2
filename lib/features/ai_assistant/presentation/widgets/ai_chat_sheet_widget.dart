import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/widgets/custom_text_form_field.dart';
import '../cubit/ai_chat_cubit.dart';
import '../cubit/ai_chat_state.dart';
import '../../data/models/ai_chat_models.dart';

class AiChatSheetWidget extends StatefulWidget {
  const AiChatSheetWidget({super.key});

  @override
  State<AiChatSheetWidget> createState() => _AiChatSheetWidgetState();
}

class _AiChatSheetWidgetState extends State<AiChatSheetWidget> {
  late final TextEditingController _textController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _textController.dispose();
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

  void _handleSend() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    _textController.clear();
    context.read<AiChatCubit>().sendMessage(text);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.85.sh,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.brandPrimary.withValues(alpha: 0.1),
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    size: 20.r,
                    color: AppColors.brandPrimary,
                  ),
                ),
                wSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'المساعد الذكي (AI Assistant)',
                        style: AppTextStyles.font14Bold.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'استفسر عن الحضور، الإجازات، والسياسات',
                        style: AppTextStyles.font11Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Message list
          Expanded(
            child: BlocConsumer<AiChatCubit, AiChatState>(
              listener: (context, state) {
                _scrollToBottom();
              },
              builder: (context, state) {
                final messages = switch (state) {
                  AiChatInitial() => const <AiChatMessageItem>[],
                  AiChatLoading(:final messages) => messages,
                  AiChatSuccess(:final messages) => messages,
                  AiChatError(:final messages) => messages,
                  _ => const <AiChatMessageItem>[],
                };

                final isLoading = state is AiChatLoading;

                if (messages.isEmpty && !isLoading) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: 48.r,
                            color: AppColors.brandPrimary.withValues(alpha: 0.4),
                          ),
                          hSpace(12),
                          Text(
                            'مرحباً بك في المساعد الذكي!',
                            style: AppTextStyles.font16Bold,
                          ),
                          hSpace(6),
                          Text(
                            'يمكنك سؤالي عن أرصدة الإجازات، حالة الحضور، أو أي استفسار حول نظام العمل.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          hSpace(16),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            alignment: WrapAlignment.center,
                            children: [
                              _QuickPromptChip(
                                label: 'كم رصيد إجازاتي؟',
                                onTap: () => context
                                    .read<AiChatCubit>()
                                    .sendMessage('كم رصيد إجازاتي؟'),
                              ),
                              _QuickPromptChip(
                                label: 'هل تم تسجيل حضوري اليوم؟',
                                onTap: () => context
                                    .read<AiChatCubit>()
                                    .sendMessage('هل تم تسجيل حضوري اليوم؟'),
                              ),
                              _QuickPromptChip(
                                label: 'مواعيد العمل الرسمية',
                                onTap: () => context
                                    .read<AiChatCubit>()
                                    .sendMessage('ما هي مواعيد العمل الرسمية؟'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(16.r),
                  itemCount: messages.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == messages.length && isLoading) {
                      return const _AiTypingIndicator();
                    }
                    final msg = messages[index];
                    return _AiChatBubble(
                      message: msg,
                      onActionTap: (action) {
                        context.read<AiChatCubit>().sendMessage(action);
                      },
                    );
                  },
                );
              },
            ),
          ),

          // Input area
          Container(
            padding: EdgeInsets.only(
              left: 14.w,
              right: 14.w,
              top: 10.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 14.h,
            ),
            decoration: const BoxDecoration(
              color: AppColors.cardBackground,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: _textController,
                    hintText: 'اكتب استفسارك هنا...',
                  ),
                ),
                wSpace(8),
                IconButton.filled(
                  icon: const Icon(Icons.send_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.brandPrimary,
                  ),
                  onPressed: _handleSend,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AiChatBubble extends StatelessWidget {
  const _AiChatBubble({
    required this.message,
    required this.onActionTap,
  });

  final AiChatMessageItem message;
  final ValueChanged<String> onActionTap;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser) ...[
                CircleAvatar(
                  radius: 14.r,
                  backgroundColor: AppColors.brandPrimary.withValues(alpha: 0.1),
                  child: Icon(
                    Icons.auto_awesome,
                    size: 14.r,
                    color: AppColors.brandPrimary,
                  ),
                ),
                wSpace(8),
              ],
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: isUser
                        ? AppColors.brandPrimary
                        : AppColors.softBlueBackground,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text(
                    message.text,
                    style: AppTextStyles.font13Regular.copyWith(
                      color: isUser ? AppColors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (!isUser && message.suggestedActions.isNotEmpty) ...[
            hSpace(6),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: message.suggestedActions
                  .map(
                    (action) => ActionChip(
                      label: Text(
                        action,
                        style: AppTextStyles.font11Medium.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                      backgroundColor: AppColors.cardBackground,
                      side: BorderSide(
                        color: AppColors.brandPrimary.withValues(alpha: 0.3),
                      ),
                      onPressed: () => onActionTap(action),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _AiTypingIndicator extends StatelessWidget {
  const _AiTypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14.r,
            backgroundColor: AppColors.brandPrimary.withValues(alpha: 0.1),
            child: Icon(
              Icons.auto_awesome,
              size: 14.r,
              color: AppColors.brandPrimary,
            ),
          ),
          wSpace(8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.softBlueBackground,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 14.r,
                  height: 14.r,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
                wSpace(8),
                Text(
                  'جاري التفكير...',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickPromptChip extends StatelessWidget {
  const _QuickPromptChip({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label, style: AppTextStyles.font12Medium),
      backgroundColor: AppColors.softBlueBackground,
      side: BorderSide(color: AppColors.brandPrimary.withValues(alpha: 0.2)),
      onPressed: onTap,
    );
  }
}
