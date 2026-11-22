import 'package:check_point_v2/core/core.dart';
import '../models/ai_chat_models.dart';

abstract class AiRepo {
  Future<ApiResult<AiSettingsModel>> getSettings();
  Future<ApiResult<AiSettingsModel>> updateSettings({
    required bool enabled,
    String? apiKey,
  });
  Future<ApiResult<AiChatResponseModel>> sendMessage(
    String message, {
    String? threadId,
  });

  Future<ApiResult<String>> confirmAction(
    String actionId, {
    bool confirmed = true,
  });
}
