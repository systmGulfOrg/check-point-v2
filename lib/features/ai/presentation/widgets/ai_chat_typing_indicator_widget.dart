import 'package:flutter/material.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';

class AiChatTypingIndicatorWidget extends StatelessWidget {
  const AiChatTypingIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.smart_toy_rounded,
              color: AppColors.brandPrimary,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                AiTypingDotWidget(),
                SizedBox(width: 4),
                AiTypingDotWidget(),
                SizedBox(width: 4),
                AiTypingDotWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AiTypingDotWidget extends StatelessWidget {
  const AiTypingDotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: const BoxDecoration(
        color: AppColors.brandPrimary,
        shape: BoxShape.circle,
      ),
    );
  }
}
