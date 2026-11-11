import 'package:flutter/material.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';

class AiChatEmptyStateWidget extends StatelessWidget {
  const AiChatEmptyStateWidget({
    super.key,
    required this.onSelectPrompt,
  });

  final void Function(String prompt) onSelectPrompt;

  static const List<Map<String, dynamic>> _quickPrompts = [
    {
      'label': 'رصيد الإجازات الحالي',
      'query': 'ما هو رصيد إجازاتي المتبقي وطلباتي المعلقة؟',
      'icon': Icons.beach_access_rounded,
    },
    {
      'label': 'حضور وتأخيرات اليوم',
      'query': 'من متأخر اليوم وما هو ملخص الحضور؟',
      'icon': Icons.access_time_filled_rounded,
    },
    {
      'label': 'المهام المعلقة',
      'query': 'ما هي مهام العمل النشطة حالياً؟',
      'icon': Icons.assignment_rounded,
    },
    {
      'label': 'تقارير الأداء',
      'query': 'أعطني ملخصاً عن تقارير هذا الأسبوع',
      'icon': Icons.analytics_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppColors.softBrandBackground,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.brandPrimary.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: AppColors.brandPrimary,
                size: 26,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'أهلاً بك في CHECK-POINT AI',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'المساعد الذكي لمتابعة الحضور، الإجازات، مهام العمل، والتقارير التنفيذية بدقة وأمان.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: const Text(
                'اقتراحات سريعة للبدء:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF475569),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ..._quickPrompts.map((p) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () => onSelectPrompt(p['query'] as String),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          p['icon'] as IconData,
                          size: 18,
                          color: AppColors.brandPrimary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            p['label'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 13,
                          color: Color(0xFF94A3B8),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
