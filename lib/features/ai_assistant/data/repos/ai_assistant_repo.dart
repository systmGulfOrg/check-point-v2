import 'package:check_point_v2/core/network/api_result.dart';
import '../models/ai_chat_models.dart';

abstract class AiAssistantRepo {
  Future<ApiResult<AiChatResponseModel>> sendChatMessage({
    required String message,
    String? conversationId,
  });
}
