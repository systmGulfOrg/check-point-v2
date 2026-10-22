import 'package:check_point_v2/core/network/api_result.dart';
import '../models/ai_chat_models.dart';

abstract class AiRepo {
  Future<ApiResult<AiChatResponseModel>> sendMessage(
    String message, {
    String? threadId,
  });

  Future<ApiResult<String>> confirmAction(
    String actionId, {
    bool confirmed = true,
  });
}
