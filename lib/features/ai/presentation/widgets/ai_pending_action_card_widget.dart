import 'package:flutter/material.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import '../../data/models/ai_chat_models.dart';

class AiPendingActionCardWidget extends StatelessWidget {
  const AiPendingActionCardWidget({
    super.key,
    required this.pendingAction,
    this.onConfirmAction,
    this.onCancelAction,
    this.isConfirming = false,
  });

  final PendingActionModel pendingAction;
  final VoidCallback? onConfirmAction;
  final VoidCallback? onCancelAction;
  final bool isConfirming;

  @override
  Widget build(BuildContext context) {
    final summary = pendingAction.summary ??
        pendingAction.action?.summary ??
        'إجراء مقترح';

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.warning_amber_rounded,
                size: 16,
                color: Color(0xFFD97706),
              ),
              SizedBox(width: 6),
              Text(
                'إجراء مقترح يتطلب موافقتك',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF92400E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            summary,
            style: const TextStyle(fontSize: 12, color: Color(0xFF78350F)),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: isConfirming ? null : onConfirmAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(0, 32),
                ),
                icon: isConfirming
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.check, size: 14),
                label: const Text(
                  'تأكيد وتنفيذ',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: onCancelAction,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF64748B),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(0, 32),
                ),
                child: const Text('إلغاء', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
