import 'package:flutter/material.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import '../../data/models/ai_chat_models.dart';
import 'ai_formatted_text_widget.dart';
import 'ai_pending_action_card_widget.dart';

class AiMessageBubbleWidget extends StatelessWidget {
  const AiMessageBubbleWidget({
    super.key,
    required this.message,
    this.onConfirmAction,
    this.onCancelAction,
    this.isConfirming = false,
  });

  final ChatMessageModel message;
  final VoidCallback? onConfirmAction;
  final VoidCallback? onCancelAction;
  final bool isConfirming;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == 'user';

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1.0 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser) ...[
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.smart_toy_rounded,
                  color: AppColors.brandPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isUser ? AppColors.brandPrimary : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isUser ? 16 : 4),
                    bottomRight: Radius.circular(isUser ? 4 : 16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isUser ? 0.12 : 0.05,
                      ),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: isUser
                      ? null
                      : Border.all(color: const Color(0xFFE2E8F0), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: isUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    if (!isUser && message.targetAgents.isNotEmpty) ...[
                      Wrap(
                        spacing: 4,
                        children: message.targetAgents.map((agent) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.softBrandBackground,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.auto_awesome,
                                  size: 10,
                                  color: AppColors.brandPrimaryDark,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  agent.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.brandPrimaryDark,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 6),
                    ],
                    AiFormattedTextWidget(
                      content: message.text,
                      isUser: isUser,
                    ),
                    if (!isUser &&
                        message.pendingAction != null &&
                        !message.isConfirmed) ...[
                      const SizedBox(height: 10),
                      AiPendingActionCardWidget(
                        pendingAction: message.pendingAction!,
                        isConfirming: isConfirming,
                        onConfirmAction: onConfirmAction,
                        onCancelAction: onCancelAction,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (isUser) ...[
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.softBrandBackground,
                child: const Icon(
                  Icons.person,
                  color: AppColors.brandPrimaryDark,
                  size: 18,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
