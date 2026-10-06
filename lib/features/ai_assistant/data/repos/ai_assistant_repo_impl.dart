import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import '../apis/ai_assistant_api_service.dart';
import '../models/ai_chat_models.dart';
import 'ai_assistant_repo.dart';

class AiAssistantRepoImpl implements AiAssistantRepo {
  AiAssistantRepoImpl({required this.api});

  final AiAssistantApiService api;

  @override
  Future<ApiResult<AiChatResponseModel>> sendChatMessage({
    required String message,
    String? conversationId,
  }) async {
    try {
      final body = AiChatRequestBody(
        message: message,
        conversationId: conversationId,
      );
      final response = await api.sendChatMessage(body);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
