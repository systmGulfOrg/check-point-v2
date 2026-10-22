import 'package:flutter/material.dart';
import '../widgets/ai_chat_sheet_widget.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.55),
      body: SafeArea(
        bottom: false,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: const AiChatSheetWidget(),
        ),
      ),
    );
  }
}
