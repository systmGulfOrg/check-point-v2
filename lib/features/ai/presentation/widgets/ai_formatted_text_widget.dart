import 'package:flutter/material.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';

class AiFormattedTextWidget extends StatelessWidget {
  const AiFormattedTextWidget({
    super.key,
    required this.content,
    required this.isUser,
  });

  final String content;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final lines = content.split('\n');
    final textColor = isUser ? Colors.white : const Color(0xFF1E293B);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        if (line.trim().isEmpty) {
          return const SizedBox(height: 4);
        }

        final isBullet =
            line.trim().startsWith('- ') || line.trim().startsWith('* ');
        final cleanLine = isBullet ? line.trim().substring(2) : line;

        // Parse bold **text**
        final spans = <TextSpan>[];
        final parts = cleanLine.split(RegExp(r'(\*\*.*?\*\*)'));

        for (final part in parts) {
          if (part.startsWith('**') && part.endsWith('**')) {
            spans.add(
              TextSpan(
                text: part.substring(2, part.length - 2),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: 14,
                ),
              ),
            );
          } else {
            spans.add(
              TextSpan(
                text: part,
                style: TextStyle(color: textColor, fontSize: 14, height: 1.4),
              ),
            );
          }
        }

        if (isBullet) {
          return Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2, right: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 6, right: 2),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: isUser ? Colors.white70 : AppColors.brandPrimary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(text: TextSpan(children: spans)),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.5),
          child: RichText(text: TextSpan(children: spans)),
        );
      }).toList(),
    );
  }
}
