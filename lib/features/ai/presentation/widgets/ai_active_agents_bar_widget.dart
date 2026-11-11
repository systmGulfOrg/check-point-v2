import 'package:flutter/material.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'ai_agent_chip_widget.dart';

class AiActiveAgentsBarWidget extends StatelessWidget {
  const AiActiveAgentsBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.auto_awesome,
            size: 13,
            color: AppColors.brandPrimary,
          ),
          const SizedBox(width: 6),
          const Text(
            'الوكلاء المتاحون:',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  AiAgentChipWidget(name: 'HR'),
                  AiAgentChipWidget(name: 'Attendance'),
                  AiAgentChipWidget(name: 'Tasks'),
                  AiAgentChipWidget(name: 'Reports'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
